<template>
	<div class="system-menu-container">
		<el-card shadow="hover">
			<div class="system-Category-search mb15">
				<el-row :gutter="35">
				<el-col :xs="8" :sm="8" :md="8" :lg="8" :xl="8" class="mb20">
					
					<el-select v-model="tableData.param.typeId"  placeholder="请选择类型" clearable class="w100" @change="onHandleCfgChange">
					   <el-option v-for="(item,index) in cfgTypeList"  :key="item.value" :label="item.label" :value="item.value" />
					</el-select>
				</el-col>
				<el-col :xs="16" :sm="16" :md="16" :lg="16" :xl="8" class="mb20">
				<el-input size="small" clearable  v-model="tableData.param.cfgName" placeholder="请输入参数描述" style="max-width: 180px" class="ml10"></el-input>
				<el-input size="small" clearable  v-model="tableData.param.keyName" placeholder="请输入参数key" style="max-width: 180px" class="ml10"></el-input>
				<el-button size="small" type="primary" class="ml10" @click="initTableData">查询</el-button>
				<el-button @click="onOpenAddCfg" class="mt10" size="small" type="primary" icon="iconfont icon-shuxingtu">新建参数</el-button>
				</el-col>
				</el-row>
			</div>
				
			<el-table :data="tableData.data" stripe style="width: 100%" row-key="id" :tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
				<el-table-column prop="id" label="编号" width="50"></el-table-column>
				<el-table-column prop="key" label="参数key" ></el-table-column>
				<el-table-column prop="value" label="参数value" ></el-table-column>
				<el-table-column prop="label" label="参数描述" ></el-table-column>
				
				<el-table-column prop="typeId" label="类型" >
					<template #default="scope">
						<el-tag type="info" v-if="scope.row.typeId==2">公用参数</el-tag>
						<el-tag type="info" v-else-if="scope.row.typeId==3">用户参数</el-tag>
						<el-tag type="info" v-else-if="scope.row.typeId==4">参数列表</el-tag>
						<el-tag type="info" v-else>系统参数</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="sortNum" label="排序" width="50"></el-table-column>
					
				<el-table-column label="操作" show-overflow-tooltip width="125">
					<template #default="scope">
						<!-- <el-button size="mini" type="text" @click="onOpenAddMenu(scope.row)">新增</el-button> -->
						<el-button size="mini" type="text" @click="onOpenEditCfg(scope.row)">修改</el-button>
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
		<AddCfg ref="addCfgRef" @reloadTable="initTableData"/>
		<EditCfg ref="editCfgRef" @reloadTable="initTableData"/>
	</div>
</template>

<script lang="ts">
import { ref, toRefs, reactive, computed, onMounted } from 'vue';

import { ElMessageBox, ElMessage } from 'element-plus';

import { getpList, delCfg } from '/@/api/config/index';
import AddCfg from '/@/views/setting/component/addCfg.vue';
import EditCfg from '/@/views/setting/component/editCfg.vue';

export default {
	name: 'templateCfg',
	components: { AddCfg, EditCfg },
	setup() {
		const addCfgRef = ref();
		const editCfgRef = ref();
		const casRef =ref();
		const state = reactive({
			
			tableData: {
				data: [],
				total: 0,
				loading: false,
				param: {
					typeId: '',
					cfgName: '',
					keyName: '',
					pageNum: 1,
					pageSize: 10,
				},
			},
			cfgTypeList:[
				{value: '1',label: '系统参数'},
				{value: '2',label: '公用参数'},
				{value: '3',label: '用户参数'},
				{value: '4',label: '参数列表'},
				
			],
			
		});
		
		// 打开新增菜单弹窗
		const onOpenAddCfg = (row: object) => {
			addCfgRef.value.openDialog(row);
		};
		// 打开编辑菜单弹窗
		const onOpenEditCfg = (row: object) => {
			console.log('edit');
			editCfgRef.value.openDialog(row);
		};
		// 删除当前行
		const onTabelRowDel = (row: any) => {
			ElMessageBox.confirm('此操作将永久删除参数, 是否继续?', '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			}).then(() => {
				console.log(row);
				delCfg(row.id).then(() => {
					ElMessage.success("删除成功");
					initTableData();
				}).catch((res) => {
					ElMessage.error(res.message);
				});
			}).catch(()=> {})
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
            //state.tableData.param.typeId=state._typeId;
			//state.tableData.param.typeId=state._typeId;
			getpList(state.tableData.param).then((res) => {
				state.tableData.data = res.data.records;
				state.tableData.total = res.data.total;
			}).catch(() => {
			})
		};
		const onHandleCfgChange = (selVal: number) => {
			console.log(selVal);
			state.tableData.param.typeId = selVal;
		};

		onMounted(() => {
			initTableData();
		});

		return {
			addCfgRef,
			editCfgRef,
			casRef,
			onOpenAddCfg,
			onOpenEditCfg,
			onTabelRowDel,
			onHandleSizeChange,
			onHandleCurrentChange,
			initTableData,
			onHandleCfgChange,
			...toRefs(state),
		};
	},
};
</script>
