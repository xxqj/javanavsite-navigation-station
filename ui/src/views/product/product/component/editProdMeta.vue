<template>
	<div class="system-edit-meta-container">
		<el-dialog title="产品信息" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="90px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="名称" prop="titleZh">
							<el-input v-model="titleZh" placeholder="请输入产品名称" :disabled="true"></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="产品型号" prop="prodMode">
							<el-input v-model="prodMode" placeholder="请输入产品型号" :disabled="true"></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="公司" prop="cmpyId">
							<el-select v-model="cmpyId"  placeholder="请选择公司" disabled class="w100" @change="onHandleCmpyChange">
								
								<el-option v-for="(item,index) in cmpyList" :key="index" :label="item.cmpySimpleName" :value="item.id" />
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="产品分类" prop="categoryId">
							<el-select v-model="categoryId"  placeholder="请选择分类" disabled class="w100">
								
								<el-option v-for="(item,index) in categoryList" :key="index" :label="item.titleZh" :value="item.id" />
							</el-select>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="语言" prop="lang">
							<el-radio-group v-model="ruleForm.lang" @change="onHandleLanChange">
								<el-radio v-for="(item,index) in langList"  :label="item.value">{{item.label}}</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="产品名称" prop="title">
							<el-input v-model="ruleForm.title" placeholder="请输入产品名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col class="mb20">
					    <el-form-item label="产品参数" prop="prodArgs">
					        <ckeditor v-model="ruleForm.prodArgs"></ckeditor>
					    </el-form-item>
					</el-col>
					<el-col class="mb20">
					    <el-form-item label="产品详情" prop="prodDesc">
					        <ckeditor v-model="ruleForm.prodDesc"></ckeditor>
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
import { saveProductMeta,getProductMeta } from '/@/api/product/prod/index';
import { getCompyList} from '/@/api/company/index';
import { getCategoryList} from '/@/api/product/category/index';
import qs from 'qs';
import CKEditor from "/@/components/ckeditor/index.vue";
import AttachDialog from '/@/components/attach/index.vue';
// 定义接口来定义对象的类型
interface ProdMetaSate {
	isShowDialog: boolean;
	cmpyList:[];
	categoryList:[];
	langList:[];
	prodMode:string;
	titleZh: string;
	cmpyId:number;
	categoryId:number;
	prodId:number;
	ruleForm: {
		title: string;
		lang:string;
		prodDesc:string;
		prodArgs:string;
		id: number;
		cmpyId:number;
		categoryId:number;
		prodId:number;
		
	};
}

export default defineComponent({
	name: 'systemEditProd',
	components: {
	    AttachDialog,
	    ckeditor: CKEditor
	},
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive<ProdMetaSate>({
			isShowDialog: false,
			cmpyList:[],
			categoryList:[],
			langList:[
				{label:'中文',value:'zh-CN'},
				{label:'英文',value:'en'},
			],
			titleZh: '',
			prodMode:'',
			cmpyId:'',
			categoryId:'',
			prodId:'',
			ruleForm: {
				lang:'zh-CN',
				prodDesc:'',
				prodArgs:'',
				title:'',
				id:'',
				cmpyId:'',
				categoryId:'',
				prodId:'',
				
			},
			rules: {
				"title": { required: true, message: '请输入产品名称', trigger: 'blur' },
				"lang": { required: true, message: '语言', trigger: 'blur' },
				
			},
		});
		// 打开弹窗
		const openDialog = (row: object) => {
			state.ruleForm=row;
			
			state.titleZh=row.titleZh,
			state.prodMode=row.prodMode;
			state.cmpyId=row.cmpyId;
			state.categoryId=row.categoryId;
			state.prodId = row.id;
			state.ruleForm.id=0;
			//console.log(state.ruleForm.prodId);
			getProductMeta(state.prodId,{in18:row.lang}).then(res => {
				if(res.data.prodArgs=='')res.data.prodArgs='什么也没留下';
				if(res.data.prodDesc=='')res.data.prodDesc='什么也没留下';
				state.ruleForm = res.data
			})
			state.isShowDialog = true;
		};
		// 关闭弹窗
		const closeDialog = () => {
			state.isShowDialog = false;
			
		};
		// 取消
		const onCancel = () => {
			closeDialog();
		};
		// 新增
		const onSubmit = () => {
			proxy.$refs['myRefForm'].validate((valid: any) => {
				if (valid) {
					state.ruleForm.cmpyId=state.cmpyId;
					state.ruleForm.categoryId=state.categoryId;
					state.ruleForm.prodId = state.prodId;
					console.log(state.ruleForm);
					let params = qs.stringify(state.ruleForm, {arrayFormat: 'repeat'});
					saveProductMeta(state.ruleForm).then(() => {
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
			
		};
		const initEditor = ()  => {
		    /*
		      CKEditor.create(document.querySelector('.CKEditorContent'), {
		        language: 'zh-cn',
		      }).then(editor => {
		        const toolbarContainer = document.querySelector('#toolbar-container');
		        toolbarContainer.appendChild(editor.ui.view.toolbar.element);
		        this.editor = editor
		      }).catch(e=>{
		        console.log(e)
		      });
			  */
		    };

		const onHandleCmpyChange = (selVal: number) => {
			console.log(selVal);
			state.cmpyId = selVal;
			getCategoryList({cmpyId:state.cmpyId}).then(res => {
				state.categoryList = res.data
				state.categoryId = res.data[0].id;
			})
			
			//initTableData();
		};
		
		const onHandleLanChange = (selVal: number) => {
			console.log(selVal);
			state.ruleForm.lang = selVal;
			getProductMeta(state.prodId,{in18:state.ruleForm.lang}).then(res => {
				if(res.data.prodArgs=='')res.data.prodArgs='什么也没留下';
				if(res.data.prodDesc=='')res.data.prodDesc='什么也没留下';
				state.ruleForm = res.data
			})
			
			//initTableData();
		};
		
		
		const onEditorReady = (editor) => {
		    console.log(editor);
		};
		// 页面加载时
		onMounted(() => {
			loadCmpyList();
			
			getCategoryList({cmpyId:state.cmpyId}).then(res => {
				state.categoryList = res.data
			})
			initEditor();
			
		});
		return {
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			onHandleCmpyChange,
			onHandleLanChange,
			 onEditorReady,
			...toRefs(state),
		};
	},
});
</script>
