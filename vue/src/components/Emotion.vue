<template>
<div>  <!--    面包屑导航-->
  <el-breadcrumb style="padding-bottom:15px " separator="/">
  <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
  <el-breadcrumb-item>系统管理</el-breadcrumb-item>
  <el-breadcrumb-item>召集令管理</el-breadcrumb-item>
</el-breadcrumb>
</div>
</template>

<script>
export default {
  name: "Emotion"
}
</script>

<style scoped>

</style>