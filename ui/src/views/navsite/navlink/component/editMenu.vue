<template>
	<div class="system-menu-container">
		<el-dialog title="编辑链接" v-model="isShowDialog" width="769px">
			<el-form :model="ruleForm" size="small" label-width="80px" :rules="rules" ref="myRefForm">
				<el-row :gutter="35">
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="链接名称" prop="linkName">
							<el-input v-model="ruleForm.linkName" placeholder="请输入菜单名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="分类" prop="menuIds">
							<el-cascader  v-model="checkList" placeholder="请选择分类"  ref="casRef"
							:options="options" :props="{expandTrigger: 'click', checkStrictly: true, multiple: true,emitPath:false }" clearable class="ml10"  @change="handleChange">
							</el-cascader>
						</el-form-item>
					</el-col>
					
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="类型">
							<el-select v-model="ruleForm.urlType" placeholder="请选择" clearable class="w100">
								<el-option label="网址" value="5"></el-option>
								<el-option label="友情链接" value="6"></el-option>
								<el-option label="文章" value="1"></el-option>
								<el-option label="页面" value="2"></el-option>
								<el-option label="分类" value="3"></el-option>
								<el-option label="标签" value="4"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="是否隐藏">
							<el-select v-model="ruleForm.status" placeholder="请选择是否隐藏" clearable class="w100">
								<el-option label="是" value="hidden"></el-option>
								<el-option label="否" value="show"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sortNum">
							<el-input type="number" v-model="ruleForm.sortNum" placeholder="排序" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="打开方式">
							<el-select v-model="ruleForm.target" placeholder="请选择打开方式" clearable class="w100">
								<el-option label="本窗口" value="_self"></el-option>
								<el-option label="新开窗口" value="_blank"></el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="链接地址" prop="linkUrl">
							<el-input v-model="ruleForm.linkUrl" placeholder="请输入菜单地址" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="链接描述" prop="linkDesc">
							<el-input
							  type="textarea"
							  v-model="ruleForm.linkDesc" 
							  :rows="2"
							  placeholder="请输入内容">
							</el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="链接图标" prop="linkIcon">
							<img v-if="ruleForm.linkIcon" :src="ruleForm.linkIcon" class="avatar" width="80" height="80"/>
							
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
						<el-form-item label="链接图标">
							<el-input class="zx-icon__input" v-model="ruleForm.linkIcon" placeholder="输入图片网址" />
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="二维码图标" prop="qrcode">
							<img v-if="ruleForm.qrcode" :src="ruleForm.qrcode" class="avatar" width="80" height="80"/>
							
							<el-upload
								class="upload-btn"
								action="#"
								:http-request="uploadFileQr"
								:before-upload="beforeAvatarUpload"
								name="files"
								:headers="headers"
								:show-file-list="false"
								:limit="limit">
								<el-button size="small" type="primary">上传附件</el-button>
							</el-upload>
						</el-form-item>
						<el-form-item label="链接图标">
							<el-input class="zx-icon__input" v-model="ruleForm.qrcode" placeholder="输入图片网址" />
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
import { getParentIdById, getLabelById,getIdByLabel } from '/@/utils/cascaderUiTool.ts';
import { getNavCatList, saveNavLink} from '/@/api/navsite/navlink/index';
import { Local, Session } from '/@/utils/storage';
export default {
	name: 'templateEditMenu',
	components: { IconSelector },
	setup(props, ctx) {
		const { proxy } = getCurrentInstance() as any;
		const casRef =ref();
		const state = reactive({
			isShowDialog: false,
			uploadUrl: import.meta.env.VITE_API_URL + "/admin/attachment/upload",
			headers: {"Authorization": Local.get('token')},
			_mids:'',
			checkList:[],
			options:[],
			props:{multiple:true},
			ruleForm: {
				id: '',
				parentId: '',
				linkName: '', 
				linkUrl: '',
				qrcode:'',
				urlType: '0',
				linkIcon: '', 
				sortNum: '',
				target: '',
				linkDesc:'',
				status:'',
				menuIds:'',
			},
			rules: {
				"linkName": { required: true, message: '请输入链接名称', trigger: 'blur' },
				"linkUrl": { required: true, message: '请输入链接地址', trigger: 'blur' },
				"menuIds": { required: true, message: '请选择分类', trigger: 'blur' },
				"linkIcon": [
						   	        { required: true, message: '请输入链接图标', trigger: 'change' },
						     ],
			},
		});
		// 打开弹窗
		const openDialog = (row: any) => {
			console.log(row);
			state.isShowDialog = true;
			state.ruleForm.id=row.id;
			state.ruleForm.linkName = row.linkName;
			state.ruleForm.linkUrl = row.linkUrl;
			state.ruleForm.qrcode =row.qrcode;
			state.ruleForm.linkIcon = row.linkIcon;
			state.ruleForm.linkDesc = row.linkDesc;
			state.ruleForm.urlType =row.urlType.toString();
			state.ruleForm.target = row.target;
			state.ruleForm.sortNum = row.sortNum;
			state._mids=row.menuIds;
			state.ruleForm.statue =row.status;
			
			let _list_check= row.menuIds ? row.menuIds.split(",").map(i => Number(i)):[];
			let _arr = [];
			_list_check && _list_check.map(i => _arr.push(getParentIdById(state.options,i)))
			 console.log("edit_arr:",_arr);
			state.checkList =_arr;
			
			//state.ruleForm.menuIds=row.menuIds.split(',');
			state.ruleForm.status=row.status;
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
			state.ruleForm.menuIds = state._mids;
			proxy.$refs['myRefForm'].validate((valid: any) => {
				if (valid) {
					state.ruleForm.menuIds = state._mids;
					saveNavLink(state.ruleForm).then(() => {
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
			state.ruleForm.id = '',
			state.ruleForm.parentId = '';
			state.ruleForm.linkName = '';
			state.ruleForm.linkUrl = '';
			state.ruleForm.urlType = '0',
			state.ruleForm.linkDesc ='';
			state.ruleForm.linkIcon = '';
			state.ruleForm.target = '';
			state.ruleForm.sortNum = '';
			state.ruleForm.status ='show';
		};
		const handleChange = (value) => {
		  //console.log(value);
		  //console.log(value[2]);
		  //console.log(CodeToText[value[2]]);
		  //console.log(this.$refs['areaTree'].getCheckedNodes()[0]);// 获取选中节点对象
		  //console.log(value);
		 //console.log(value);
		 /* console.log(value);
		  if(Array.isArray(value) && value.length>0){
		  		console.log(value.join(","));
		  		state._mids=value.join(",") ;
		  } */
		  const checkList = casRef.value ? casRef.value.getCheckedNodes():[];
		  state._mids= checkList.length >0 ? checkList.map((x) => x.value).join(","):"";
		  
		  
		  console.log(state._mids);
		  
		};
		
		const loadCatList = () => {
			getNavCatList().then((res) => {
				state.options = res.data;
			}).catch(() => {
			})
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
		           state.ruleForm.linkIcon= response.data.urls;
		         }else{
		            ElMessage.error(response.message)
		         }
		      })
		  }
		};
		const uploadFileQr = (params) => {
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
		           state.ruleForm.qrCode= response.data.urls;
		         }else{
		            ElMessage.error(response.message)
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
			//loadMenuList();
			loadCatList();
		});
		
		return {
			casRef,
			openDialog,
			closeDialog,
			onCancel,
			onSubmit,
			handleChange,
			beforeAvatarUpload,
			handleAvatarSuccess,
			uploadFileZh,
			uploadFileQr,
			...toRefs(state),
		};
	},
};
</script>
