<template>
  <div>
    <!--    面包屑导航-->
    <el-breadcrumb style="padding-bottom:15px " separator="/">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!--    页面内容-->
    <el-card>
      <!--    搜索头部-->
      <el-row :gutter="40" style="padding-bottom: 15px">
        <el-col :span="8">
          <el-input placeholder="请输入内容" v-model="input3" class="input-with-select" @keyup.enter.native="Search"
                    clearable>
            <el-button slot="append" icon="el-icon-search" @click="Search"></el-button>
          </el-input>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" size="mini" @click="addUser">添加用户</el-button>
        </el-col>
        <el-col :span="4" style="  position:absolute; left:90%;">
          <el-button type="primary" icon="el-icon-refresh-right" @click="getUserList"></el-button>
        </el-col>
      </el-row>
      <!--      渲染数据表格-->
      <el-table
          :data="UserList.data"
          border
          style="width: 100%">
        <el-table-column
            type="index"
            width="35">
        </el-table-column>
<!--        <el-table-column-->
<!--            prop="u_name"-->
<!--            label="姓名"-->
<!--            width="180">-->
<!--        </el-table-column>-->
        <el-table-column
            prop="a_id"
            label="账号"
            width="300">
        </el-table-column>
        <el-table-column
            prop="a_name"
            label="昵称"
            width="300">
        </el-table-column>
        <el-table-column
            prop="password"
            label="密码"
            width="300">
        </el-table-column>

        <el-table-column
            prop="u_id"
            label="操作"
            width="318">
          <div slot-scope="scope">
<!--                        <el-tooltip class="item" effect="dark" content="查看" placement="top">-->
<!--                          <el-button icon="el-icon-search" size="mini"></el-button>-->
<!--                        </el-tooltip>-->
            <el-button type="primary" size="mini" @click="updateUser(scope.row)">查看/编辑</el-button>
            <el-button type="danger" size="mini" @click="deleteUser(scope.row)">删除</el-button>
          </div>
        </el-table-column>
      </el-table>
      <!--      分页控件-->
      <el-pagination
          @size-change="SizeChange"
          @current-change="CurrentChange"
          :current-page="page"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="limit"
          layout="total, sizes, prev, pager, next, jumper"
          :total="UserList.count">
      </el-pagination>
      <!--      编辑用户dialog对话框-->
      <el-dialog
          title="编辑用户"
          :visible.sync="dialogUpdateUser"
          width="30%">
        <!--        内容区域-->
        <el-form :model="UpdateUserList" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
<!--          <el-form-item label="姓名">-->
<!--            <el-input v-model="UpdateUserList.u_name" disabled></el-input>-->
<!--          </el-form-item>-->
          <el-form-item label="昵称" prop="a_name">
            <el-input v-model="UpdateUserList.signature" ></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input v-model="UpdateUserList.password"></el-input>
          </el-form-item>
<!--          <el-form-item label="身份证号" prop="user_id">-->
<!--            <el-input v-model="UpdateUserList.user_id"></el-input>-->
<!--          </el-form-item>-->
        </el-form>
        <span slot="footer" class="dialog-footer">
    <el-button @click="dialogUpdateUser = false">取 消</el-button>
    <el-button type="primary" @click="updateUser1">保 存</el-button>
  </span>
      </el-dialog>
      <el-dialog
          title="添加用户"
          :visible.sync="dialogAddUser"
          width="30%">
        <!--        内容区域-->
        <el-form :model="AddUserList" :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
          <!--          <el-form-item label="姓名">-->
          <!--            <el-input v-model="UpdateUserList.u_name" disabled></el-input>-->
          <!--          </el-form-item>-->
          <el-form-item label="昵称" prop="a_name">
            <el-input v-model="AddUserList.a_name" ></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="password">
            <el-input v-model="AddUserList.password" ></el-input>
          </el-form-item>
          <el-form-item label="账号" prop="a_id">
            <el-input v-model="AddUserList.a_id" ></el-input>
          </el-form-item>
          <el-button type="primary" @click="addUser1" class="a">添 加</el-button>
        </el-form>

      </el-dialog>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "User",
  //数据
  data() {
    return {
      input3: null,
      page: 1,
      limit: 10,
      UserList: [],
      UpdateUserList: {
        password: '',
      },
      AddUserList:{
        a_name: "",
        password: "",
        a_id: null,
      },
      dialogAddUser: false,
      dialogUpdateUser: false,
      //验证规则
      // rules: {
      //   address: [
      //     {required: true, validator: this.phoneRules, trigger: 'blur'}
      //   ],
      //   user_id: [{required: true, message: '请输入证件号', trigger: 'blur'},
      //     {
      //       pattern: /(^\d{8}(0\d|10|11|12)([0-2]\d|30|31)\d{3}$)|(^\d{6}(18|19|20)\d{2}(0\d|10|11|12)([0-2]\d|30|31)\d{3}(\d|X|x)$)/,
      //       message: '请输入正确的证件号'
      //     },
      //     {validator: this.IdentityCodeValid, trigger: 'blur'}],
      // }
    }
  },
  //方法
  methods: {
    //添加
    addUser(){
      this.dialogAddUser = !this.dialogAddUser
    },
    addUser1(){
      this.dialogAddUser = !this.dialogAddUser,
          this.$http.get("/AdminController/addAdmin", {
            params: {
              a_id: this.AddUserList.a_id,
              a_name: this.AddUserList.a_name,
              password: this.AddUserList.password,
            }
          }).then((res) => {
            console.log(res)
            this.UserList = res.data;
            if (res.data.code === 1) {
              this.$message.success("添加成功")
              this.getUserList();
            } else this.$message.error("添加失败")
          })
    },
    //关键字搜索
    Search() {
      console.log(this.input3)
      this.$http.get("/AdminController/selectyAdmin", {
        params: {
          page: 1,
          limit: 10,
          Keyword: this.input3,
        }
      }).then((res) => {
        console.log(res.data)
        this.UserList = res.data;
        if (res.data.code === 1) {
          this.$message.success("搜索成功")
        } else this.$message.error("搜索失败")
      })
    },
    //请求查看用户列表数据
    getUserList() {
      this.$http.get("/AdminController/queryAdmin", {
        params: {
          page: this.page,
          limit: this.limit,
        }
      }).then((res) => {
         console.log(res)
        this.UserList = res.data;
        if (res.data.code === 1) {
          this.$message.success("请求成功")
        } else this.$message.error("请求失败")
      })
    },
    //编辑按钮事件
    updateUser(row) {
      this.dialogUpdateUser = !this.dialogUpdateUser
      this.UpdateUserList = row;
      console.log(this.UpdateUserList)
    },
    //确定编辑事件
    updateUser1() {
      this.dialogUpdateUser = !this.dialogUpdateUser,
          this.$http.get("/AdminController/updateAdminPwd", {
            params: {
              password: this.UpdateUserList.password,
            }
          }).then((res) => {
            console.log(res)
            this.UserList = res.data;
            if (res.data.code === 1) {
              this.$message.success("保存成功")
              this.getUserList();
            } else this.$message.error("保存失败")
          })
    },
    //删除按钮事件
    deleteUser(row) {
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$http.get("/AdminController/deleteAdmin", {
          params: {
            a_id: row.a_id,
          }
        }).then((res) => {
          console.log(res)
          if (res.data.code === 1) {
            this.$message.success("删除成功")
            this.getUserList();
          } else this.$message.error("删除失败")
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },
    //每页条数发生改变时触发
    SizeChange(limit) {
      this.limit = limit;
      this.getUserList();
    },
    //页码发生改变时触发
    CurrentChange(page) {
      this.page = page;
      this.getUserList();
    },
  },
  //  钩子函数
  created() {
    this.getUserList();
  }
}
</script>

<style scoped>
.a{
  margin-left: 360px;
  margin-top: 20px;
}
</style>
