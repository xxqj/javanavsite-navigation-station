<template>
	<div class="system-add-Cmpy-container">
		<el-dialog title="新增公司" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="90px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="公司名称" prop="cmpyName">
							<el-input v-model="ruleForm.cmpyName" placeholder="请输入公司名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="公司简称" prop="cmpySimpleName">
							<el-input v-model="ruleForm.cmpySimpleName" placeholder="请输入公司名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="负责人" prop="cmpyLeader">
							<el-input v-model="ruleForm.cmpyLeader" placeholder="请输入负责人" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="联系电话" prop="cmpyPhone">
							<el-input v-model="ruleForm.cmpyPhone" placeholder="请输入手机号" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sortNum">
							<el-input-number v-model="ruleForm.sortNum" :min="0" :max="999" controls-position="right" placeholder="请输入排序" class="w100" />
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="状态">
							<el-select v-model="ruleForm.status" placeholder="请选择状态" clearable class="w100">
								<el-option label="启用" value="1"></el-option>
								<el-option label="禁用" value="0"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="地址">
							<el-input v-model="ruleForm.cmpyAddr" type="textarea" placeholder="请输入" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="公司描述" prop="cmpyDesc">
							<el-input v-model="ruleForm.cmpyDesc" type="textarea" placeholder="请输入公司描述" maxlength="150"></el-input>
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
import { reactive, toRefs, onMounted, defineComponent, getCurrentInstance } from 'vue';
import { ElMessage } from 'element-plus';
import { saveCompy } from '/@/api/company/index';

// 定义接口来定义对象的类型
interface DeptSate {
	isShowDialog: boolean;
	ruleForm: {
		id: number,
		parentId: number;
		cmpyName: string;
		cmpySimpleName: string;
		cmpyLeader: string;
		cmpyPhone: string | number;
		cmpyAddr: string;
		sortNum: number;
		status: string;
		cmpyDesc: string;
	};
}

export default defineComponent({
	name: 'systemAddCmpy',
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive<DeptSate>({
			isShowDialog: false,
			ruleForm: {
				parentId: 0, // 上级公司
				cmpyName: '', // 公司名称
				cmpySimpleName:'',
				cmpyLeader: '', // 负责人
				cmpyPhone: '', // 手机号
				cmpyAddr: '', // 邮箱
				sortNum: 0, // 排序
				status: '1', // 公司状态
				cmpyDesc: '', // 公司描述
			},
			rules: {
				"cmpyName": { required: true, message: '请输入公司名称', trigger: 'blur' },
				"cmpySimpleName": { required: true, message: '请输入公司名称', trigger: 'blur' },
				"cmpyDesc": { required: true, message: '请输入公司描述', trigger: 'blur' },
			},
		});
		// 打开弹窗
		const openDialog = (row: object) => {
			state.isShowDialog = true;
			if(row) {
				state.ruleForm.parentId = row.id;
			}
		};
		// 关闭弹窗
		const closeDialog = () => {
			state.isShowDialog = false;
			state.ruleForm = {
				sortNum: 0, // 排序
				status: "1", // 部门状态
			};
		};
		// 取消
		const onCancel = () => {
			closeDialog();
		};
		// 新增
		const onSubmit = () => {
			proxy.$refs['myRefForm'].validate((valid: any) => {
				if (valid) {
					console.log(state.ruleForm)
					saveCompy(state.ruleForm).then(() => {
						closeDialog(); // 关闭弹窗
						// initForm();
						ctx.emit("reloadTable");
					}).catch((res) => {
						ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
					})
				}
			});
		};
		// 页面加载时
		onMounted(() => {
		});
		return {
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			...toRefs(state),
		};
	},
});
</script>
