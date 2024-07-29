<template>
	<div class="system-compy-container">
		<el-card shadow="hover">
			<div class="system-Compy-search mb15">
				<el-button size="small" type="primary" class="mt15" @click="onOpenAddCompy" icon="iconfont icon-shuxingtu">新增公司</el-button>
				<el-input size="small" class="ml10" placeholder="请输入公司名称" style="max-width: 180px"> </el-input>
				<el-button size="small" type="primary" class="ml10">查询</el-button>
			</div>
			<el-table
				:data="tableData.data"
				style="width: 100%"
				row-key="id"
				default-expand-all
				:tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
			>
				<el-table-column prop="cmpySimpleName" label="公司名称" show-overflow-tooltip> </el-table-column>
				<el-table-column prop="status" label="公司状态" show-overflow-tooltip>
					<template #default="scope">
						<el-tag type="success" v-if="scope.row.status">启用</el-tag>
						<el-tag type="info" v-else>禁用</el-tag>
					</template>
				</el-table-column>
				<el-table-column prop="cmpyDesc" label="公司描述" show-overflow-tooltip></el-table-column>
				<el-table-column prop="updated" label="更新时间" show-overflow-tooltip></el-table-column>
				<el-table-column label="操作" show-overflow-tooltip width="140">
					<template #default="scope">
						<el-button size="small" type="text" @click="onOpenAddCompy(scope.row)">新增</el-button>
						<el-button size="small" type="text" @click="onOpenEditCompy(scope.row)">修改</el-button>
						<el-button size="small" type="text" @click="onTabelRowDel(scope.row)">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-card>
		<AddCompy ref="addCompyRef" @reloadTable="initTableData"/>
		<EditCompy ref="editCompyRef" @reloadTable="initTableData"/>
	</div>
</template>

<script lang="ts">
import { ref, toRefs, reactive, onMounted, defineComponent } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import { getCompyList, delCompy } from '/@/api/company/index';
import AddCompy from '/@/views/system/company/component/addCompy.vue';
import EditCompy from '/@/views/system/company/component/editCompy.vue';

// 定义接口来定义对象的类型
interface TableDataRow {
	cmpySimpleName: string;
	created: string;
	status: number;
	sortNum: number;
	cmpyDesc: string;
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
	name: 'systemCompany',
	components: { AddCompy, EditCompy },
	setup() {
		const addCompyRef = ref();
		const editCompyRef = ref();
		const state = reactive<TableDataState>({
			tableData: {
				data: [],
				loading: false,
			},
		});
		// 初始化表格数据
		const initTableData = () => {
			getCompyList().then(res => {
			
				console.log(res.data)
				state.tableData.data = res.data
			})
		};
		// 打开新增菜单弹窗
		const onOpenAddCompy = (row: TableDataRow) => {
			addCompyRef.value.openDialog(row);
		};
		// 打开编辑菜单弹窗
		const onOpenEditCompy = (row: TableDataRow) => {
			editCompyRef.value.openDialog(row);
		};
		// 删除当前行
		const onTabelRowDel = (row: TableDataRow) => {
			ElMessageBox.confirm(`此操作将永久删除公司：${row.cmpySimpleName}, 是否继续?`, '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			})
				.then(() => {
					delCompy(row.id).then((res) => {
						if(res.code == 200) {
							ElMessage.success('删除成功');
							initTableData();
						}
					})
				})
				.catch(() => {});
		};
		// 页面加载时
		onMounted(() => {
			initTableData();
		});
		return {
			initTableData,
			addCompyRef,
			editCompyRef,
			onOpenAddCompy,
			onOpenEditCompy,
			onTabelRowDel,
			...toRefs(state),
		};
	},
});
</script>
