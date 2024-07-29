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
package com.fastcms.payment;

import com.egzosn.pay.common.api.PayService;
import com.egzosn.pay.common.bean.BasePayType;
import com.egzosn.pay.common.http.HttpConfigStorage;

/**
 * 支付平台
 * @author： wjun_java@163.com
 * @date： 2021/6/21
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
public interface PaymentPlatform<S extends PayService> extends BasePayType {

    /**
     * 获取商户平台
     * @return 商户平台
     */
    String getPlatform();

    /**
     * 获取支付平台对应的支付服务
     * @return 支付服务
     */
    S getPayService();

    /**
     * 获取支付平台对应的支付服务
     * @param httpConfigStorage 网络配置
     * @return 支付服务
     */
    S getPayService(HttpConfigStorage httpConfigStorage);

}
