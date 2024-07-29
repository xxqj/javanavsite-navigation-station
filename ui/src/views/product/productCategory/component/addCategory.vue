<template>
	<div class="system-add-Category-container">
		<el-dialog title="新增分类" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="90px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="中文名称" prop="titleZh">
							<el-input v-model="ruleForm.titleZh" placeholder="请输入分类名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="英文名称" prop="titleEn">
							<el-input v-model="ruleForm.titleEn" placeholder="请输入分类名称" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sortNum">
							<el-input v-model="ruleForm.sortNum" placeholder="请输入排序" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="归属公司" prop="cmpyId">
							<el-select v-model="ruleForm.cmpyId"  placeholder="请选择公司" clearable class="w100">
								<el-option :value="0" :lable="请选择公司"/>
								<el-option v-for="(item,index) in cmpyList" :key="index" :label="item.cmpySimpleName" :value="item.id" />
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="是否在小程序展示" prop="showFlag">
							<el-select v-model="ruleForm.showFlag"  placeholder="请选择" clearable class="w100">
								
								<el-option
								      v-for="item in showopt"
								      :key="item.value"
								      :label="item.label"
								      :value="item.value">
								    </el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="是否置顶" prop="topFlag">
  							<el-switch  v-model="ruleForm.topFlag"/>
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
import { saveCategory } from '/@/api/product/category/index';
import { getCompyList} from '/@/api/company/index';

// 定义接口来定义对象的类型
interface CategorySate {
	isShowDialog: boolean;
	cmpyList:[];
	showopt:[],
	ruleForm: {
		titleZh: string;
		titleEn: string;
		sortNum: number;
		hasTop: number;
		topFlag:boolean;
		id: number;
		cmpyId:number;
		showFlag:string;
	};
}

export default defineComponent({
	name: 'systemAddCategory',
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive<CategorySate>({
			isShowDialog: false,
			cmpyList:[],
			showopt:[{ value: 'Y',label: '展示'},{ value: 'N',label: '不展示'}],
			ruleForm: {
				titleZh: '',
				titleEn: '',
				sortNum: 0,
				hasTop: 0,
				topFlag:false,
				id: 0,
				cmpyId:0,
				showFlag:'Y',
			},
			rules: {
				"titleZh": { required: true, message: '请输入分类名称', trigger: 'blur' },
				"cmpyId": [
					{ required: true, message: '请选择公司', trigger: 'blur' },
					{ type: 'number', message: '请选择公司', min:1,trigger: 'blur' },
					],
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
					saveCategory(state.ruleForm).then(() => {
						closeDialog(); // 关闭弹窗
						//initForm();
						ctx.emit("reloadTable");
					}).catch((res) => {
						ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
					})
				}
			});
		};
		const loadCmpyList = () => {
			
			getCompyList().then((res) => {
				state.cmpyList = res.data;
			}).catch((err) => {
				console.log(err);
			});
		}
		// 页面加载时
		onMounted(() => {
			loadCmpyList();
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
