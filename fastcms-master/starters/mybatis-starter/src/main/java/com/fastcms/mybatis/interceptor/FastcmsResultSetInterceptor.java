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

package com.fastcms.mybatis.interceptor;

import org.apache.ibatis.executor.resultset.ResultSetHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.sql.CallableStatement;
import java.sql.Statement;

/**
 * fastcms mybatis result 拦截器
 * @author： wjun_java@163.com
 * @date： 2021/4/26
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
@Intercepts(
        {
                @Signature(type = ResultSetHandler.class, method = "handleResultSets", args = { Statement.class }),
                @Signature(type = ResultSetHandler.class, method = "handleCursorResultSets", args = { Statement.class }),
                @Signature(type = ResultSetHandler.class, method = "handleOutputParameters", args = { CallableStatement.class }),
        }
)
@Component
public class FastcmsResultSetInterceptor implements Interceptor {

    private static final Logger log = LoggerFactory.getLogger(FastcmsResultSetInterceptor.class);

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object target = invocation.getTarget();
        Object[] args = invocation.getArgs();

        if (target instanceof ResultSetHandler) {
            if (args != null && args.length >0) {
                //doSomeThings ...
            }
        }

        return invocation.proceed();
    }

}
