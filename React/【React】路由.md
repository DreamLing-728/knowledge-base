### 1. SPA
- Single Application Page
- 只有一个页面作为容器，应用运行过程中没有页面刷新这种丑陋的行为
- 所有的页面专场都通过javascript和AjAx完成

### 2. 需要安装哪些库？
- react-router：核心库，实现了所有路由的核心功能
- react-router-dom：与浏览器DOM配合工作的版本
- react-router-native：与React native配合工作的版本
- react-router-config：用于静态配置

### 3. Router、Route、Link的关系
- Router：路由对象，包括所有的路由配置、链接、逻辑等
- Route：路由表，也称路由配置（相当于组件的挂载点）
- Link：路由跳转（相当于a标签）

### 4. 一个简单路由的例子
```js
function App() {
  return (
    <div className="App">
        <Link to="/">Page 1</Link>
        <Link to="/page2">Page 2</Link>
        <Link to="/page3">Page 3</Link>
		
        // exact：代表精确匹配
        <Route path="/" exact component={page1}/>
        <Route path="/page2" component={page2}/>
        <Route path="/page3" component={page3}/>
    </div>
  );
}
```

### 5. 含有参数的路由例子
上面例子的基础上，在page二里传参数

**APP.js** 传递参数
```js
function App() {
  return (
    <div className="App">
        <Link to="/">Page 1</Link>

        <Link to="/page2/1/小小梦">Page 2（小）</Link>
        <Link to="/page2/2/中中梦">Page 2（中）</Link>
        <Link to="/page2/3/大大梦">Page 2（大）</Link>

        <Link to="/page3">Page 3</Link>
		
        <Route path="/" exact component={page1}/>	
        <Route path="/page2/:id/:name" component={page2}/>
        <Route path="/page3" component={page3}/>
    </div>
  );
}
```
**page2.js** 接收参数
```js
class page2 extends React.Component{
    constructor(props){
        super(props);
    }

    render(){
        console.log(this.props)
        return(
            <div>
                <label>id: </label>
                <div>{this.props.match.params.id}</div>
                <label>name:</label>
                <div>{this.props.match.params.name}</div>
            </div>
        )
    }
}
```

### 6. 实现itemList与item的路由（显示不同层级）

### 7. 实现嵌套路由

### 8. 基于一个Json形成自动嵌套的路由

### 9. 重定向


