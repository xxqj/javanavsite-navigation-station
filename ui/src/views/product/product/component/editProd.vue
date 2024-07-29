<template>
	<div class="system-edit-prod-container">
		<el-dialog title="新增产品" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="90px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="中文名称" prop="titleZh">
							<el-input v-model="ruleForm.titleZh" placeholder="请输入产品名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="英文名称" prop="titleEn">
							<el-input v-model="ruleForm.titleEn" placeholder="请输入产品名称" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="产品型号" prop="prodMode">
							<el-input v-model="ruleForm.prodMode" placeholder="请输入产品型号" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sortNum">
							<el-input v-model="ruleForm.sortNum" placeholder="请输入排序" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="公司" prop="cmpyId">
							<el-select v-model="ruleForm.cmpyId"  placeholder="请选择公司" clearable class="w100" @change="onHandleCmpyChange">
								
								<el-option v-for="(item,index) in cmpyList" :key="index" :label="item.cmpySimpleName" :value="item.id" />
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="产品分类" prop="categoryId">
							<el-select v-model="ruleForm.categoryId"  placeholder="请选择分类" clearable class="w100">
								
								<el-option v-for="(item,index) in categoryList" :key="index" :label="item.titleZh" :value="item.id" />
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="是否热销" prop="hotFlag">
  							<el-switch  v-model="ruleForm.hotFlag"/>
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
				</el-row>
			</el-form>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="onCancel" size="small">取 消</el-button>
					<el-button type="primary" @click="onSubmit" size="small">修 改</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script lang="ts">
import { reactive, toRefs, onMounted, defineComponent, getCurrentInstance } from 'vue';
import { ElMessage } from 'element-plus';
import { saveProd } from '/@/api/product/prod/index';
import { getCompyList} from '/@/api/company/index';
import { getCategoryList} from '/@/api/product/category/index';
// 定义接口来定义对象的类型
interface ProdSate {
	isShowDialog: boolean;
	cmpyList:[];
	categoryList:[];
	ruleForm: {
		titleZh: string;
		titleEn: string;
		sortNum: number;
		prodMode:string;
		hotFlag:boolean;
		hotSale:string
		id: number;
		cmpyId:number;
		categoryId:number;
		showFlag:string;
	};
}

export default defineComponent({
	name: 'systemEditProd',
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive<ProdSate>({
			isShowDialog: false,
			cmpyList:[],
			categoryList:[],
			showopt:[{ value: 'Y',label: '展示'},{ value: 'N',label: '不展示'}],
			ruleForm: {
				titleZh: '',
				titleEn: '',
				prodMode:'',
				sortNum: 0,
				hotSale:'0',
				topFlag:false,
				id:'',
				cmpyId:'',
				categoryId:'',
				showFlag:'Y',
			},
			rules: {
				"titleZh": { required: true, message: '请输入产品名称', trigger: 'blur' },
				"prodMode": { required: true, message: '请输入产品型号', trigger: 'blur' },
				"cmpyId": [
					{ required: true, message: '请选择公司', trigger: 'blur' },
					{ type: 'number', message: '请选择公司', min:1,trigger: 'blur' },
				  ],
				"categoryId": [
						{ required: true, message: '请选择分类', trigger: 'blur' },
						{ type: 'number', message: '请选择分类', min:1,trigger: 'blur' },
					],
			},
		});
		// 打开弹窗
		const openDialog = (row: object) => {
			state.ruleForm=row;
			if(row) {
				state.ruleForm.id = row.id;
			}
			state.isShowDialog = true;
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
					saveProd(state.ruleForm).then(() => {
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
				state.ruleForm.cmpyId = res.data[0].id;
			}).catch((err) => {
				console.log(err);
			});
			
		}
		const onHandleCmpyChange = (selVal: number) => {
			console.log(selVal);
			state.ruleForm.cmpyId = selVal;
			getCategoryList({cmpyId:state.ruleForm.cmpyId}).then(res => {
				state.categoryList = res.data
				state.ruleForm.categoryId = res.data[0].id;
			})
			
			//initTableData();
		};
		// 页面加载时
		onMounted(() => {
			loadCmpyList();
			
			getCategoryList({cmpyId:state.ruleForm.cmpyId}).then(res => {
				state.categoryList = res.data
			})
		});
		return {
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			onHandleCmpyChange,
			...toRefs(state),
		};
	},
});
</script>
