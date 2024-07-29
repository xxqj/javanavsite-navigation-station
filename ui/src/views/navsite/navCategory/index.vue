<template>
	<div class="system-navMenu-container">
		<el-card shadow="hover">
			<el-button @click="onOpenAddNavMenu" class="mt15" size="small" type="primary" icon="iconfont icon-shuxingtu">新建分类</el-button>
			<el-table :data="navMenuTableData" stripe style="width: 100%" row-key="name" :tree-props="{ children: 'children', hasChildren: 'hasChildren' }">
				<el-table-column label="分类名称" show-overflow-tooltip>
					<template #default="scope">
						<i :class="scope.row.meta.icon"></i>
						<span class="ml10">{{ scope.row.name}}</span>
					</template>
				</el-table-column>
				<el-table-column prop="meta.icon" label="分类图标" show-overflow-tooltip></el-table-column>
				<el-table-column prop="sortNum" label="排序" show-overflow-tooltip></el-table-column>
				<el-table-column label="隐藏" show-overflow-tooltip width="70">
					<template #default="scope">
						<span v-if="scope.row.meta.isHide=='hidden'" class="color-primary">是</span>
						<span v-else class="color-info">否</span>
					</template>
				</el-table-column>
				<!-- <el-table-column label="缓存" show-overflow-tooltip width="70">
					<template #default="scope">
						<span v-if="scope.row.meta.isKeepAlive==0" class="color-primary">是</span>
						<span v-else class="color-info">否</span>
					</template>
				</el-table-column> -->
				
				<el-table-column label="操作" show-overflow-tooltip width="125">
					<template #default="scope">
						<el-button size="mini" type="text" @click="onOpenAddNavMenu(scope.row)">新增</el-button>
						<el-button size="mini" type="text" @click="onOpenEditNavMenu(scope.row)">修改</el-button>
						<el-button size="mini" type="text" @click="onTabelRowDel(scope.row)">删除</el-button>
					</template>
				</el-table-column>
			</el-table>
		</el-card>
		<AddNavMenu ref="addNavMenuRef" @reloadTable="loadNavMenuList"/>
		<EditNavMenu ref="editNavMenuRef" @reloadTable="loadNavMenuList"/>
	</div>
</template>

<script lang="ts">
import { ref, toRefs, reactive, computed, onMounted } from 'vue';
import { ElMessageBox, ElMessage } from 'element-plus';
import { getNavMenuList, delNavMenu } from '/@/api/navsite/navmenu/index';

import AddNavMenu from '/@/views/navsite/navCategory/component/addMenu.vue';
import EditNavMenu from '/@/views/navsite/navCategory/component/editMenu.vue';

export default {
	name: 'systemNavMenu',
	components: { AddNavMenu, EditNavMenu },
	setup() {
		const addNavMenuRef = ref();
		const editNavMenuRef = ref();
		const state = reactive({
			navMenuData: null
		});
		// 获取 vuex 中的路由
		const navMenuTableData = computed(() => {
			return state.navMenuData;
		});
		// 打开新增菜单弹窗
		const onOpenAddNavMenu = (row: object) => {
			addNavMenuRef.value.openDialog(row);
		};
		// 打开编辑菜单弹窗
		const onOpenEditNavMenu = (row: object) => {
			editNavMenuRef.value.openDialog(row);
		};
		// 删除当前行
		const onTabelRowDel = (row: any) => {
			ElMessageBox.confirm('此操作将永久删除分类, 是否继续?', '提示', {
				confirmButtonText: '删除',
				cancelButtonText: '取消',
				type: 'warning',
			}).then(() => {
				console.log(row);
				delNavMenu(row.id).then(() => {
					ElMessage.success("删除成功");
					loadNavMenuList();
					//initBackEndControlRoutes();
				}).catch((res) => {
					ElMessage.error(res.message);
				});
			}).catch(()=> {})
		};

		const loadNavMenuList = () => {
			getNavMenuList().then((res) => {
				state.navMenuData = res.data;
			}).catch(() => {
			})
		}

		onMounted(() => {
			loadNavMenuList();
		});

		return {
			addNavMenuRef,
			editNavMenuRef,
			onOpenAddNavMenu,
			onOpenEditNavMenu,
			navMenuTableData,
			onTabelRowDel,
			loadNavMenuList,
			...toRefs(state),
		};
	},
};
</script>
