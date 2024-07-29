<template>
	<div class="system-edit-banner-container">
		<el-dialog title="banner图片编辑" v-model="isShowDialog" width="960px">
			<el-form :model="ruleForm" size="small" label-width="130px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="中文图片上传">
							<img v-if="ruleForm.bannerZh" :src="ruleForm.bannerZh" class="avatar" width="100" height="80"/>
							
							<el-upload
								class="upload-btn"
								action="#"
								:http-request="uploadFileZh"
								:before-upload="beforeAvatarUpload"
								name="files"
								:headers="headers"
								:show-file-list="false"
								:limit="limit">
								<el-button size="small" type="primary">上传附件</el-button>
							</el-upload>
						</el-form-item>
						<el-form-item label="中文图片链接">
							<el-input class="zx-icon__input" v-model="ruleForm.bannerZh" placeholder="Please input" />
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="英文图片上传">
							<img v-if="ruleForm.bannerEn" :src="ruleForm.bannerEn" class="avatar" width="100" height="80"/>
							<el-upload
								class="upload-btn"
								action="#"
								:http-request="uploadFileEn"
								:before-upload="beforeAvatarUpload"
								name="files"
								multiple
								:headers="headers"
								:show-file-list="false"
								:limit="limit">
								<el-button size="small" type="primary">上传附件</el-button>
							</el-upload>
						</el-form-item>
						<el-form-item label="英文图片链接">
							<el-input class="zx-icon__input" v-model="ruleForm.bannerEn" placeholder="Please input" />
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
		</el-dialog>
	</div>
</template>

<script lang="ts">
import {uploadPath,addAttach} from "/@/api/attach/index.ts"
import { reactive, toRefs, onMounted, defineComponent, getCurrentInstance } from 'vue';
import { ElMessage } from 'element-plus';
import { saveCategory } from '/@/api/product/category/index';
import { getCompyList } from '/@/api/company/index';
import { Local, Session } from '/@/utils/storage';

// 定义接口来定义对象的类型

// 定义接口来定义对象的类型
interface RuleFormState {
	titleZh: string;
	titleEn: string;
	iconZh: string;
	iconEn: string;
	bannerZh: string;
	bannerEn: string;
	sortNum: number;
	hasTop: number;
	id: number;
	cmpyId:number;
	cmpyName:string;
	created:string;
}
interface DeptSate {
	isShowDialog: boolean;
	ruleForm: RuleFormState;
}

export default defineComponent({
	name: 'editIcon',
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const state = reactive({
			isShowDialog: false,
			uploadUrl: import.meta.env.VITE_API_URL + "/admin/attachment/upload",
			headers: {"Authorization": Local.get('token')},
			limit: 1,
			ruleForm: {
				titleZh: '',
				titleEn: '',
				iconZh: '',
				iconEn: '',
				bannerZh: '',
				bannerEn: '',
				sortNum: 0,
				hasTop: 0,
				topFlag:false,
				id: 0,
				cmpyId:0,
			},
			limit: 1,
			imageUrl: '',
			uploadUrl: import.meta.env.VITE_API_URL + "/admin/attachment/upload",
			headers: { "Authorization": Local.get('token') },
			rules: {
				//"deptName": { required: true, message: '请输入部门名称', trigger: 'blur' },
				//"deptDesc": { required: true, message: '请输入部门描述', trigger: 'blur' },
				//"cmpyId": [
				//	{ required: true, message: '请选择公司', trigger: 'blur' },
				//	{ type: 'number', message: '请选择公司', min: 1, trigger: 'blur' },
				//],
			},
		});
		// 打开弹窗
		const openDialog = (row: RuleFormState) => {
			state.ruleForm = row;
			state.ruleForm.status = row.status + '';
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
		

		// 修改
		const onSubmit = () => {
			
			proxy.$refs['myRefForm'].validate((valid: any) => {
				if (valid) {
					state.ruleForm.created = null;
					state.ruleForm.children = null;
					saveCategory(state.ruleForm).then(() => {
						closeDialog(); // 关闭弹窗
						// initForm();
						ctx.emit("reloadTable");
					}).catch((res) => {
						ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
					})
				}
			});

		};
		
		const beforeAvatarUpload = (file) => {
		    let isJPG = true;
		    if (file.type.indexOf("image/") == -1) {
		        isJPG=false;
		        ElMessage.error("文件格式错误，请上传图片类型,如：JPG，PNG后缀的文件。");
		    }
		    const isLt3M = file.size / 1024 / 1024 < 3;
		    if (!isLt3M) {
		       ElMessage.error('上传图片大小不能超过 3MB!');
		    }
		    return isJPG && isLt3M;
		};
		const uploadFileZh = (params) => {
		  let isPic = true;
		  if (params.file.type.indexOf("image/") == -1) {
		      isPic=false;
		      ElMessage.error("文件格式错误，请上传图片类型,如：JPG，PNG后缀的文件。");
		  }
		  const isLt3M = params.file.size / 1024 / 1024 < 3;
		
		  if (!isLt3M) {
		     ElMessage.error('上传图片大小不能超过 3MB!');
		  }
		  if(isPic && isLt3M){
		    let fd=new FormData();
		    fd.append("files",params.file);
		    addAttach(fd).then((response) => {
		       // debugger
		      if (response.code === 200) {
		           ElMessage.success("图片上传成功");
		           state.ruleForm.bannerZh= response.data.urls;
		         }else{
		            ElMessage.error(response.message)
		         }
		      })
		  }
		};
		const uploadFileEn = (params) => {
		  let isPic = true;
		  if (params.file.type.indexOf("image/") == -1) {
		      isPic=false;
		      ElMessage.error("文件格式错误，请上传图片类型,如：JPG，PNG后缀的文件。");
		  }
		  const isLt3M = params.file.size / 1024 / 1024 < 3;
		
		  if (!isLt3M) {
		     ElMessage.error('上传图片大小不能超过 3MB!');
		  }
		  if(isPic && isLt3M){
		    let fd=new FormData();
		    fd.append("files",params.file);
		    addAttach(fd).then((response) => {
		       // debugger
		      if (response.code === 200) {
		           ElMessage.success("图片上传成功");
		           state.ruleForm.bannerEn= response.data.urls;
		         }else{
		            ElMessage.error(response.message);
		         }
		      })
		  }
		};
		/* 图片上传 */
		const handleAvatarSuccess = (res, file) => {
		  console.log("---------handleAvatarSuccess---------");
		  //this.form.adPic = URL.createObjectURL(file.raw);
		};

		// 页面加载时
		onMounted(() => {
		});
		return {
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			beforeAvatarUpload,
			handleAvatarSuccess,
			uploadFileEn,
			uploadFileZh,
			
			...toRefs(state),
		};
	},
	
});
</script>

<style scoped>
.avatar-uploader .avatar {
	width: 178px;
	height: 178px;
	display: block;
}
</style>

<style>
.avatar-uploader .el-upload {
	border: 1px dashed var(--el-border-color);
	border-radius: 6px;
	cursor: pointer;
	position: relative;
	overflow: hidden;
	transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
	border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
	font-size: 28px;
	color: #8c939d;
	width: 178px;
	height: 178px;
	background-color: #f6f6f6;
	display: flex;
	justify-content: center;
	align-items: center;
}

.zx-icon__container {
	display: flex;
	margin-top: 20px;
	align-items: center;

}

.zx-icon__input {
	flex: 1;
}
</style>