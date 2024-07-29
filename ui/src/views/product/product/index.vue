<template>
	<div class="system-Prod-container">
		
		<el-card shadow="hover">
			<div class="system-role-search mb15">
				<el-row :gutter="35">
					
				<el-col :xs="8" :sm="8" :md="8" :lg="8" :xl="8" class="mb20">
				    <el-select v-model="tableData.param.cmpyId"  placeholder="请选择公司" clearable class="w100" @change="onHandleCmpyChange">
					<el-option v-for="(item,index) in cmpyList" :key="index" :label="item.cmpySimpleName" :value="item.id" />
				   </el-select>
				   
				</el-col>
				<el-col :xs="8" :sm="8" :md="8" :lg="8" :xl="8" class="mb20">
				   <el-select v-model="tableData.param.categoryId"  placeholder="请选择产品分类" clearable class="w100">
					  <el-option v-for="(item,index) in categoryList" :key="index" :label="item.titleZh" :value="item.id" />
				   </el-select>
				</el-col>
				<el-col :xs="8" :sm="8" :md="8" :lg="8" :xl="8" class="mb20">
				   <el-input size="small" v-model="tableData.param.prodName" placeholder="请输入产品名称" style="max-width: 180px" class="ml10"></el-input>
				
				<el-button size="small" type="primary" class="ml10" @click="initTableData">查询</el-button>
				</el-col>
				</el-row>
				
			</div>
			<el-button @click="onOpenAddProd" class="mt15" size="small" type="primary" icon="iconfont icon-shuxingtu">新增产品</el-button>
			<el-table :data="tableData.data" stripe style="width: 100%">
				<el-table-column prop="id" label="产品编号" show-overflow-tooltip width="60"></el-table-column>
				<el-table-column label="产品图片" align="center" prop="iconZh">
				  <template #default="scope">
				       <el-image
				        style="width: 120px; height: 80px"
				        :src="scope.row.icon"
				        :preview-src-list="[scope.row.icon]">
				      </el-image>
				    <!-- <img :src="scope.row.backgroundUrl" width="80" preview="0"> -->
				   </template>
				</el-table-column>
				<el-table-column prop="titleZh" label="产品名称" show-overflow-tooltip></el-table-column>
				<el-table-column prop="prodMode" label="型号" show-overflow-tooltip></el-table-column>
				<el-table-column prop="hotSale" label="热销" width="60">
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.hotSale==1">是</el-tag>
						<el-tag type="info" v-else>否</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="showFlag" label="显示" width="60">
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.showFlag=='Y'">是</el-tag>
						<el-tag type="info" v-else>否</el-tag>
					</template>
				</el-table-column>
				<!-- <el-table-column prop="created" label="创建时间" show-overflow-tooltip></el-table-column> -->
				<el-table-column  label="操作" >
					<template #default="scope">
						<el-button  size="mini" type="text" @click="onOpenEditProd(scope.row)">修改产品</el-button>
						<el-button  size="mini" type="text" @click="onOpenEditProdMeta(scope.row)">产品Meta</el-button>
						<el-button  size="mini" type="text" @click="onOpenEditBanner(scope.row)">产品banner</el-button>
						<el-button  size="mini" type="text" @click="onOpenEditPic(scope.row)">产品图片</el-button>
						<el-button  size="mini" type="text" @click="onOpenEditPdf(scope.row)">产品PDF</el-button>
						<el-button  size="mini" type="text" @click="onOpenEditVideo(scope.row)">产品video</el-button>
						<el-button  size="mini" type="text" @click="onRowDel(scope.row)">删除产品</el-button>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				@size-change="onHandleSizeChange"
				@current-change="onHandleCurrentChange"
				class="mt15"
				:pager-count="5"
				:page-sizes="[10, 20, 30]"
				v-model:current-page="tableData.param.pageNum"
				background
				v-model:page-size="tableData.param.pageSize"
				layout="total, sizes, prev, pager, next, jumper"
				:total="tableData.total"
			>
			</el-pagination>
		</el-card>

		
		<AddProd ref="addProdRef" @reloadTable="initTableData"/>
		<EditProd ref="editProdRef" @reloadTable="initTableData"/>
		<EditProdMeta ref="editProdMetaRef" @reloadTable="initTableData"/>
		<EditProdBanner ref="editProdBannerRef" @reloadTable="initTableData"/>
		<EditProdPic ref="editProdPicRef" @reloadTable="initTableData"/>
		<EditProdPdf ref="editProdPdfRef" @reloadTable="initTableData"/>
		<EditProdVideo ref="editProdVideoRef" @reloadTable="initTableData"/>
	</div>
</template>

<script lang="ts">
import { ElMessageBox, ElMessage } from 'element-plus';
import { ref, toRefs, reactive, onMounted } from 'vue';
import AddProd from '/@/views/product/product/component/addProd.vue';
import EditProd from '/@/views/product/product/component/editProd.vue';
import EditProdMeta from '/@/views/product/product/component/editProdMeta.vue';
import EditProdBanner from '/@/views/product/product/component/editProdBanner.vue';
import EditProdPic from '/@/views/product/product/component/editProdPic.vue';
import EditProdPdf from '/@/views/product/product/component/editProdPdf.vue';
import EditProdVideo from '/@/views/product/product/component/editProdVideo.vue';
import { getProdList, delProd } from '/@/api/product/prod/index';
import { getCompyList} from '/@/api/company/index';
import { getCategoryList} from '/@/api/product/category/index';
export default {
	name: 'systemProd',
	components: { AddProd, EditProd ,EditProdMeta,EditProdBanner,EditProdPic,EditProdPdf,EditProdVideo},
	setup() {
		const addProdRef = ref();
		const editProdRef = ref();
		const editProdMetaRef = ref();
		const editProdBannerRef = ref();
		const editProdPicRef = ref();
		const editProdPdfRef = ref();
		const editProdVideoRef = ref();
		const state: any = reactive({
			cmpyList: [],
			categoryList: [],
			tableData: {
				data: [],
				total: 0,
				loading: false,
				param: {
					categoryId: '',
					prodName: '',
					cmpyId: '',
					pageNum: 1,
					pageSize: 10,
				},
			},
		});

		// const onClickTree = (data, node, elem) => {
		// 	state.tableData.param.deptId = data.id;
		// 	state.tableData.data = [];
		// 	state.tableData.total = 0;
		// 	state.tableData.param.pageNum = 1;
		// 	initTableData();
		// }
		
		const onOpenAddProd = () => {
			addProdRef.value.openDialog();
		};

		const onOpenEditProd = (row: object) => {
			editProdRef.value.openDialog(row);
		};
		const onOpenEditProdMeta = (row: object) => {
			editProdMetaRef.value.openDialog(row);
		};
		const onOpenEditBanner = (row: object) => {
			editProdBannerRef.value.openDialog(row);
		};
		const onOpenEditPic = (row: object) => {
			editProdPicRef.value.openDialog(row);
		};
		const onOpenEditPdf = (row: object) => {
			editProdPdfRef.value.openDialog(row);
		};
		const onOpenEditVideo = (row: object) => {
			editProdVideoRef.value.openDialog(row);
		};

		// 初始化表格数据
		const initTableData = () => {

			state.tableData.data = [];
			getProdList(state.tableData.param).then((res) => {
				state.tableData.data = res.data.records;
				state.tableData.total = res.data.total;
			}).catch(() => {
			})
		};
		// 当前行删除
		const onRowDel = (row: object) => {
			ElMessageBox.confirm('此操作将永久删除产品, 是否继续?', '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			}).then(() => {
				delProd(row.id).then(() => {
					if(res.code == 200) {
						ElMessage.success('删除成功');
						initTableData();
					}
					
				}).catch((res) => {
					ElMessage({showClose: true, message: res.message ? res.message : '系统错误' , type: 'error'});
				});
			}).catch(() => {});
		};
		// 分页改变
		const onHandleSizeChange = (val: number) => {
			state.tableData.param.pageSize = val;
			initTableData();
		};
		// 分页改变
		const onHandleCurrentChange = (val: number) => {
			state.tableData.param.pageNum = val;
			initTableData();
		};
		const onHandleCmpyChange = (selVal: number) => {
			console.log(selVal);
			state.tableData.param.cmpyId = selVal;
			getCategoryList({cmpyId:state.tableData.param.cmpyId}).then(res => {
				state.categoryList = res.data
				state.tableData.param.categoryId = res.data[0].id;
			})
			
			//initTableData();
		};
		// 页面加载时
		onMounted(() => {
			initTableData();
			getCompyList().then(res => {
				state.cmpyList = res.data
			})
			getCategoryList({cmpyId:state.tableData.param.cmpyId}).then(res => {
				state.categoryList = res.data
			})
		});
		return {
			addProdRef,
			editProdRef,
			editProdMetaRef,
			editProdBannerRef,
			editProdPicRef,
			editProdPdfRef,
			editProdVideoRef,
			onOpenEditProd,
			onOpenAddProd,
			onOpenEditProdMeta,
			onOpenEditBanner,
			onOpenEditPic,
			onOpenEditPdf,
			onOpenEditVideo,
			onRowDel,
			onHandleSizeChange,
			onHandleCurrentChange,
			onHandleCmpyChange,
			initTableData,
			...toRefs(state),
		};
	},
};
</script>

<style scoped lang="scss">
.system-Prod-container {
	.system-Prod-search {
		text-align: right;
	}
	.system-Prod-photo {
		width: 40px;
		height: 40px;
		border-radius: 100%;
	}
}
</style>
