<template>
	<div class="system-menu-container">
		<el-dialog title="新增分类" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="80px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="分类名称" prop="menuName">
							<el-input v-model="ruleForm.menuName" placeholder="分类名称" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="是否隐藏">
							<el-select v-model="ruleForm.isHide" placeholder="请选择是否隐藏" clearable class="w100">
								<el-option label="是" value="hidden"></el-option>
								<el-option label="否" value="show"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<!-- <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="是否缓存">
							<el-select v-model="ruleForm.isKeepAlive" placeholder="请选择是否缓存" clearable class="w100">
								<el-option label="是" value="true"></el-option>
								<el-option label="否" value="false"></el-option>
							</el-select>
						</el-form-item>
					</el-col> -->
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序">
							<el-input v-model="ruleForm.menuSort" type="number" placeholder="请输入排序" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="分类图标" prop="menuIcon">
							 <IconSelector type='awe' placeholder="请输入菜单图标" v-model="ruleForm.menuIcon" />
							  <!-- <e-icon-picker v-model="ruleForm.menuIcon"/> -->
						</el-form-item>
					</el-col>
					
				</el-row>
			</el-form>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="onCancel" size="small">取 消</el-button>
					<el-button type="primary" @click="onSubmit" size="small">新 增</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script lang="ts">
import { reactive, toRefs, getCurrentInstance } from 'vue';
import { ElMessage } from 'element-plus';
import IconSelector from '/@/components/iconSelector/index.vue';
import { saveNavMenu } from '/@/api/navsite/navmenu/index';




export default {
	name: 'systemAddNavMenu',
	components: {IconSelector},
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive({
			isShowDialog: false,
			/**
			 * 参数请参考 `/src/router/route.ts` 中的 `dynamicRoutes` 路由菜单格式（请注意参数类型！）
			 * 受到 `element plus` 类型 `string/number/object` 影响，不可使用 `:value="true"`
			 * 的写法，所以传值到后台时，需要转换成布尔值，否则页面可能出现玄学。
			 * 路由权限标识为数组格式，基本都需要自行转换类型
			 */
			ruleForm: {
				name: '', // 路由名称
				path: '',
				parentId:'',
				state:'',
				component: '', // 组件地址
				// isLink: '', // 是否外链
				menuSort: '', // 菜单排序
				menuName: '', // 菜单名称
				menuIcon: '', // 菜单图标
				isHide: 'show', // 是否隐藏
				isKeepAlive: '', // 是否缓存
				isAffix: '', // 是否固定
				isLink: '', // 是否外链，开启外链条件，`1、isLink:true 2、链接地址不为空`
				isIframe: '', // 是否内嵌，开启条件，`1、isIframe:true 2、链接地址不为空`
				auth: '', // 路由权限标识（多个请用逗号隔开），最后转成数组格式
			},
			rules: {
				"menuName": { required: true, message: '请输入分类名称', trigger: 'blur' },
			},
		});
		// 打开弹窗
		const openDialog = (row?: object) => {
			console.log(row);
			state.isShowDialog = true;
			if(row) {
				state.ruleForm.parentId=row.id;
			}
		};
		// 关闭弹窗
		const closeDialog = (row?: object) => {
			console.log(row);
			state.isShowDialog = false;
		};
		// 是否内嵌下拉改变
		const onSelectIframeChange = () => {
			if (state.ruleForm.isIframe === 'true') {
				state.ruleForm.isLink = 'true';
			} else {
				state.ruleForm.isLink = '';
			}
		};
		// 取消
		const onCancel = () => {
			closeDialog();
			initForm();
		};

		// 新增
		const onSubmit = () => {

			proxy.$refs['myRefForm'].validate((valid: any) => {
				if (valid) {
					saveNavMenu(state.ruleForm).then(() => {
						closeDialog(); // 关闭弹窗
						// 刷新菜单，未进行后端接口测试
						initForm();
						ctx.emit("reloadTable");
					}).catch((res) => {
						ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
					})
				}
			});

		};
		
		// 表单初始化，方法：`resetFields()` 无法使用
		const initForm = () => {
			state.ruleForm.name = '';
			state.ruleForm.path = '';
			state.ruleForm.component = '';
			state.ruleForm.isLink = '';
			state.ruleForm.menuSort = '';
			state.ruleForm.menuName = '';
			state.ruleForm.menuIcon = '';
			state.ruleForm.isHide = 'show';
			state.ruleForm.isKeepAlive = '0';
			state.ruleForm.isAffix = '';
			state.ruleForm.isIframe = '';
			state.ruleForm.auth = '';
		};
		return {
			openDialog,
			closeDialog,
			onSelectIframeChange,
			onCancel,
			onSubmit,
			...toRefs(state),
		};
	},
};
</script>
