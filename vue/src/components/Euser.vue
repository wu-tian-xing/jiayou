<template>
<div>
  <!--    面包屑导航-->
  <el-breadcrumb style="padding-bottom:15px " separator="/">
    <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>用户管理</el-breadcrumb-item>
    <el-breadcrumb-item>微信用户列表</el-breadcrumb-item>
  </el-breadcrumb>
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
        <el-button type="primary" size="mini" @click="addEuser">添加微信用户</el-button>
      </el-col>
      <el-col :span="4" style="  position:absolute; left:90%;">
        <el-button type="primary" icon="el-icon-refresh-right" @click="getEuserList"></el-button>
      </el-col>
    </el-row>
    <!--      渲染数据表格-->
    <el-table
        :data="EuserList.data"
        border
        style="width: 100%">
      <el-table-column
          type="index"
          width="35">
      </el-table-column>
      <el-table-column
          prop="u_id"
          label="用户id"
          width="180">
      </el-table-column>
      <el-table-column
          prop="u_name"
          label="昵称"
          width="180">
      </el-table-column>
      <el-table-column
          prop="signature"
          label="个性签名"
          width="180">
      </el-table-column>
      <el-table-column
          prop="statecode"
          label="状态码"
          width="180">
      </el-table-column>
      <el-table-column
          prop="password"
          label="密码"
          width="180">
      </el-table-column>
      <el-table-column
          prop="headphoto"
          label="头像"
          width="180">
        <template slot-scope="scope">
          <el-image style="width: 50px; height: 50px; border-radius: 25px" :src="scope.row.headphoto" fit="cover"/>
        </template>
      </el-table-column>
      <el-table-column
          prop="e_id"
          label="操作"
          width="302">
        <div slot-scope="scope">

          <el-button type="primary" size="mini" @click="updateEuser(scope.row)">查看/编辑</el-button>
          <el-button type="danger" size="mini" @click="deleteEuser(scope.row)">删除</el-button>
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
        :total="EuserList.count">
    </el-pagination>
    <!--      编辑用户dialog对话框-->
    <el-dialog
        title="编辑微信用户"
        :visible.sync="dialogUpdateEuser"
        width="30%">
      <!--        内容区域-->
      <el-form :model="UpdateEuserList"  ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="个性签名" prop="signature">
          <el-input v-model="UpdateEuserList.signature" ></el-input>
        </el-form-item>
        <el-form-item label="状态码" prop="statecode">
          <el-input v-model="UpdateEuserList.statecode"></el-input>
        </el-form-item>


      </el-form>
      <span slot="footer" class="dialog-footer">
    <el-button @click="dialogUpdateEuser = false">取 消</el-button>
    <el-button type="primary" @click="updateEuser1">保 存</el-button>
  </span>
    </el-dialog>
    <el-dialog
        title="添加微信用户"
        :visible.sync="dialogAddEuser"
        width="30%">
      <!--        内容区域-->
      <el-form :model="AddEuserList"  ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="用户id" prop="u_id">
          <el-input v-model="UpdateEuserList.u_id" ></el-input>
        </el-form-item>
        <el-form-item label="昵称 " prop="u_name">
          <el-input v-model="AddEuserList.u_name" ></el-input>
        </el-form-item>
        <el-form-item label="个性签名" prop="signature">
          <el-input v-model="AddEuserList.signature" ></el-input>
        </el-form-item>
        <el-form-item label="状态码" prop="statecode">
          <el-input v-model="AddEuserList.statecode"></el-input>
        </el-form-item>
        <el-form-item label="头像" prop="headphoto">
          <el-input v-model="AddEuserList.headphoto"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="AddEuserList.password"></el-input>
        </el-form-item>
        <el-button type="primary" @click="addEuser1" class="a">添 加</el-button>
      </el-form>

    </el-dialog>
  </el-card>
</div>
</template>

<script>
export default {
  name: "Euser",
  data(){
    return{
      input3: null,
      page: 1,
      limit: 10,
      EuserList: [],
      UpdateEuserList: {
        statecode: '',
        signature: '',
        u_id:'',
      },
      AddEuserList:{
        u_id:null,
        u_name: "",
        signature: "",
        headphoto: "",
        statecode: "",
        password: "",
      },
      dialogUpdateEuser:false,
      dialogAddEuser:false,
    }
  },
  methods:{
    //添加
    addEuser(){
      this.dialogAddEuser = !this.dialogAddEuser
    },
    addEuser1(){
      this.dialogAddEuser = !this.dialogAddEuser,
          this.$http.get("/UserController/addUser", {
            params: {
              u_id: this.AddEuserList.u_id,
              u_name: this.AddEuserList.u_name,
              signature: this.AddEuserList.signature,
              headphoto: this.AddEuserList.headphoto,
              statecode: this.AddEuserList.statecode,
              password: this.AddEuserList.password,
            }
          }).then((res) => {
            console.log(res)
            this.EuserList = res.data;
            if (res.data.code === 1) {
              this.$message.success("添加成功")
              this.getEuserList();
            } else this.$message.error("添加失败")
          })
    },
    //关键字搜索
    Search() {
      console.log(this.input3)
      this.$http.get("/UserController/selectUser", {
        params: {
          page: 1,
          limit: 10,
          Keyword: this.input3,
        }
      }).then((res) => {
        console.log(res.data)
        this.EuserList = res.data;
        if (res.data.code === 1) {
          this.$message.success("搜索成功")
        } else this.$message.error("搜索失败")
      })
    },
    //请求查看用户列表数据
    getEuserList() {
      this.$http.get("/UserController/queryUser", {
        params: {
          page: this.page,
          limit: this.limit,
        }
      }).then((res) => {
        // console.log(res)
        this.EuserList = res.data;
        if (res.data.code === 1) {
          // this.$message.success("请求成功")
        } else this.$message.error("请求失败")
      })
    },
    //编辑按钮事件
    updateEuser(row) {
      this.dialogUpdateEuser = !this.dialogUpdateEuser
      this.UpdateEuserList = row;
      console.log(this.UpdateEuserList)
    },
    //确定编辑事件
    updateEuser1() {
      this.dialogUpdateEuser = !this.dialogUpdateEuser,
          this.$http.get("/UserController/updateUser", {
            params: {
              u_id:this.UpdateEuserList.u_id,
              signature: this.UpdateEuserList.signature,
              statecode: this.UpdateEuserList.statecode,
            }
          }).then((res) => {
            console.log(res)
            this.EuserList = res.data;
            if (res.data.code === 1) {
              this.$message.success("保存成功")
              this.getEuserList();
            } else this.$message.error("保存失败")
          })
    },
    //删除按钮事件
    deleteEuser(row) {
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$http.get("/UserController/deleteUser", {
          params: {
            u_id: row.u_id,
          }
        }).then((res) => {
          console.log(res)
          if (res.data.code === 1) {
            this.$message.success("删除成功")
            this.getEuserList();
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
      this.getEuserList();
    },
    //页码发生改变时触发
    CurrentChange(page) {
      this.page = page;
      this.getEuserList();
    },
  },
  //  钩子函数
  created() {
    this.getEuserList();
  }
}
</script>

<style scoped>
.a{
  margin-left: 360px;
  margin-top: 20px;
}
</style>