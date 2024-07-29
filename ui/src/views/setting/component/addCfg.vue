<template>
	<div class="system-cfg-container">
		<el-dialog title="编辑参数" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="80px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="参数key" prop="key">
							<el-input v-model="ruleForm.key" placeholder="请输入参数key" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="类型">
							<el-select v-model="ruleForm.typeId" placeholder="请选择" clearable class="w100">
								<el-option label="系统参数" value="1"></el-option>
								<el-option label="公用参数" value="2"></el-option>
								<el-option label="用户参数" value="3"></el-option>
								<el-option label="参数列表" value="4"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sortNum">
							<el-input type="number" v-model="ruleForm.sortNum" placeholder="排序" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="参数value" prop="value">
							<el-input type="textarea" v-model="ruleForm.value" placeholder="请输入参数value" clearable></el-input>
						</el-form-item>
					</el-col>
					
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="参数描述">
							<el-input  type="textarea" v-model="ruleForm.label" placeholder="请输入参数描述" clearable></el-input>
						</el-form-item>
					</el-col>
					
				</el-row>
			</el-form>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="onCancel" size="small">取 消</el-button>
					<el-button type="primary" @click="onSubmit" size="small">编 辑</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script lang="ts">
import { reactive, ref,toRefs, onMounted,getCurrentInstance } from 'vue';
import IconSelector from '/@/components/iconSelector/index.vue';
import { ElMessage } from 'element-plus';
import { editCfg} from '/@/api/config/index';
import { Local, Session } from '/@/utils/storage';
export default {
	name: 'templateEditMenu',
	components: { IconSelector },
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const casRef =ref();
		const state = reactive({
			isShowDialog: false,
			ruleForm: {
				id: '',
				sortNum: '',
				key: '',
				value:'',
				label:'',
				typeId:'',
			},
			rules: {
				"key": { required: true, message: '请输入参数key', trigger: 'blur' },
				"value": { required: true, message: '请输入参数value', trigger: 'blur' },
				"typeId": { required: true, message: '请选择分类', trigger: 'blur' },
			},
		});
		// 打开弹窗
		const openDialog = (row: any) => {
			console.log(row);
			state.isShowDialog = true;
			initForm ();
		};
		// 关闭弹窗
		const closeDialog = (row?: object) => {
			// eslint-disable-next-line no-console
			console.log(row);
			state.isShowDialog = false;
				initForm();
		};
		
		// 取消
		const onCancel = () => {
			closeDialog();
		
		};
		// 新增
		const onSubmit = () => {
			
			proxy.$refs['myRefForm'].validate((valid: any) => {
				if (valid) {
					editCfg(state.ruleForm).then(() => {
						closeDialog(); // 关闭弹窗
						ctx.emit("reloadTable");
					}).catch((res) => {
						ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
					})
				}
			});
		};

		// 表单初始化，方法：`resetFields()` 无法使用
		const initForm = () => {
			state.ruleForm.id = '';
			state.ruleForm.key = '';
			state.ruleForm.value = '';
			state.ruleForm.label ='';
			state.ruleForm.typeId = '3';
			state.ruleForm.sortNum = '';
		};
		const handleChange = (value) => {
		 
		  
		};
		
		
		// 页面加载时
		onMounted(() => {
		
		});
		
		return {
			casRef,
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			...toRefs(state),
		};
	},
};
</script>
