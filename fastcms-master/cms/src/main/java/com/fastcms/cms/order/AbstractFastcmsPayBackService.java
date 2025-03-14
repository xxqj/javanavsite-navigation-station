/**
 * Copyright (c) 广州小橘灯信息科技有限公司 2016-2017, wjun_java@163.com.
 * <p>
 * Licensed under the GNU Lesser General Public License (LGPL) ,Version 3.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.gnu.org/licenses/lgpl-3.0.txt
 * http://www.xjd2020.com
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.fastcms.cms.order;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.egzosn.pay.common.bean.PayMessage;
import com.fastcms.common.exception.FastcmsException;
import com.fastcms.common.utils.StrUtils;
import com.fastcms.entity.Order;
import com.fastcms.entity.OrderItem;
import com.fastcms.entity.PaymentRecord;
import com.fastcms.service.IOrderItemService;
import com.fastcms.service.IOrderService;
import com.fastcms.service.IPaymentRecordService;
import com.fastcms.utils.I18nUtils;
import com.fastcms.utils.PluginUtils;
import com.fastcms.utils.RequestUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import static com.fastcms.service.IOrderService.OrderI18n.ORDER_ALREADY_PAYED_SN;
import static com.fastcms.service.IOrderService.OrderI18n.ORDER_NOT_EXIST;

/**
 * 各支付平台支付回调逻辑处理基类
 * 处理订单支付后通用逻辑
 *
 * @Component
 * public class WechatPayBackService extends AbstractFastcmsPayBackService {
 *
 *     @Override
 *     protected void setPaymentRecordPlatformInfo(PaymentRecord paymentRecord, PayMessage payMessage) {
 *         WxPayMessage wxPayMessage = (WxPayMessage) payMessage;
 *         ... doSomethings()
 *     }
 *
 * }
 *
 * @author： wjun_java@163.com
 * @date： 2022/04/01
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
public abstract class AbstractFastcmsPayBackService implements IFastcmsPayBackService {

    @Autowired
    private IPaymentRecordService paymentRecordService;

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IOrderItemService orderItemService;

    @Override
    public void payBackOrder(PayMessage payMessage) throws FastcmsException {

        final String orderSn = payMessage.getOutTradeNo();
        Order order = orderService.getOne(Wrappers.<Order>lambdaQuery().eq(Order::getOrderSn, orderSn));
        if(order == null) {
            throw new FastcmsException(String.format(I18nUtils.getMessage(ORDER_NOT_EXIST), orderSn));
        }

        if (order.getPayStatus() == Order.STATUS_PAY_SUCCESS) {
            throw new FastcmsException(String.format(I18nUtils.getMessage(ORDER_ALREADY_PAYED_SN), orderSn));
        }

        order.setPayStatus(Order.STATUS_PAY_SUCCESS);
        order.setTradeStatus(Order.TRADE_STATUS_COMPLETED);
        orderService.updateById(order);

        List<OrderItem> orderItems = orderItemService.list(Wrappers.<OrderItem>lambdaQuery().eq(OrderItem::getOrderId, order.getId()));
        orderItems.forEach(item -> {
            PaymentRecord paymentRecord = new PaymentRecord();
            paymentRecord.setTrxNo(orderSn);
            paymentRecord.setTrxType(PaymentRecord.TRX_TYPE_ORDER);
            paymentRecord.setTrxNonceStr(StrUtils.uuid());
            paymentRecord.setPayType(payMessage.getPayType());
            paymentRecord.setOrderIp(RequestUtils.getIpAddress(RequestUtils.getRequest()));
            paymentRecord.setPayStatus(Order.STATUS_PAY_SUCCESS);
            paymentRecord.setProductRelativeId(item.getProductId());
            paymentRecord.setPayAmount(item.getTotalAmount());
            paymentRecord.setPayerFee(BigDecimal.ZERO);
            paymentRecord.setPaySuccessAmount(item.getTotalAmount());
            paymentRecord.setCreateUserId(order.getCreateUserId());
            paymentRecord.setCreated(LocalDateTime.now());
            paymentRecord.setPaySuccessTime(LocalDateTime.now());
            paymentRecord.setPayStatus(Order.STATUS_PAY_SUCCESS);
            processPaymentRecordBeforePersistence(paymentRecord, payMessage);
            paymentRecordService.save(paymentRecord);
        });

        /**
         * 遍历所有插件中的订单业务扩展
         * 符合条件的订单，处理对应的业务逻辑
         */
        List<IPayBackProcessOrderService> extensions = PluginUtils.getExtensions(IPayBackProcessOrderService.class);
        extensions.forEach(item -> {
            try {
                if (item.isMatch(order)) {
                    item.processOrder(order);
                }
            } catch (FastcmsException e) {
                e.printStackTrace();
            }
        });

    }

    /**
     * 持久化支付记录之前的拦截处理
     * 会覆盖之前设置过的属性
     * @param paymentRecord
     * @param payMessage
     */
    protected abstract void processPaymentRecordBeforePersistence(PaymentRecord paymentRecord, PayMessage payMessage);

}
