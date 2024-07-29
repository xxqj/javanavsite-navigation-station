<template>
	<div class="system-menu-container">
		<el-row>
		  <el-col :span="8" >
		    <el-card :body-style="{ padding: '0px' }">
		      <img src="/zx-wechat.jpg" class="image">
		      <div style="padding: 14px;">
		        <span>微信扫码预览小程序</span>
		        <div class="bottom clearfix">
		          <time class="time">修改小程序数据后，微信扫码实时预览小程序</time>
		          <el-button type="text" class="button"></el-button>
		        </div>
		      </div>
		    </el-card>
		  </el-col>
		</el-row>
		</div>
		</template>
		
<script lang="ts">
		export default {
		  data() {
		    return {
		      currentDate: new Date()
		    };
		  }
		}
</script>
<style scoped lang="scss">
		  .time {
		    font-size: 13px;
		    color: #999;
		  }
		  
		  .bottom {
		    margin-top: 13px;
		    line-height: 12px;
		  }
		
		  .button {
		    padding: 0;
		    float: right;
		  }
		
		  .image {
		    width: 100%;
		    display: block;
		  }
		
		  .clearfix:before,
		  .clearfix:after {
		      display: table;
		      content: "";
		  }
		  
		  .clearfix:after {
		      clear: both
		  }
</style>

	



