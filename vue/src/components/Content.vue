<template>
<div>   <!--    面包屑导航-->
  <el-breadcrumb style="padding-bottom:15px " separator="/">
    <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>系统管理</el-breadcrumb-item>
    <el-breadcrumb-item>召集令管理</el-breadcrumb-item>
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
        <el-button type="primary" size="mini" @click="addNote">添加活动</el-button>
      </el-col>
      <el-col :span="4" style="  position:absolute; left:90%;">
        <el-button type="primary" icon="el-icon-refresh-right" @click="getNoteList"></el-button>
      </el-col>
    </el-row>
    <el-table
        :data="NoteList.data"
        border
        style="width: 100%">
      <el-table-column
          prop="a_id"
          label="id"
          width="627">
      </el-table-column>
      <el-table-column
          prop="title"
          label="标题"
          width="627">
      </el-table-column>
      <el-table-column
          prop="informatin"
          label="内容"
          width="627">
      </el-table-column>

      <el-table-column
          prop="starttime"
          label="开始时间"
          width="627">
      </el-table-column>
      <el-table-column
          prop="endtime"
          label="结束时间"
          width="627">
      </el-table-column>
      <el-table-column
          prop="place"
          label="地点"
          width="627">
      </el-table-column>
      <el-table-column
          prop="joinpeople"
          label="已参加人数"
          width="627">
      </el-table-column>
      <el-table-column
          prop="a_id"
          label="活动id"
          width="627">
      </el-table-column>
      <el-table-column
          prop="picture"
          label="图片"
          width="180">
        <template slot-scope="scope">
          <el-image style="width: 50px; height: 50px; border-radius: 25px" :src="scope.row.picture" fit="cover"/>
        </template>
      </el-table-column>
      <el-table-column
          prop="statecode"
          label="状态码"
          width="627">
      </el-table-column>
      <el-table-column
          prop="sort"
          label="分类"
          width="627">
      </el-table-column>
      <el-table-column
          prop="way"
          label="活动方式"
          width="627">
      </el-table-column>
      <el-table-column
          prop="needpeople"
          label="招募人数"
          width="627">
      </el-table-column>


      <el-table-column
          prop="id"
          label="操作"
          width="627">
        <div slot-scope="a">
          <el-button type="primary" size="mini" @click="updateNote(a.row)">查看/编辑</el-button>
          <el-button type="danger" size="mini" @click="deleteNote(a.row)">删除</el-button>
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
      :total="NoteList.count">
  </el-pagination>
  <el-dialog
      title="编辑活动"
      :visible.sync="dialogUpdateNote"
      width="30%">
    <!--        内容区域-->
    <el-form :model="UpdateNoteList"  ref="ruleForm" label-width="20px" class="demo-ruleForm">
      <el-form-item label="标题" prop="title">
        <el-input  type="textarea" :rows="2" v-model="UpdateNoteList.title" ></el-input>
      </el-form-item>
      <el-form-item label="内容" prop="informatin">
        <el-input type="textarea" :rows="2" v-model="UpdateNoteList.informatin" ></el-input>
      </el-form-item>
      <el-form-item label="图片" prop="picture">
        <el-input v-model="UpdateNoteList.picture" ></el-input>
      </el-form-item>
      <el-form-item label="开始时间" prop="starttime">
        <el-input v-model="UpdateNoteList.starttime" ></el-input>
      </el-form-item>
      <el-form-item label="结束时间" prop="endtime">
        <el-input v-model="UpdateNoteList.endtime" ></el-input>
      </el-form-item>
      <el-form-item label="地点" prop="place">
        <el-input v-model="UpdateNoteList.place" ></el-input>
      </el-form-item>
      <el-form-item label="招募人数" prop="needpeople">
        <el-input v-model="UpdateNoteList.needpeople" ></el-input>
      </el-form-item>
      <el-form-item label="活动方式" prop="way">
        <el-input v-model="UpdateNoteList.way" ></el-input>
      </el-form-item>
      <el-form-item label="状态码" prop="statecode">
        <el-input v-model="UpdateNoteList.statecode" ></el-input>
      </el-form-item>
      <el-form-item label="类别" prop="sort">
        <el-input v-model="UpdateNoteList.sort" ></el-input>
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
    <el-button @click="dialogUpdateNote = false">取 消</el-button>
    <el-button type="primary" @click="updateNote1">保 存</el-button>
  </span>
  </el-dialog>
  <el-dialog
      title="添加树洞小纸条"
      :visible.sync="dialogAddNote"
      width="30%">
    <!--        内容区域-->
    <el-form :model="AddNoteList"  ref="ruleForm" label-width="100px" class="demo-ruleForm">
      <el-form-item label="标题" prop="title">
        <el-input  type="textarea" :rows="2" v-model="AddNoteList.title" ></el-input>
      </el-form-item>
      <el-form-item label="内容" prop="informatin">
        <el-input type="textarea" :rows="2" v-model="AddNoteList.informatin" ></el-input>
      </el-form-item>
      <el-form-item label="图片" prop="picture">
        <el-input v-model="AddNoteList.picture" ></el-input>
      </el-form-item>
      <el-form-item label="开始时间" prop="starttime">
        <el-input v-model="AddNoteList.starttime" ></el-input>
      </el-form-item>
      <el-form-item label="结束时间" prop="endtime">
        <el-input v-model="AddNoteList.endtime" ></el-input>
      </el-form-item>
      <el-form-item label="地点" prop="place">
        <el-input v-model="AddNoteList.place" ></el-input>
      </el-form-item>
      <el-form-item label="招募人数" prop="needpeople">
        <el-input v-model="AddNoteList.needpeople" ></el-input>
      </el-form-item>
      <el-form-item label="活动方式" prop="way">
        <el-input v-model="AddNoteList.way" ></el-input>
      </el-form-item>
      <el-form-item label="状态码" prop="statecode">
        <el-input v-model="AddNoteList.statecode" ></el-input>
      </el-form-item>
      <el-form-item label="类别" prop="sort">
        <el-input v-model="AddNoteList.sort" ></el-input>
      <el-button type="primary" @click="addNote1" class="a">添 加</el-button>
      </el-form-item>
    </el-form>

  </el-dialog>
</div>
</template>

<script>
export default {
  name: "content",
  data(){
    return{
      input3:'',
      page: 1,
      limit: 10,
      NoteList:[],
      UpdateNoteList:{
        a_id:null,
        title:'',
        sort:"",
        informatin:"",
        picture:"",
        starttime:"",
        endtime:"",
        place:"",
        needpeople:"",
        way:"",
        statecode:null,


      },
      AddNoteList:{
        id:'',
        title:'',
        sort:"",
        informatin:"",
        picture:"",
        starttime:"",
        endtime:"",
        place:"",
        needpeople:"",
        way:"",
        statecode:"",
      },
      dialogAddNote: false,
      dialogUpdateNote: false,
    }
  },
  methods:{
    //关键字搜索
    Search() {
      console.log(this.input3)
      this.$http.get("/ActionController/queryAction", {
        params: {
          page: 1,
          limit: 10,
          Keyword: this.input3,
        }
      }).then((res) => {
        console.log(res.data)
        this.NoteList = res.data;
        if (res.data.code === 1) {
          this.$message.success("搜索成功")
        } else this.$message.error("搜索失败")
      })
    },
    //添加
    addNote(){
      this.dialogAddNote = !this.dialogAddNote
    },
    addNote1(){
      this.dialogAddNote = !this.dialogAddNote,
          this.$http.get("/ActionController/addAction", {
            params: {
              a_id: this.AddNoteList.a_id,
              title: this.AddNoteList.title,
              informatin:this.AddNoteList.informatin,
              sort:this.AddNoteList.sort,
              starttime:this.AddNoteList.starttime,
              endtime:this.AddNoteList.endtime,
              needpeople:this.AddNoteList.needpeople,
              way:this.AddNoteList.way,
              picture:this.AddNoteList.picture,
              statecode:this.AddNoteList.statecode,
              place:this.AddNoteList.place,
            }
          }).then((res) => {
            console.log(res)
            this.NoteList = res.data;
            if (res.data.code === 1) {
              this.$message.success("添加成功")
              this.getNoteList();
            } else this.$message.error("添加失败")
          })
    },
    //请求查看用户列表数据
    getNoteList() {
      this.$http.get("/ActionController/selectAction", {
        params: {
          page: this.page,
          limit: this.limit,

        }
      }).then((res) => {
        // console.log(res)
        this.NoteList = res.data;
        if (res.data.code === 1) {
          // this.$message.success("请求成功")
        } else this.$message.error("请求失败")
      })
    },
    //编辑按钮事件
    updateNote(row) {
      this.dialogUpdateNote = !this.dialogUpdateNote
      this.UpdateNoteList = row;
      console.log(this.UpdateNoteList)
    },
    //确定编辑事件
    updateNote1() {
      this.dialogUpdateNote = !this.dialogUpdateNote,
          this.$http.get("/ActionController/updateAction", {
            params: {
              a_id: this.UpdateNoteList.a_id,
              title: this.UpdateNoteList.title,
              informatin:this.UpdateNoteList.informatin,
              sort:this.UpdateNoteList.sort,
              starttime:this.UpdateNoteList.starttime,
              endtime:this.UpdateNoteList.endtime,
              needpeople:this.UpdateNoteList.needpeople,
              way:this.UpdateNoteList.way,
              picture:this.UpdateNoteList.picture,
              statecode:this.UpdateNoteList.statecode,
              place:this.UpdateNoteList.place,
              joinpeople:this.UpdateNoteList.joinpeople,
            }
          }).then((res) => {
            console.log(res)
            if (res.data.code === 1) {
              this.$message.success("保存成功")
              this.getNoteList();
            } else this.$message.error("保存失败")
          })
    },
//删除按钮事件
    deleteNote(row) {
      this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$http.get("/ActionController/deleteAction", {
          params: {
            a_id: row.a_id,
          }
        }).then((res) => {
          console.log(res)
          if (res.data.code === 1) {
            this.$message.success("删除成功")
            this.getNoteList();
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
      this.getNoteList();
    },
    //页码发生改变时触发
    CurrentChange(page) {
      this.page = page;
      this.getNoteList();
    },
  },
  //  钩子函数
  created() {
    this.getNoteList();
  },
}
</script>

<style scoped>
.a{
  margin-left: 360px;
  margin-top: 20px;
}
</style>
