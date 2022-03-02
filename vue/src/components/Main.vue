<template>
  <!--  <div style="h">-->
  <el-container style="height: 100%;">
    <!--    头部内容-->
    <el-header>
      <div>

        <span class="title" style="color: #fff">中国节后台管理系统</span>
        <i class="el-icon-s-operation" style=" padding-left:20px;font-size: 20px; color: #dadada"
           @click="isCollapse=!isCollapse"></i>
      </div>
      <div>
        <el-button type="info" @click="quit">退出</el-button>
      </div>
    </el-header>
    <el-container>
      <!--      侧边栏内容-->
      <el-aside :width="isCollapse?'64px':'200px'">
        <!--        <div style=" text-align: center;color: #fff;background: rgb(74,80,100);cursor: pointer"-->
        <!--             @click="isCollapse=!isCollapse">|||-->
        <!--        </div>-->
        <el-menu
            default-active="2"
            class="el-menu-vertical-demo"
            :unique-opened="true"
            :router="true"
            :collapse-transition="false"
            :collapse="isCollapse"
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#FFD700">
          <el-submenu :index="item.id+''" v-for="item in router" :key="item.id">
            <template slot="title">
              <i :class="item.icon"></i>
              <span>{{ item.name }}</span>
            </template>
            <el-menu-item :index="item2.path+''" v-for="item2 in item.children" :key="item2.id">
              <i :class="item2.icon"></i>
              <span slot="title">{{ item2.name }}</span>
            </el-menu-item>
          </el-submenu>
        </el-menu>

      </el-aside>
      <!--      主体内容-->
      <el-main>
            <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
  <!--  </div>-->
</template>

<script>
export default {
  name: "Main",
  data() {
    return {
      router: [

        {
          id: 1,
          name: "用户管理",
          icon: "el-icon-user",
          children: [
            {
              id: 1,
              name: "用户列表",
              path: "user",
              icon: "el-icon-user",

            },
            {
              id: 2,
              name: "微信用户列表",
              path: "euser",
              icon: "el-icon-user",
            },
          ]
        },
        {
          id: 2,
          name: "系统管理",
          icon: "el-icon-setting",
          children: [
            {
              id: 1,
              name: "聚节阁管理",
              icon: "el-icon-edit-outline",
              path: "note"
            },
            {
              id: 2,
              name: "召集令管理",
              icon: "el-icon-edit",
              path: "content",
            },
            {
              id: 3,
              name: "论坛楼",
              icon: "el-icon-collection",
              path: "text"
            },
            {
              id:4,
              name: "我的",
              icon: "el-icon-s-opportunity",
              path: "emotion",
            },
          ]
        }
      ],
      isCollapse: false
    }
  },
  methods: {
    quit() {
      this.$router.push('/')
    }
  }
}
</script>

<style scoped>

.logo {
  height: 60px;
  vertical-align: top;
  margin-right: 16px;
  background-color: #2c3e50;
}

.title {
  font-size: 33px;
  color: #000000;
  font-family: 'Myriad Pro', 'Helvetica Neue', Arial, Helvetica, sans-serif;
  font-weight: 600;
  position: relative;
  top: 2px;
}

.el-header {
  background: rgb(55, 61, 65);
  display: flex;
  justify-content: space-between;
  line-height: 60px;
}

.el-aside {
  background: rgb(51, 55, 68);
}

.el-main {
  background: rgb(234, 237, 241);
}


</style>
