<template>
	<div class="system-Category-container">
		<el-card shadow="hover">
			<div class="system-Category-search mb15">
				<el-button size="small" type="primary" class="mt15" @click="onOpenAddCategory" icon="iconfont icon-shuxingtu">新增分类</el-button>
				<el-input size="small" class="ml10" v-model="tableData.param.keywordZh" placeholder="请输入分类名称" style="max-width: 180px"> </el-input>
				<el-button size="small" type="primary" class="ml10" @click="initTableData">查询</el-button>
			</div>
			<el-table
				:data="tableData.data"
				style="width: 100%"
				row-key="id"
				default-expand-all
				:tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
				<el-table-column prop="id" label="分类编号" show-overflow-tooltip width="60"></el-table-column>
				<el-table-column prop="titleZh" label="分类名称" show-overflow-tooltip> </el-table-column>
				<el-table-column label="分类图片" align="center" prop="iconZh">
				  <template #default="scope">
				       <el-image
				        style="width: 120px; height: 80px"
				        :src="scope.row.iconZh"
				        :preview-src-list="[scope.row.iconZh]">
				      </el-image>
				    <!-- <img :src="scope.row.backgroundUrl" width="80" preview="0"> -->
				   </template>
				</el-table-column>
				<el-table-column label="banner图片" align="center" prop="bannerZh">
				  <template #default="scope">
				       <el-image
				        style="width: 120px; height: 80px"
				        :src="scope.row.bannerZh"
				        :preview-src-list="[scope.row.bannerZh]">
				      </el-image>
				    <!-- <img :src="scope.row.backgroundUrl" width="80" preview="0"> -->
				   </template>
				</el-table-column>
				<el-table-column prop="cmpyName" label="公司" show-overflow-tooltip></el-table-column>
				<el-table-column prop="sortNum" label="排序" show-overflow-tooltip width="60"></el-table-column>
				<el-table-column prop="hasTop" label="置顶" show-overflow-tooltip width="60">
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.hasTop==1">是</el-tag>
						<el-tag type="info" v-else>否</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="showFlag" label="显示" show-overflow-tooltip width="60">
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.showFlag=='Y'">是</el-tag>
						<el-tag type="info" v-else>否</el-tag>
					</template>
				</el-table-column>
				<!-- <el-table-column prop="created" label="创建时间" show-overflow-tooltip></el-table-column> -->
				<el-table-column label="操作"  >
					<template #default="scope">
						<el-button size="mini" type="text" @click="onOpenEditCategory(scope.row)">修改分类</el-button>
						<el-button size="mini" type="text" @click="onOpenBannerEdit(scope.row)">banner图片</el-button>
						<el-button size="mini" type="text" @click="onOpenIconEdit(scope.row)">分类图片</el-button>
						<el-button size="mini" type="text" @click="onTabelRowDel(scope.row)">删除分类</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-card>
		<AddCategory ref="addCategoryRef" @reloadTable="initTableData"/>
		<EditCategory ref="editCategoryRef" @reloadTable="initTableData"/>
		<EditIcon ref="editIconRef" @reloadTable="initTableData"/>
		<EditBanner ref="editBannerRef" @reloadTable="initTableData"/>
	</div>
</template>

<script lang="ts">
import { ref, toRefs, reactive, onMounted, defineComponent } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import { getCategoryList, delCategory } from '/@/api/product/category/index';
import AddCategory from '/@/views/product/productCategory/component/addCategory.vue';
import EditCategory from '/@/views/product/productCategory/component/editCategory.vue';
import EditIcon from '/@/views/product/productCategory/component/editIcon.vue';
import EditBanner from '/@/views/product/productCategory/component/editBanner.vue';
import { useRoute, useRouter, onBeforeRouteUpdate } from 'vue-router';

// 定义接口来定义对象的类型
interface TableDataRow {
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
	children?: TableDataRow[];
}
interface TableDataState {
	tableData: {
		data: Array<TableDataRow>;
		loading: boolean;
	};
}

export default defineComponent({
	name: 'productCategory',
	components: { AddCategory, EditCategory, EditIcon ,EditBanner},
	setup() {
		const router = useRouter();
		const addCategoryRef = ref();
		const editCategoryRef = ref();
		const editIconRef = ref();
		const editBannerRef = ref();
		const state = reactive<TableDataState>({
			tableData: {
				data: [],
				loading: false,
				param: {
					keywordZh:'',
				},
			},
		});
		// 初始化表格数据
		const initTableData = () => {
			getCategoryList(state.tableData.param).then(res => {
				state.tableData.data = res.data
			})
		};
		// 打开新增菜单弹窗
		const onOpenAddCategory = (row: TableDataRow) => {
			addCategoryRef.value.openDialog(row);
		};
		// 打开图标编辑
		const onOpenIconEdit = (row: TableDataRow) => {
			//console.log('editIconRef: ', editIconRef);
			editIconRef.value.openDialog(row);
		};
		
		// 打开图标编辑
		const onOpenBannerEdit = (row: TableDataRow) => {
			//console.log('editIconRef: ', editIconRef);
			editBannerRef.value.openDialog(row);
		};
		// 打开编辑菜单弹窗
		const onOpenEditCategory = (row: TableDataRow) => {
			editCategoryRef.value.openDialog(row);
		};
		const onBanner = (row: TableDataRow)=> {
			router.push('/product/productBanner');
		};
		// 删除当前行
		const onTabelRowDel = (row: TableDataRow) => {
			ElMessageBox.confirm(`此操作将永久删除分类：${row.titleZh}, 是否继续?`, '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			}).then(() => {
					delCategory(row.id).then((res) => {
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
		// 页面加载时
		onMounted(() => {
			initTableData();
		});
		return {
			initTableData,
			addCategoryRef,
			editCategoryRef,
			editIconRef,
			editBannerRef,
			onOpenAddCategory,
			onOpenEditCategory,
			onOpenIconEdit,
			onOpenBannerEdit,
			onBanner,
			onTabelRowDel,
			...toRefs(state),
		};
	},
});
</script>
