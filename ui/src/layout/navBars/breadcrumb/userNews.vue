<template>
	<div class="layout-navbars-breadcrumb-user-news">
		<div class="head-box">
			<div class="head-box-title">{{ $t('message.user.newTitle') }}</div>
			<div class="head-box-btn" v-if="newsList.length > 0" @click="onAllReadClick">{{ $t('message.user.newBtn') }}</div>
		</div>
		<div class="content-box">
			<template v-if="newsList.length > 0">
				<div class="content-box-item" v-for="(v, k) in newsList" :key="k">
					<div>{{ v.label }}</div>
					<div class="content-box-msg">
						{{ v.value }}
					</div>
					<div class="content-box-time">{{ v.time }}</div>
				</div>
			</template>
			<el-empty :description="$t('message.user.newDesc')" v-else></el-empty>
		</div>
		<div class="foot-box" @click="onGoToGiteeClick" v-if="newsList.length > 0">{{ $t('message.user.newGo') }}</div>
	</div>
</template>

<script lang="ts">
import { reactive, toRefs } from 'vue';
export default {
	name: 'layoutBreadcrumbUserNews',
	setup() {
		const state = reactive({
			newsList: [
				{
					label: '关于版本发布的通知',
					value: 'GreenFlash，基于 Springboot插件化架构，扩展性极高的内容管理系统，正式发布时间：2022年01月01日！',
					time: '2022-01-01',
				},
				{
					label: '关于学习交流的通知',
					value: 'http://www.xjd2020.com，GreenFlash社区，欢迎小伙伴入群学习交流探讨！',
					time: '2022-01-01',
				},
			],
		});
		// 全部已读点击
		const onAllReadClick = () => {
			state.newsList = [];
		};
		// 前往通知中心点击
		const onGoToGiteeClick = () => {
			window.open('https://gitee.com/xjd2020/fastcms.git');
		};
		return {
			onAllReadClick,
			onGoToGiteeClick,
			...toRefs(state),
		};
	},
};
</script>

<style scoped lang="scss">
.layout-navbars-breadcrumb-user-news {
	.head-box {
		display: flex;
		border-bottom: 1px solid #ebeef5;
		box-sizing: border-box;
		color: #333333;
		justify-content: space-between;
		height: 35px;
		align-items: center;
		.head-box-btn {
			color: var(--color-primary);
			font-size: 13px;
			cursor: pointer;
			opacity: 0.8;
			&:hover {
				opacity: 1;
			}
		}
	}
	.content-box {
		font-size: 13px;
		.content-box-item {
			padding-top: 12px;
			&:last-of-type {
				padding-bottom: 12px;
			}
			.content-box-msg {
				color: #999999;
				margin-top: 5px;
				margin-bottom: 5px;
			}
			.content-box-time {
				color: #999999;
			}
		}
	}
	.foot-box {
		height: 35px;
		color: var(--color-primary);
		font-size: 13px;
		cursor: pointer;
		opacity: 0.8;
		display: flex;
		align-items: center;
		justify-content: center;
		border-top: 1px solid #ebeef5;
		&:hover {
			opacity: 1;
		}
	}
	::v-deep(.el-empty__description p) {
		font-size: 13px;
	}
}
</style>
