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
package com.fastcms.web.controller.api;

import com.egzosn.pay.common.bean.result.PayException;
import com.egzosn.pay.common.exception.PayErrorException;
import com.egzosn.pay.common.util.MatrixToImageWriter;
import com.fastcms.common.constants.FastcmsConstants;
import com.fastcms.common.model.RestResult;
import com.fastcms.common.model.RestResultUtils;
import com.fastcms.entity.Order;
import com.fastcms.payment.PayServiceManager;
import com.fastcms.payment.bean.FastcmsPayOrder;
import com.fastcms.service.IOrderService;
import com.fastcms.utils.I18nUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

import static com.fastcms.service.IOrderService.OrderI18n.ORDER_NOT_EXIST;
import static com.fastcms.service.IOrderService.OrderI18n.ORDER_PAY_AMOUNT_ERROR;

/**
 * 支付
 * @author： wjun_java@163.com
 * @date： 2022/1/23
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
@RestController
@RequestMapping(FastcmsConstants.API_MAPPING + "/pay")
public class PaymentApi {

    @Autowired
    private PayServiceManager payServiceManager;

    @Autowired
    private IOrderService orderService;

    /**
     * 扫码支付 | 返回图片流
     * @param platform 支付平台
     * @param type     支付方式
     * @param orderId
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "{platform}/{type}/toQrPay.jpg", produces = "image/jpeg;charset=UTF-8")
    public byte[] toQrPay(@PathVariable("platform") String platform, @PathVariable("type") String type, @RequestParam("orderId") Long orderId) throws PayErrorException {
        Order order = orderService.getById(orderId);
        BigDecimal price = order.getPayAmount();
        //获取对应的支付账户操作工具（可根据账户id）
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        try {
            ImageIO.write(MatrixToImageWriter.writeInfoToJpgBuff(payServiceManager.getQrPay(new FastcmsPayOrder(platform, type, order.getOrderTitle(), order.getRemarks(), null == price ? BigDecimal.valueOf(0.01) : price, order.getOrderSn()))), "JPEG", outputStream);
        } catch (IOException e) {
            throw new PayErrorException(new PayException("500", e.getMessage()));
        }
        return outputStream.toByteArray();
    }

    /**
     * 扫码支付 | 返回图片url
     * @param platform
     * @param orderId
     * @return
     */
    @RequestMapping(value = "{platform}/{type}/getQrPay")
    public String getQrPay(@PathVariable("platform") String platform, @PathVariable("type") String type, @RequestParam("orderId") Long orderId) throws PayErrorException {
        //获取对应的支付账户操作工具（可根据账户id）
        Order order = getOrder(orderId);
        return payServiceManager.getQrPay(new FastcmsPayOrder(platform, type, order.getOrderTitle(), order.getRemarks(), order.getPayAmount(), order.getOrderSn()));
    }

    /**
     * 公众号支付
     * @param platform
     * @param orderId
     * @param openid
     * @return
     */
    @RequestMapping(value = "{platform}/{type}/jsapi")
    public RestResult<Map<String, Object>> toPay(@PathVariable("platform") String platform, @PathVariable("type") String type, @RequestParam("orderId") Long orderId, @RequestParam("openid") String openid) throws PayErrorException {

        Order order = getOrder(orderId);

        FastcmsPayOrder fastcmsPayOrder = new FastcmsPayOrder(platform, type, order.getOrderTitle(), order.getRemarks(), order.getPayAmount(), order.getOrderSn());
        fastcmsPayOrder.setOpenid(openid);

        Map orderInfo = payServiceManager.getOrderInfo(fastcmsPayOrder);

        return RestResultUtils.success(orderInfo);
    }

    /**
     * app支付 | 获取支付预订单信息
     * @param platform
     * @param orderId
     * @return
     */
    @RequestMapping("{platform}/{type}/app")
    public RestResult<Map<String, Object>> app(@PathVariable("platform") String platform, @PathVariable("type") String type, @RequestParam("orderId") Long orderId) throws PayErrorException {
        Order order = getOrder(orderId);
        FastcmsPayOrder fastcmsPayOrder = new FastcmsPayOrder(platform, type, order.getOrderTitle(), order.getRemarks(), order.getPayAmount(), order.getOrderSn());
        return RestResultUtils.success(payServiceManager.app(fastcmsPayOrder));
    }

    /**
     * 刷卡付 | pos主动扫码付款(条码付)
     * @param platform        支付平台
     * @param orderId       文章id
     * @param authCode        授权码，条码等
     * @return 支付结果
     */
    @RequestMapping(value = "{platform}/{type}/microPay")
    public RestResult<Map<String, Object>> microPay(@PathVariable("platform") String platform, @PathVariable("type") String type, @RequestParam("orderId") Long orderId, @RequestParam("authCode") String authCode) throws PayErrorException {

        Order order = getOrder(orderId);

        //获取对应的支付账户操作工具（可根据账户id）
        //条码付
        FastcmsPayOrder fastcmsPayOrder = new FastcmsPayOrder(platform, type, order.getOrderTitle(), order.getRemarks(), order.getPayAmount(), order.getOrderSn());
        //设置授权码，条码等
        fastcmsPayOrder.setAuthCode(authCode);
        //支付结果
        Map<String, Object> params = payServiceManager.microPay(fastcmsPayOrder);
        //校验
        if (payServiceManager.verify(platform, params)) {
            //支付校验通过后的处理
            //......业务逻辑处理块........
        }
        //这里开发者自行处理
        return RestResultUtils.success(params);
    }

    /**
     * 刷脸付
     * @param platform      支付平台
     * @orderId           文章id
     * @param authCode      人脸凭证
     * @param openid        用户在商户 appid下的唯一标识
     * @return 支付结果
     */
    @RequestMapping(value = "{platform}/{type}/facePay")
    public RestResult<Map<String, Object>> facePay(@PathVariable("platform") String platform, @PathVariable("type") String type, @RequestParam("orderId") Long orderId, @RequestParam("authCode") String authCode, @RequestParam("openid") String openid) throws PayErrorException {

        Order order = getOrder(orderId);

        //获取对应的支付账户操作工具（可根据账户id）
        FastcmsPayOrder fastcmsPayOrder = new FastcmsPayOrder(platform, type, order.getOrderTitle(), order.getRemarks(), order.getPayAmount(), order.getOrderSn());
        //设置人脸凭证
        fastcmsPayOrder.setAuthCode(authCode);
        //用户在商户 appid下的唯一标识
        fastcmsPayOrder.setOpenid(openid);
        //支付结果
        Map<String, Object> params = payServiceManager.microPay(fastcmsPayOrder);
        //校验
        if (payServiceManager.verify(platform, params)) {
            //支付校验通过后的处理
            //......业务逻辑处理块........
        }
        //这里开发者自行处理
        return RestResultUtils.success(params);
    }

    Order getOrder(Long orderId) throws PayErrorException {
        Order order = orderService.getById(orderId);
        if (order == null) {
            throw new PayErrorException(new PayException("500", String.format(I18nUtils.getMessage(ORDER_NOT_EXIST), orderId)));
        }
        if (order.getPayAmount() == null || order.getPayAmount().compareTo(BigDecimal.ZERO) <=0) {
            throw new PayErrorException(new PayException("500", I18nUtils.getMessage(ORDER_PAY_AMOUNT_ERROR)));
        }
        return order;
    }

}
