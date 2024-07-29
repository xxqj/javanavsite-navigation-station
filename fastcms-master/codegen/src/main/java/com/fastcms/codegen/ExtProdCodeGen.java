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
package com.fastcms.codegen;

/**
 * @author： wjun_java@163.com
 * @date： 2021/4/21
 * @description：
 * @modifiedBy：
 * @version: 1.0
 */
public class ExtProdCodeGen extends AbstractCodeGen {

	@Override
	String getOutputDir() {
		return System.getProperty("user.dir") + "/cms";
	}

	@Override
	protected String getModelName() {
		return "product";
	}

	@Override
	String[] getTableNames() {
		/*return new String[] {"ext_company","ext_prod", "ext_prod_category",  "ext_prod_meta_zh", "ext_prod_meta_en",
				"ext_prod_pdf", "ext_prod_pic","ext_prod_video","ext_prod_banner","ext_cmpy_meta_en","ext_cmpy_meta_zh"};*/
		return new String[]{"ext_prod_banner","ext_company_banner"};
	}

	public static void main(String[] args) throws Exception {
		ExtProdCodeGen extProdCodeGen = new ExtProdCodeGen();
		extProdCodeGen.gen();
	}

}
