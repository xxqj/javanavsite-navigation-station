<template>
	<div class="system-menu-container">
		<el-card shadow="hover">
			<div class="system-Category-search mb15">
				<el-row :gutter="35">
				<el-col :xs="8" :sm="8" :md="8" :lg="8" :xl="8" class="mb20">
					<el-cascader :options="options" :props="{expandTrigger: 'click', checkStrictly: true, multiple: true,emitPath:false }" v-model="tableData.param.catIds" placeholder="请选择分类"
					clearable class="ml10"  filterable="true" ref="casRef"  @change="handleChange">
					</el-cascader>
				</el-col>
				<el-col :xs="16" :sm="16" :md="16" :lg="16" :xl="8" class="mb20">
				   <el-input size="small" clearable  v-model="tableData.param.linkName" placeholder="请输入链接名称" style="max-width: 180px" class="ml10"></el-input>
				
				<el-button size="small" type="primary" class="ml10" @click="initTableData">查询</el-button>
				<el-button @click="onOpenAddMenu" class="mt10" size="small" type="primary" icon="iconfont icon-shuxingtu">新建链接</el-button>
				</el-col>
				</el-row>
			</div>
				
			<el-table :data="tableData.data" stripe style="width: 100%" row-key="id" :tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
				<el-table-column prop="menuIds" label="分类" :formatter="getCatLabel" show-overflow-tooltip></el-table-column>
				
	             <el-table-column prop="linkUrl" label="网址链接" show-overflow-tooltip>
					<template #default="scope">
						<el-link :href="scope.row.linkUrl" target="_blank" type="success">{{scope.row.linkName}}</el-link>
					</template>
			</el-table-column>
				<el-table-column prop="target" label="打开方式" width="90">
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.target=='_blank'">新开窗口</el-tag>
						<el-tag type="info" v-else>本窗口</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="target" label="类型" width="80">
					<template #default="scope">
						<el-tag type="info" v-if="scope.row.urlType==5">网址</el-tag>
						<el-tag type="info" v-else-if="scope.row.urlType==6">友情链接</el-tag>
						<el-tag type="info" v-else-if="scope.row.urlType==1">文章</el-tag>
						<el-tag type="info" v-else-if="scope.row.urlType==2">页面</el-tag>
						<el-tag type="info" v-else-if="scope.row.urlType==3">分类</el-tag>
						<el-tag type="info" v-else-if="scope.row.urlType==4">标签</el-tag>
						<el-tag type="info" v-else>其他</el-tag>
					</template>
				</el-table-column>
					<el-table-column prop="sortNum" label="排序" width="50"></el-table-column>
					<el-table-column label="隐藏" show-overflow-tooltip width="70">
						<template #default="scope">
							<span v-if="scope.row.status=='hidden'" class="color-primary">是</span>
							<span v-else class="color-info">否</span>
						</template>
					</el-table-column>
				<el-table-column label="操作" show-overflow-tooltip width="125">
					<template #default="scope">
						<!-- <el-button size="mini" type="text" @click="onOpenAddMenu(scope.row)">新增</el-button> -->
						<el-button size="mini" type="text" @click="onOpenEditMenu(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="onTabelRowDel(scope.row)">删除</el-button>
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
		<AddLink ref="addMenuRef" @reloadTable="initTableData"/>
		<EditLink ref="editMenuRef" @reloadTable="initTableData"/>
	</div>
</template>

<script lang="ts">
import { ref, toRefs, reactive, computed, onMounted } from 'vue';

import { ElMessageBox, ElMessage } from 'element-plus';
import { getParentIdById, getLabelById,getIdByLabel } from '/@/utils/cascaderUiTool.ts';
import { getNavCatList, delNavLink,getpList } from '/@/api/navsite/navlink/index';
import AddLink from '/@/views/navsite/navlink/component/addMenu.vue';
import EditLink from '/@/views/navsite/navlink/component/editMenu.vue';

export default {
	name: 'templateMenu',
	components: { AddLink, EditLink },
	setup() {
		const addMenuRef = ref();
		const editMenuRef = ref();
		const casRef =ref();
		const state = reactive({
			
			tableData: {
				data: [],
				total: 0,
				loading: false,
				param: {
					catIds: [],
					linkName: '',
					pageNum: 1,
					pageSize: 10,
				},
			},
			props:{multiple:false},
			options: [],
			_mids:'',
		});
		
		// 打开新增菜单弹窗
		const onOpenAddMenu = (row: object) => {
			addMenuRef.value.openDialog(row);
		};
		// 打开编辑菜单弹窗
		const onOpenEditMenu = (row: object) => {
			console.log('edit');
			editMenuRef.value.openDialog(row);
		};
		// 删除当前行
		const onTabelRowDel = (row: any) => {
			ElMessageBox.confirm('此操作将永久删除链接, 是否继续?', '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			}).then(() => {
				console.log(row);
				delNavLink(row.id).then(() => {
					ElMessage.success("删除成功");
					initTableData();
				}).catch((res) => {
					ElMessage.error(res.message);
				});
			}).catch(()=> {})
		};

		
		
		const loadCatList = () => {
			getNavCatList().then((res) => {
				state.options = res.data;
			}).catch(() => {
			})
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
		
		// 初始化表格数据
		const initTableData = () => {
		
			state.tableData.data = [];
			state.tableData.param.catIds=state._mids;
			getpList(state.tableData.param).then((res) => {
				state.tableData.data = res.data.records;
				state.tableData.total = res.data.total;
			}).catch(() => {
			})
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
			  state.tableData.param.catIds=value.join(",") ;
		  } */
		  
		  const checkList = casRef.value ? casRef.value.getCheckedNodes():[];
		  state._mids= checkList.length >0 ? checkList.map((x) => x.value).join(","):"";
		  
		  
		  console.log(state._mids);
		};
		
		const getCatLabel =(row) =>{
			
			let _list_check= row.menuIds ? row.menuIds.split(","):[];
			//console.log("_list_check=",_list_check)
			let _arr = [];
			 _list_check.forEach(i => {
				_arr.push(getLabelById(state.options,i));
			});
			//console.log("_arr=",_arr.join("->"));
			return _arr.join("/");
			
		};
		

		onMounted(() => {
			//loadMenuList();
			loadCatList();
			initTableData();
		});

		return {
			addMenuRef,
			editMenuRef,
			casRef,
			onOpenAddMenu,
			onOpenEditMenu,
			onTabelRowDel,
			loadCatList,
			getCatLabel,
			handleChange,
			onHandleSizeChange,
			onHandleCurrentChange,
			initTableData,
			...toRefs(state),
		};
	},
};
</script>
