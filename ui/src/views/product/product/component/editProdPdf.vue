<template>
	<div class="system-edit-pdf-container">
		<el-dialog title="产品pdf" v-model="isShowDialog" width="1000px">
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
					<!-- <el-col class="mb20" :xs="24" :sm="12" :md="12" :lg="12" :xl="12">
					  <el-form-item label="类型" prop="pdfType">
					  	<el-radio-group v-model="ruleForm.pdfType" >
					  		<el-radio v-for="(item,index) in pdfTypeList"  :label="item.value">{{item.label}}</el-radio>
					  	</el-radio-group>
					  </el-form-item>
					</el-col> -->
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="名称" prop="pdfName">
							<el-input v-model="ruleForm.pdfName" placeholder="请输入名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sortNum">
							<el-input v-model="ruleForm.sortNum" placeholder="请输入排序" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="pdf上传">
							
							<el-link v-if="ruleForm.pdfUrl"  :href="ruleForm.pdfUrl" target="_blank" type="success">{{ruleForm.pdfName}}<i class="el-icon-view el-icon--right"></i></el-link>
							<el-upload
								class="upload-btn"
								action="#"
								:http-request="uploadFileZh"
								:before-upload="beforeAvatarUpload"
								name="files"
								accept=".pdf"
								:headers="headers"
								:show-file-list="false"
								:limit="limit">
								<el-button size="small" type="primary">上传文件</el-button>
								 <div slot="tip" class="el-upload__tip">只能上传pdf文件，且不超过3M</div>
							</el-upload>
						</el-form-item>
						<el-form-item label="Pdf" prop="pdfUrl">
							<el-input class="zx-icon__input" v-model="ruleForm.pdfUrl" placeholder="Please input" />
						</el-form-item>
					</el-col>
				</el-row>
			</el-form>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="onCancel" size="small">取 消</el-button>
					<el-button type="primary" @click="onSubmit" size="small">保 存</el-button>
				</span>
			</template>
			<el-table :data="tableData.data" style="width: 100%" row-key="id" default-expand-all
				:tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
				<el-table-column prop="id" label="编号" show-overflow-tooltip width="60"> </el-table-column>
				<el-table-column prop="pdfName" label="名称" show-overflow-tooltip width="180"> </el-table-column>
				
				<!-- <el-table-column prop="pdfType" label="类型" show-overflow-tooltip>
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.pdfType==0">详情图</el-tag>
						<el-tag type="success" v-else-if="scope.row.pdfType==1">主图</el-tag>
						<el-tag type="success" v-else>营销图</el-tag>
					</template>
				</el-table-column> -->
				<el-table-column prop="lang" label="语言" show-overflow-tooltip></el-table-column>
				<el-table-column label="文件" align="center" prop="pdfUrl">
				  <template #default="scope">
					  <el-link  :href="scope.row.pdfUrl" target="_blank" type="success">{{scope.row.pdfName}}<i class="el-icon-view el-icon--right"></i></el-link>
				    <!-- <img :src="scope.row.backgroundUrl" width="80" preview="0"> -->
				   </template>
				</el-table-column>
				<el-table-column prop="sortNum" label="排序" show-overflow-tooltip width="60"> </el-table-column>
				<el-table-column label="操作"  >
					<template #default="scope">
						<el-button size="mini" type="text" @click="onTabelRowDel(scope.row)">删除</el-button>
						<el-button size="mini" type="text" @click="onModifypdf(scope.row)">修改</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-dialog>
	</div>
</template>

<script lang="ts">
import { reactive, toRefs, onMounted, defineComponent, getCurrentInstance } from 'vue';
import { ElMessage,ElMessageBox } from 'element-plus';
import { saveProdPdf,getProdPdf,getProdPdfList,delProdPdf } from '/@/api/product/prod/index';
import { getCompyList} from '/@/api/company/index';
import { getCategoryList} from '/@/api/product/category/index';
import qs from 'qs';
import {uploadPath,addAttach} from "/@/api/attach/index.ts"
import AttachDialog from '/@/components/attach/index.vue';
import { Local, Session } from '/@/utils/storage';

// 定义接口来定义对象的类型
interface ProdpdfSate {
	isShowDialog: boolean;
	cmpyList:[];
	categoryList:[];
	langList:[];
	modeList:[];
	prodMode:string;
	titleZh: string;
	cmpyId:number;
	categoryId:number;
	prodId:number;
	ruleForm: {
		pdfName: string;
		lang:string;
		pdfUrl:string;
		pdfType:number;
		sortNum:number;
		id: number;
		cmpyId:number;
		categoryId:number;
		prodId:number;
		
	};
}

interface TableDataState {
	tableData: {
		data: Array<TableDataRow>;
		loading: boolean;
	};
}

export default defineComponent({
	name: 'systemEditProdpdf',
	components: {
	    AttachDialog,
	},
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive<ProdpdfSate>({
			isShowDialog: false,
			uploadUrl: import.meta.env.VITE_API_URL + "/admin/attachment/upload",
			headers: {"Authorization": Local.get('token')},
			limit: 1,
			cmpyList:[],
			categoryList:[],
			langList:[
				{label:'中文',value:'zh-CN'},
				{label:'英文',value:'en'},
			],
			pdfTypeList:[
				{label:'详情图',value:0},
				{label:'主图',value:1},
				{label:'营销图',value:2},
			],
			titleZh: '',
			prodMode:'',
			cmpyId:'',
			categoryId:'',
			prodId:'',
			lang:'',
			ruleForm: {
				lang:'zh-CN',
				bannerUrl:'',
				pdfType:'',
				sortNum:1,
				bannerName:'',
				id:'',
				cmpyId:'',
				categoryId:'',
				prodId:'',
				
			},
			tableData: {
				data: [],
				loading: false,
			},
			rules: {
				"bannerName": { required: true, message: '请输入产品名称', trigger: 'blur' },
				"lang": { required: true, message: '语言', trigger: 'blur' },
				"bannerUrl": { required: true, message: 'banner图片必须上传', trigger: 'blur' },
				
				
			},
		});
		// 初始化表格数据
		const initTableData = () => {
			getProdPdfList(state.prodId,{in18:state.lang}).then(res => {
				state.tableData.data = res.data
			})
		};
		// 打开弹窗
		const openDialog = (row: object) => {
			state.ruleForm=row;
			
			state.titleZh=row.titleZh,
			state.prodMode=row.prodMode;
			state.cmpyId=row.cmpyId;
			state.categoryId=row.categoryId;
			state.prodId = row.id;
			state.lang = row.lang;
			state.ruleForm.id=0;
			//console.log(state.ruleForm.prodId);
			getProdPdfList(state.prodId,{in18:row.lang}).then(res => {
				state.tableData.data = res.data
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
		
		const onModifypdf = (row: TableDataRow) => {
			getProdPdf(row.id).then(res =>{
				state.ruleForm.id = res.data.id;
				state.ruleForm.pdfType = res.data.pdfType;
				state.ruleForm.sortNum = res.data.sortNum;
				state.ruleForm.pdfUrl = res.data.pdfUrl;
				state.ruleForm.pdfName = res.data.pdfName;
				state.ruleForm.lang = res.data.lang;
				
			})
			
			
		};
		// 删除当前行
		const onTabelRowDel = (row: TableDataRow) => {
			ElMessageBox.confirm(`此操作将永久删除Pdf, 是否继续?`, '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			}).then(() => {
					delProdPdf(row.id).then((res) => {
						if(res.code == 200) {
							ElMessage.success('删除成功');
							initTableData();
						}else{
							ElMessage.success(res.message);
						}
					}).catch((res) => {
					//console.log(res.message);
					ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
				});
				})
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
					saveProdPdf(state.ruleForm).then(() => {
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
		
		
		const beforeAvatarUpload = (file) => {
		    let isJPG = true;
			let fname=file.name.replace(/.+\./,"");
		    if (fname != "pdf") {
		        isJPG=false;
		        ElMessage.error("文件格式错误，请上传文件类型,如：pdf后缀的文件。");
		    }
		    const isLt3M = file.size / 1024 / 1024 < 3;
		    if (!isLt3M) {
		       ElMessage.error('上传文件大小不能超过 3MB!');
		    }
		    return isJPG && isLt3M;
		};
		const uploadFileZh = (params) => {
		  let isPic = true;
		  let fname=params.file.name.replace(/.+\./,"");
		  if (fname != "pdf") {
		      isJPG=false;
		      ElMessage.error("文件格式错误，请上传文件类型,如：pdf后缀的文件。");
		  }
		  state.ruleForm.pdfName = params.file.name;
		  const isLt3M = params.file.size / 1024 / 1024 < 3;
		
		  if (!isLt3M) {
		     ElMessage.error('上传文件大小不能超过 3MB!');
		  }
		  if(isPic && isLt3M){
		    let fd=new FormData();
		    fd.append("files",params.file);
		    addAttach(fd).then((response) => {
		       // debugger
		      if (response.code === 200) {
		           ElMessage.success("文件上传成功");
		           state.ruleForm.pdfUrl= response.data.urls;
		         }else{
		            ElMessage.error(response.message)
		         }
		      })
		  }
		};
		
	    const handleAvatarSuccess = (res, file) => {
	       console.log("---------handleAvatarSuccess---------");
	        //this.form.adPic = URL.createObjectURL(file.raw);
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
			getProdPdfList(state.prodId,{in18:state.ruleForm.lang}).then(res => {
				state.tableData.data = res.data
			})
			
			//initTableData();
		};
		
		// 页面加载时
		onMounted(() => {
			loadCmpyList();
			
			getCategoryList({cmpyId:state.cmpyId}).then(res => {
				state.categoryList = res.data
			})
			
			
		});
		return {
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			onHandleCmpyChange,
			onHandleLanChange,
			onModifypdf,
			beforeAvatarUpload,
			handleAvatarSuccess,
			uploadFileZh,
			onTabelRowDel,
			...toRefs(state),
		};
	},
});
</script>
