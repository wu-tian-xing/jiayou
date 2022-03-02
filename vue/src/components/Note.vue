<template>
 <div>
   <!--    面包屑导航-->
   <el-breadcrumb style="padding-bottom:15px " separator="/">
     <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
     <el-breadcrumb-item>系统管理</el-breadcrumb-item>
     <el-breadcrumb-item>聚节阁管理</el-breadcrumb-item>
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
         <el-button type="primary" size="mini" @click="addLog">添加节日作品</el-button>
       </el-col>
       <el-col :span="4" style="  position:absolute; left:90%;">
         <el-button type="primary" icon="el-icon-refresh-right" @click="getLogList"></el-button>
       </el-col>
     </el-row>
     <el-table
         :data="LogList.data"
         border
         style="width: 100%">
       <el-table-column
           prop="id"
           label="作品id"
           width="180">
       </el-table-column>
       <el-table-column
           prop="title"
           label="标题"
           width="180">
       </el-table-column>
       <el-table-column
           prop="details"
           label="内容"
           width="643">
       </el-table-column>
       <el-table-column
           prop="writer"
           label="作者"
           width="643">
       </el-table-column>
       <el-table-column
           prop="festival_id"
           label="节日id"
           width="643">
       </el-table-column>
       <el-table-column
           prop="times"
           label="添加时间"
            width="180">
       </el-table-column>
         <el-table-column
             prop="actions"
             label="活动类别"
             width="643">
       </el-table-column>
       <el-table-column
           prop="pucture"
           label="图片"
           width="180">
         <template slot-scope="scope">
           <el-image style="width: 50px; height: 50px; border-radius: 25px" :src="scope.row.pucture" fit="cover"/>
         </template>
       </el-table-column>
       <el-table-column
           prop="id"
           label="操作"
           width="250">
         <div slot-scope="a">
           <el-button type="primary" size="mini" @click="updateLog(a.row)">查看/编辑</el-button>
           <el-button type="danger" size="mini" @click="deleteLog(a.row)">删除</el-button>
         </div>
       </el-table-column>
     </el-table>
   </el-card>
   <!--      分页控件-->
   <el-pagination
       @size-change="SizeChange"
       @current-change="CurrentChange"
       :current-page="page"
       :page-sizes="[10, 20, 50, 100]"
       :page-size="limit"
       layout="total, sizes, prev, pager, next, jumper"
       :total="LogList.count">
   </el-pagination>
   <el-dialog
       title="编辑作品"
       :visible.sync="dialogUpdateLog"
       width="30%">
     <!--        内容区域-->
     <el-form :model="UpdateLogList"  ref="ruleForm" label-width="100px" class="demo-ruleForm">
       <el-form-item label="标题" prop="title">
         <el-input v-model="UpdateLogList.title" ></el-input>
       </el-form-item>
       <el-form-item label="内容" prop="details">
         <el-input type="textarea" :rows="2" v-model="UpdateLogList.details" ></el-input>
       </el-form-item>
       <el-form-item label="图片" prop="pucture">
         <el-input v-model="UpdateLogList.pucture" ></el-input>
       </el-form-item>
       <el-form-item label="作者" prop="writer">
         <el-input v-model="UpdateLogList.writer" ></el-input>
       </el-form-item>
       <el-form-item label="节日id" prop="festival_id">
         <el-input v-model="UpdateLogList.festival_id" ></el-input>
       </el-form-item>
       <el-form-item label="类别" prop="actions">
         <el-input v-model="UpdateLogList.actions" ></el-input>
       </el-form-item>
     </el-form>
     <span slot="footer" class="dialog-footer">
    <el-button @click="dialogUpdateLog = false">取 消</el-button>
    <el-button type="primary" @click="updateLog1">保 存</el-button>
  </span>
   </el-dialog>
   <el-dialog
       title="添加作品"
       :visible.sync="dialogAddLog"
       width="30%">
     <!--        内容区域-->
     <el-form :model="AddLogList"  ref="ruleForm" label-width="100px" class="demo-ruleForm">
       <el-form-item label="作品id" prop="id">
         <el-input v-model="AddLogList.title" ></el-input>
       </el-form-item>
       <el-form-item label="标题" prop="title">
         <el-input v-model="AddLogList.title" ></el-input>
       </el-form-item>
       <el-form-item label="作者" prop="writer">
         <el-input v-model="AddLogList.writer" ></el-input>
       </el-form-item>
       <el-form-item label="节日id" prop="festival_id">
         <el-input v-model="AddLogList.festival_id" ></el-input>
       </el-form-item>
       <el-form-item label="类别" prop="actions">
         <el-input v-model="AddLogList.actions" ></el-input>
       </el-form-item>
       <el-form-item label="图片" prop="pucture">
         <el-input v-model="AddLogList.pucture" ></el-input>
       </el-form-item>
       <el-form-item label="内容" prop="details">
         <el-input type="textarea" :rows="2" v-model="AddLogList.concent" ></el-input>
       </el-form-item>
       <el-button type="primary" @click="addLog1" class="a">添 加</el-button>
     </el-form>

   </el-dialog>
 </div>
</template>

<script>
export default {
  name: "Note",
  data(){
    return{
      input3:'',
      page: 1,
      limit: 10,
      LogList:[],
      UpdateLogList:{
        id:'',
        title:'',
        details:'',
        pucture:"",
        writer:"",
        festival_id:"",
        actions:"",
      },
      AddLogList:{
        id: "",
        title: "",
        details: "",
        pucture: "",
        writer: "",
        times: "",
        festival_id: "",
        actions: "",
 },
      dialogAddLog: false,
      dialogUpdateLog: false,
    }
  },
  //方法
  methods:{

    //关键字搜索
    Search() {
      console.log(this.input3)
      this.$http.get("/FestivalActionController/selectFestivalWork", {
        params: {
          page: 1,
          limit: 10,
          Keyword: this.input3,
        }
      }).then((res) => {
        console.log(res.data)
        this.LogList = res.data;
        if (res.data.code === 1) {
          this.$message.success("搜索成功")
        } else this.$message.error("搜索失败")
      })
    },
    //添加
    addLog(){
      this.dialogAddLog = !this.dialogAddLog
    },
    addLog1(){
      this.dialogAddLog = !this.dialogAddLog,
          this.$http.get("/FestivalActionController/addFestivalAction", {
            params: {
              id: this.AddLogList.id,
              title: this.AddLogList.title,
              details: this.AddLogList.concent,
              writer:this.AddLogList.writer,
              times:this.AddLogList.times,
              festival_id:this.AddLogList.festival_id,
              actions:this.AddLogList.actions,
            }
          }).then((res) => {
            console.log(res)
            this.LogList = res.data;
            if (res.data.code === 1) {
              this.$message.success("添加成功")
              this.getLogList();
            } else this.$message.error("添加失败")
          })
    },
    //请求查看用户列表数据
    getLogList() {
      this.$http.get("/FestivalActionController/queryFestivalAction", {
        params: {
          page: this.page,
          limit: this.limit,
        }
      }).then((res) => {
         console.log(res)
        this.LogList = res.data;
        if (res.data.code === 1) {
           this.$message.success("请求成功")
        } else this.$message.error("请求失败")
      })
    },
    //编辑按钮事件
    updateLog(row) {
      this.dialogUpdateLog = !this.dialogUpdateLog
      this.UpdateLogList = row;
      console.log(this.UpdateLogList)
    },
    //确定编辑事件
    updateLog1() {
      this.dialogUpdateLog = !this.dialogUpdateLog,
          this.$http.get("/FestivalActionController/updateFestivalAction", {
            params: {
              id: this.UpdateLogList.id,
              title: this.UpdateLogList.title,
              pucture: this.UpdateLogList.pucture,
              writer: this.UpdateLogList.writer,
              festival_id: this.UpdateLogList.festival_id,
              actions: this.UpdateLogList.actions,
              details:this.UpdateLogList.details,

            }
          }).then((res) => {
            console.log(res)
            if (res.data.code === 1) {
              this.$message.success("保存成功")
              this.getLogList();
            } else this.$message.error("保存失败")
          })
    },
//删除按钮事件
    deleteLog(row) {
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$http.get("/FestivalActionController/deleteFestivalAction", {
          params: {
            id: row.id,
          }
        }).then((res) => {
          console.log(res)
          if (res.data.code === 1) {
            this.$message.success("删除成功")
            this.getLogList();
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
      this.getLogList();
    },
    //页码发生改变时触发
    CurrentChange(page) {
      this.page = page;
      this.getLogList();
    },
  },

//  钩子函数
created() {
  this.getLogList();
},
}

</script>

<style scoped>
.a{
  margin-left: 360px;
  margin-top: 20px;
}
</style>
