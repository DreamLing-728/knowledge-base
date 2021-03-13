### el-pagination
el-pagination的配置
```
<el-pagination
    v-if="paginations.total > 0"    
    :page-sizes="paginations.pageSizes"     // 选择每页显示条数
    :page-size="paginations.pageSize"   // 当前每页显示条数
    :layout="paginations.layout"    // 分页布局的摆放顺序
    :total="paginations.total"  // 总数
    :current-page="paginations.pageIndex"   // 当前页
    @current-change="handleCurrentChange"  // 页面跳转
    @size-change="handleSizeChange"     // 改变每页显示的条数
    >
</el-pagination>
```
paginations对象的设置
```
data () {
    return {
      tableData: [],
      paginations: {
        total: 0, // 总数
        pageIndex: 1, // 当前页
        pageSize: 20, // 1页显示多少条
        pageSizes: [5, 10, 15, 20], // 每页显示多少条
        layout: "total, sizes, prev, pager, next, jumper" //翻页的摆放顺序
      }
    }
  },
```