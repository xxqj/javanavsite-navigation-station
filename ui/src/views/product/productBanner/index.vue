<template>
	<div class="system-dept-container">
		<el-card shadow="hover">
			<div class="system-dept-search mb15">
				<el-form :model="form" label-width="120px">

					<el-form-item label="国际语言">
						<el-radio-group v-model="form.resource">
							<el-radio label="中文" />
							<el-radio label="英文" />
							<el-radio label="其他" />
						</el-radio-group>
					</el-form-item>
					<el-form-item label="展示位置">
						<el-radio-group v-model="form.resource">
							<el-radio label="首页展示" />
							<el-radio label="产品详情页" />
						</el-radio-group>
					</el-form-item>
					<el-form-item label="banner">
						<el-upload class="upload-btn" :action="uploadUrl" name="files" :headers="headers"
							:show-file-list="false" :on-success="uploadSuccess" :on-exceed="onHandleExceed"
							:on-error="onHandleUploadError" :limit="limit">
							<img v-if="imageUrl" :src="imageUrl" class="avatar" />
							<el-icon v-else class="avatar-uploader-icon">
								<Plus />
							</el-icon>
							<!-- <el-button size="small" type="primary">上传中文图标</el-button> -->
						</el-upload>
					</el-form-item>
					<el-form-item>
						<el-button type="primary" @click="onSubmit">提 交</el-button>
					</el-form-item>
				</el-form>
			</div>
			<el-table :data="tableData.data" style="width: 100%" row-key="id" default-expand-all
				:tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
				<el-table-column prop="deptName" label="排序" show-overflow-tooltip> </el-table-column>
				<el-table-column prop="status" label="banner" show-overflow-tooltip>
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.status">启用</el-tag>
						<el-tag type="info" v-else>禁用</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="deptDesc" label="语言" show-overflow-tooltip></el-table-column>
				<el-table-column label="操作" show-overflow-tooltip width="240">
					<template #default="scope">
						<el-button size="small" type="text" @click="onOpenEditDept(scope.row)">删除</el-button>
						<el-button size="small" type="text" @click="onBanner(scope.row)">修改排序</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-card>
		<AddDept ref="addDeptRef" @reloadTable="initTableData" />
		<EditDept ref="editDeptRef" @reloadTable="initTableData" />
		<EditIcon ref="editIconRef" @reloadTable="initTableData" />
	</div>
</template>

<script lang="ts">
import { ref, toRefs, reactive, onMounted, defineComponent } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import { getDeptList, delDept } from '/@/api/dept/index';
import AddDept from '/@/views/product/productBanner/component/addCategory.vue';
import EditDept from '/@/views/product/productBanner/component/editCategory.vue';
import EditIcon from '/@/views/product/productBanner/component/editIcon.vue';
import { Local, Session } from '/@/utils/storage';

// 定义接口来定义对象的类型
interface TableDataRow {
	deptName: string;
	created: string;
	status: boolean;
	sortNum: number;
	deptDesc: string;
	id: number;
	children?: TableDataRow[];
}
interface TableDataState {
	tableData: {
		data: Array<TableDataRow>;
		loading: boolean;
	};
}

export default defineComponent({
	name: 'productBanner',
	components: { AddDept, EditDept },
	setup() {
		const addDeptRef = ref();
		const editDeptRef = ref();
		const editIconRef = ref();
		const state = reactive({
			limit: 3,
			imageUrl: '',
			uploadUrl: import.meta.env.VITE_API_URL + "/admin/attachment/upload",
			headers: { "Authorization": Local.get('token') },
			form: {
				name: '',
				region: '',
				date1: '',
				date2: '',
				delivery: false,
				type: [],
				resource: '',
				desc: '',
			},
			tableData: {
				data: [],
				loading: false,
			},
		});
		// 初始化表格数据
		const initTableData = () => {
			getDeptList().then(res => {
				state.tableData.data = res.data
			})
		};
		// 打开新增菜单弹窗
		const onOpenAddDept = (row: TableDataRow) => {
			addDeptRef.value.openDialog(row);
		};
		// 打开图标编辑
		const onOpenIconEdit = (row: TableDataRow) => {
			addDeptRef.value.openDialog(row);
		};
		// 打开编辑菜单弹窗
		const onOpenEditDept = (row: TableDataRow) => {
			editIconRef.value.openDialog(row);
		};
		const uploadSuccess = (res: any) => {
			console.log('res: ', res);
			if (res.code == 200) {
				state.imageUrl = res.data.urls
			} else {
				ElMessage.error(res.message);
			}

		}

		const onHandleExceed = () => {
			ElMessage.error("上传文件数量不能超过 " + state.limit + " 个!");
		}
		// 上传失败
		const onHandleUploadError = () => {
			ElMessage.error("上传失败");
		}
		const onSubmit = () => {

		};
		// 删除当前行
		const onTabelRowDel = (row: TableDataRow) => {
			ElMessageBox.confirm(`此操作将永久删除部门：${row.deptName}, 是否继续?`, '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			})
				.then(() => {
					delDept(row.id).then((res) => {
						if (res.code == 200) {
							ElMessage.success('删除成功');
							initTableData();
						}
					})
				})
				.catch(() => { });
		};
		// 页面加载时
		onMounted(() => {
			initTableData();
		});
		return {
			initTableData,
			addDeptRef,
			editDeptRef,
			onOpenAddDept,
			onOpenEditDept,
			onOpenIconEdit,
			onTabelRowDel,
			onSubmit,
			onHandleExceed,
			onHandleUploadError,
			uploadSuccess,
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
	font-size: 28px;
	color: #8c939d;
	width: 178px;
	height: 178px;
	background-color: #f6f6f6;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
