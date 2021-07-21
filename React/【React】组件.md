### 1.创建第一个react组件
用到以下情况：
```
1. react要求：组件名称的第一个字母必须使用大写，如果是小写，react会认为这是heml标签
2. render()函数必须有
3. constructor()函数建议有
4. return返回部分，一定用（）包起来，并且（和return一行, 代码规范
5. JSX的模板
6. 变量放在对象上
7. 使用get() 和set() 方法
```
```js
<script type = text/babel>
    class MyComponent extends React.Component{
        constructor(props){
            super(props);
            this._name = '小小梦';
            this._age = '23';
        }

        get name(){
            return `get方法获取${this._name}`;
        }
        get age(){
            return this._age;
        }
        set name(name){
            this._name = name;
        }
        set age(age){
            this._age = age;
        }

        render(){
            // 用属性获取
            // return <span>Hello, {this._name}</span>
            // 用get方法获取
            return <span>Hello, {this.name}</span>
        }
    }

    ReactDOM.render(
        <MyComponent />,
        app
    );
</script>
```

### 2.调用组件时传递参数
#### 情况1：传字符串
```js
<script type="text/babel">
    class MyConponent extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            return(
                <div>
                    <h4>{this.props.name}</h4>		//小小梦
                    <h4>{this.props.age + 1}</h4>   //注意：不是24，是231（23被当成字符串了）
                </div>
            );
        }
    }

    ReactDOM.render(
        // 传参数name，age
        <MyConponent name = "小小梦" age = "23"/>,
        app
    );
</script>
```
上面的23是被当成字符串了，所以输出231，如果解决这个问题，我们需要把变量当成参数传递
#### 情况2：传变量
```js
<div id="app"></div>
<script type="text/babel">
    class MyConponent extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            return(
                <div>
                    <h4>{this.props.name}</h4>
                    <h4>{this.props.age + 1}</h4>   {/*不是24，是231（23被当成字符串了）*/}
                </div>
            );
        }
    }


    let age = 23;
    ReactDOM.render(
        // 传参数name，age
        <MyConponent name = "小小梦" age = {age}/>,
        app
    );
</script>
```
#### 情况3：传对象
```js
<div id="app"></div>
<script type="text/babel">
    class MyConponent extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            return(
                <div>
                    <h4 style={this.props.style}>{this.props.name}</h4>     // 接受传来的对象
                    <h4>{this.props.age + 1}</h4>   {/*不是24，是231（23被当成字符串了）*/}
                </div>
            );
        }
    }


    let age = 23;
    let style = {color: "red", backgroundColor: "black"};   // 传对象
    ReactDOM.render(
        // 传参数name，age
        <MyConponent name = "小小梦" age = {age} style = {style}/>,       // 传字符串、变量、对象
        app
    );
</script>
```

### 3. 标签里key的重要性
把组件和html代码先赋值给变量，让代码更优雅
```js
<div id="app"></div>
<script type="text/babel">
    class MyConponent extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            // 这里也可以赋值变量里
            let name = ['小小梦1', '小小梦2', '小小梦3']

            // 用map的写法很优雅
            let htmlPra = name.map((element) =>
                <h4>{element}</h4>
            )

            return(
                <div>
                    {htmlPra}
                </div>
            );
        }
    }

    // 组件赋值给变量
    let comp = <MyConponent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```

上面的代码里还有一个报错
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/16bf556c7dbc4c94a6441eddd6eb4d76~tplv-k3u1fbpfcp-watermark.image)

原因：因为最后有3个&lt;h4&gt;标签，react要求相同的标签要有不同的key进行区分，因为这样速度更快，所以可以把上面的数组赋值改成对象赋值，这样就不会报错了。

```
<div id="app"></div>
<script type="text/babel">
    class MyConponent extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            // 这里也可以赋值变量里
            let name = [
                {
                    id: '01',
                    name: '小小梦1'
                },
                {
                    id: '02',
                    name: '小小梦2'
                },
                {
                    id: '03',
                    name: '小小梦3'
                }
            ]

            // 用map的写法很优雅
            let htmlPra = name.map((element) =>
                <h4 key={element.id}>{element.name}</h4>
            )

            return(
                <div>
                    {htmlPra}
                </div>
            );
        }
    }

    // 组件赋值给变量
    let comp = <MyConponent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```

### 4.Virtual DOM（必会！！！）
Virtual DOM是用来解决什么问题的？
- 	每次调用Render() 函数，都会触发DOM的修改 -> layout -> repaint
- 	在jQuery/Zepto年代，这个动作是前端代码直接触发的，在React中，这个动作是框架触发的。
- 	其实可以全部清理掉（tear down）然后重画，但是这样效率太低了。

Virtual DOM整个步骤过程
```
1. 当数据被修改后，React根据新的数据生成一个新的VDOM
2. VDOM，是一个JS对象，类似JSON
3. 新生成的VDOM会和之前的VDOM进行比较（Diff算法）
4. 根据比较得到的不同，生成一个补丁（patch）
5. 基于补丁，更新DOM
```

### 5.组件的嵌套，组件之间传递参数
父给子传
```js
<body>
<div id="app"></div>
<script type="text/babel">
    class Parent extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            // 假装通过ajax得到了数据
            let users = [
                {id: 's01', name: '张三', age: 25},
                {id: 's02', name: '李四', age: 26},
                {id: 's03', name: '王五', age: 27}
            ];


            return(
                <div>
                    {users.map((element) => (
                        <Child key={element.id} name={element.name} age={element.age}/>
                    ))}
                </div>
            );
        }
    }

    class Child extends React.Component{
        constructor(props){
            super(props)
        }

        render(){
            return(
                <div>
                    name: {this.props.name},age: {this.props.age};
                </div>
            )
        }
    }

    // 组件赋值给变量
    let comp = <Parent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>

</body>
```

### 6.做一个登陆模块的组件
使用了bootstrap，加了一些注释
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../node_modules/bootstrap/dist/css/bootstrap.css">
    <script src="./node_modules/jquery/dist/jquery.js"></script>
    <script src="./node_modules/bootstrap/dist/js/bootstrap.js"></script>
    <script src="../node_modules/react/umd/react.development.js"></script>
    <script src="../node_modules/react-dom/umd/react-dom.development.js"></script>
    <script src="../node_modules/babel-standalone/babel.js"></script>
    <title>Title</title>
</head>
<body>
<div id="app"></div>
<script type="text/babel">
    // 输入组件 - 子组件
    class MyInput extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            return(
                <div className="form-group">
                    {/* form-group： 将 label 元素和前面提到的控件包裹在 .form-group 中可以获得最好的排列。*/}
                    <label htmlFor={this.props.myInputId} className="col-sm-2 control-label">{this.props.myLableName}</label>
                    <div className="col-sm-8">
                        {/*所有设置了 .form-control 类的 <input>、<textarea> 和 <select> 元素都将被默认设置宽度属性为 width: 100%;*/}
                        <input type="text" placeholder={this.props.myPlaceHolder} name={this.props.myInputId} className="form-control"/>
                    </div>
                </div>
            );
        }
    }

    // 按钮组件 - 子组件
    class MyButton extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            return(
                <input type="button" value={this.props.action} className="btn btn-primary"/>
            )
        }
    }

    // 整体的登录组件 - 父组件
    class MyLogin extends React.Component{
        constructor(props){
            super(props);
        }

        render(){
            return(
                // .container 类用于固定宽度并支持响应式布局的容器。
                <div className="container">
                    {/*row 行*/}
                    <div className="row">
                        {/* form-horizontal 水平排列的表单*/}
                        <form className="form-horizontal">
                            <MyInput myLableName="账号" myPlaceHolder="请输入账号" myInputId="username"/>
                            <MyInput myLableName="密码" myPlaceHolder="请输入密码" myInputId="password"/>
                            {/* form-group： 将 label 元素和前面提到的控件包裹在 .form-group 中可以获得最好的排列。*/}
                            <div className="form-group">
                                {/*	.col-sm- 列数  小屏幕 平板 (≥768px)*/}
                                <div className="col-sm-8 text-center">
                                    {/* 8 列的中间*/}
                                    <MyButton action="登录"/>&nbsp;
                                    <MyButton action="注册"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            )
        }
    }

    // 组件赋值给变量
    let comp = <MyLogin/>;
    ReactDOM.render(
        comp,
        app
    );

</script>

</body>
</html>
```

### 7.事件
以onclick事件举例

    1. onclick 要变成 onClick(这里用的不是传统事件绑定，是addEventListener的方式)
    2. onClick 必须调用方法
    3. 值要放在state里，更改值需要调用setState() 方法才能再次渲染DOM
    4. this.fn() 调用的时候注意this的指向（下一步说）
```js
<div id="app"></div>
<script type="text/babel">
   
    class MyComponent extends React.Component{
        constructor(props){
            super(props);
            this.state = {
                a : 5
            }
        }

        fn(){
            this.setState({
                a: this.state.a + 1
            })
        }

        render(){
            return(
                <div>
                    <div>{this.state.a}</div>
                    <input type="button" onClick={this.fn.bind(this)} value="+1"/>
                </div>
            );
        }
    }


    // 组件赋值给变量
    let comp = <MyComponent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```

react绑定事件，有一个this的指向需要注意：
```
this.fn() 会调用失败，执行this.setState时报undefined
因为：fn会初始化定义this，而fn里的this是没有setState的，所以报undefined

所以：要改成：this.fn.bind(this)，把fn的this绑定成当前MyComponent对象的
     也可以改成：还是使用this.fn，但是把fn变成箭头函数，因为箭头函数不初始化this，
     		箭头函数this总是指向词法作用域，也就是外层调用者obj，最后能成功调用setState方法
```
```js
问题代码：
class MyComponent extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            a : 5
        }
    }

    fn (){
        console.log(this);
        this.setState({
            a: this.state.a + 1
        })
    }

    render(){
        return(
            <div>
                <div>{this.state.a}</div>
                <input type="button" onClick={this.fn} value="+1"/>
            </div>
        );
    }
}

方法1：
class MyComponent extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            a : 5
        }
    }

    fn (){
        console.log(this);
        this.setState({
            a: this.state.a + 1
        })
    }

    render(){
        return(
            <div>
                <div>{this.state.a}</div>
                <input type="button" onClick={this.fn.bind(this)} value="+1"/>
            </div>
        );
    }
}

方法2：
class MyComponent extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            a : 5
        }
    }

    fn = () =>{
        console.log(this);
        this.setState({
            a: this.state.a + 1
        })
    }

    render(){
        return(
            <div>
                <div>{this.state.a}</div>
                <input type="button" onClick={this.fn} value="+1"/>
            </div>
        );
    }
}

```


### 8.调用组件时传过来的变量都是只读的，只有传对象才能修改
传变量点击修改会报错
```js
<div id="app"></div>
<script type="text/babel">
  class MyComponent extends React.Component{
      constructor(props){
          super(props);
      }

      fn(){
          this.props.a ++;
      }

      render(){
          return(
              <div>
                  <div>{this.props.a}</div>
                  <input type="button" onClick={this.fn.bind(this)} value="+1"/>
              </div>
          );
      }
  }



  let a = 5;
  // 组件赋值给变量
  ReactDOM.render(
      <MyComponent a={a}/>,
      app
  );
</script>
```
报错
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ce9facd3ea2748939efea7ea117f951a~tplv-k3u1fbpfcp-watermark.image)

**把变量放对象里再传递，可以修改**
```js
<script type="text/babel">
    class MyComponent extends React.Component{
        constructor(props){
            super(props);
        }

        fn(){
            this.props.obj.a ++;
            // 更改值需要调用setState() 方法才能再次渲染DOM
            this.setState({});
        }

        render(){
            return(
                <div>
                    <div>{this.props.obj.a}</div>
                    <input type="button" onClick={this.fn.bind(this)} value="+1"/>
                </div>
            );
        }
    }
    
    let obj = {
        a: 5
    };
    // 组件赋值给变量
    ReactDOM.render(
        <MyComponent obj={obj}/>,
        app
    );
</script>
```
### 9.props里的children属性
- 如果有0个：undefined
- 如果有1个：当前节点
- 如果有多个：数组
```js
<div id="app"></div>
<script type="text/babel">
    class MyComponent extends React.Component{
        constructor(props){
            super(props);
        }


        render(){
            return(
                <div>
                    {/*把span放到li里*/}
                    <ul>
                        {this.props.children.map((item) => (
                            <li key={item.props.id}>{item}</li>
                        ))}
                    </ul>
                </div>
            );
        }
    }

    let obj = {
        a: 5
    };
    // 组件赋值给变量
    ReactDOM.render(
        <MyComponent>
            <span id="01">span1</span>
            <span id="02">span2</span>
        </MyComponent>,
        app
    );
</script>
```
### 10.render渲染的3种方式
#### 方式1：setState()【看第7点】
#### 方式2：父组件传值给子组件，父组件的变量修改时，子组件会自动渲染
```js
<div id="app"></div>
<script type="text/babel">
    class Parent extends React.Component{
        constructor(props){
            super(props);

            this.state = {
                a : 5
            }
        }

        fn(){
            this.setState({
                a: this.state.a + 1
            })
        }

        render(){
            return(
                <div>
                    <div>{this.state.a}</div>
                    <input type="button" onClick={this.fn.bind(this)} value="+1"/>
                    <Child prama={this.state.a}></Child>
                </div>
            );
        }
    }

    class Child extends React.Component{
        constructor(props){
            super(props)
        }

        render(){
            return(
                <div>{this.props.prama}</div>
            )
        }
    }

    let comp = <Parent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```
#### 方式3：强制render
```js
<div id="app"></div>
<script type="text/babel">
    class MyComponent extends React.Component{
        constructor(props){
            super(props);

            this.a = 5;
        }

        fn(){
            this.a ++;
            this.forceUpdate();
        }

        render(){
            return(
                <div>
                    <div>{this.a}</div>
                    <input type="button" onClick={this.fn.bind(this)} value="+1"/>
                </div>
            );
        }
    }


    // 组件赋值给变量
    let comp = <MyComponent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```
虽然很方便，但是不到万不得已，不要乱用。他不像vue每次都强制自动更新，是为了提高效率。

### 11.组件的生命周期
vue：有8个

react：
3个阶段
```
1.创建阶段：Mount
2.更新阶段：Update
3.销毁阶段：Unmount
```
4个钩子函数
```
componentWillMount，componentDidMount
componentWillUpdate，componentDidUpdate
```
组件运行过程如下：

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9e97449a31ab467aaf8976583c5929d5~tplv-k3u1fbpfcp-watermark.image)

中间有一个很重要的函数：shouldComponentUpdate()
可以在渲染前做一些控制。
```js
class MyComponent extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            a : 5
        }
    }

    fn(){
        this.setState({
            a: this.state.a + 1
        })
    }

    // 在渲染之前会执行这个函数
    shouldComponentUpdate(nextProps, nextState){
        if(nextState.a % 2){
            //起到单数才渲染一次的效果
            return true;
        }else{
            return false;
        }
    }

    render(){
        console.log('渲染！')
        return(
            <div>
                <div>{this.state.a}</div>
                <input type="button" onClick={this.fn.bind(this)} value="+1"/>
            </div>
        );
    }
}
```

### 12. 练习题
```
练习：两个组件，Parent，Child
     Parent host Child
     Parent负责确定用户的id，并且将id传递给Child
     Child根据props传入的id，访问后台数据，把获得的name，age显示出来。
```
代码如下：
```js
<div id="app"></div>
<script type="text/babel">
    class Parent extends React.Component{
        constructor(props){
            super(props);
            this.state = {
                id:1
            };
        }

        next(){
            if(this.state.id < 3){
                this.setState({
                    id: this.state.id + 1
                });
            }else{
                this.setState({
                    id:1
                })
            }
        }

        render(){
            return(
                <div>
                    <input type="button" value="下一个" onClick={this.next.bind(this)}/>
                    <Child id={this.state.id}></Child>
                </div>

            );
        }
    }

    class Child extends React.Component{
        constructor(props){
            super(props);

            this.state = {
                name: '',
                age: ''
            }
        }

        // 渲染条件
        shouldComponentUpdate(nextProps, nextState){
            console.log(nextProps, nextState);
            return(this.props.id != nextProps.id || this.state.name != nextState.name)
        }

        // 更新数据的方法
        loadData(id){
            console.log('根据id更新数据')
            fetch(`data/data${id}.txt`).then(res => {
                res.json().then(data => {
                    this.setState(data);
                })
            })
        }

        componentDidMount(){
            console.log('DidMount' + this.props.id);
            this.loadData(this.props.id);
        }

        componentDidUpdate(){
            console.log('DidUpdate' + this.props.id);
            this.loadData(this.props.id);
        }


        render(){
            console.log(this.props.id);
            return(
                <div>
                    {this.props.id}
                    <div>姓名：{this.state.name}</div>
                    <div>年龄：{this.state.age}</div>
                </div>
            );
        }
    }

    ReactDOM.render(<Parent/>, document.getElementById('app'));
</script>
```

### 13.子组件向父组件传递信息
步骤：
- 父组件向子组件传递一个函数
- 这个函数带有参数
- 子组件触发调用这个函数
```js
<div id="app"></div>
<script type="text/babel">
    class Parent extends React.Component{
        constructor(props){
            super(props);

            this.state = {
                a : 5
            }
        }

        fn(aValue){
            console.log('被调用了')
            this.state.a = aValue;
        }

        render(){
            return(
                <div>
                    {/*父组件传函数给子组件*/}
                    <div>父组件显示：{this.state.a}</div>
                    <Child fatherFn={this.fn.bind(this)}></Child>
                </div>
            );
        }
    }

    class Child extends React.Component{
        constructor(props){
            super(props);

            this.state = {
                childValue: 25
            }
        }

        fn(){
            this.props.fatherFn(this.state.childValue);
        }

        render(){
            return(
                <div>
                    <input type="button" onClick={this.fn.bind(this)} value="子组件调用父组件的函数"/>
                </div>
            )
        }
    }


    // 组件赋值给变量
    let comp = <Parent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```
### 14.父组件访问子组件中的变量
**用ref**
```
受控表单元素
  input value
  checkbox, raido checked
  select.option selected
  这些元素表单状态的变化是由React控制
非受控表单元素
  defaultValue
```

```
表单受控元素的处理办法：
1. 初始化一个状态
2. 绑定
3. onChange事件
```
```js
class Parent extends React.Component{
    constructor(props){
        super(props);

        this.state = {
            a : "请修改"
        }
    }

    handleChange(event){
        this.setState({
            a: event.target.value
        })
    }

    // DidMount在Render之后，这里才能获取到子组件的值
    // 直接在render() 里是获取不到的
    componentDidMount(){
        console.log('子组件的值：' + this.refs.reactChild.state.childValue);
    }

    render(){
        return(
            <div>
                <div>父组件变量：{this.state.a}</div>
                <Child ref="reactChild"></Child>
                <input value={this.state.a} type="text" onChange={this.handleChange.bind(this)}/>
            </div>
        );
    }
}

class Child extends React.Component{
    constructor(props){
        super(props);

        this.state = {
            childValue: 25
        }
    }

    render(){
        return(
            <div>
                <div>子组件</div>
            </div>
        )
    }
}
```

### 15.父组件访问子组件里的函数
- 在父组件中引用子组件
- 1. 调用子组件的函数
- 2. 调用子组件函数同时传递参数
- 3. ref不可重复，如果重复，在先的组件将被覆盖

```js
<script type="text/babel">
    class Parent extends React.Component{
        constructor(props){
            super(props);

            this.state = {
                a : "受控表单元素的修改",
                getChildValue: '',
            }
        }

        handleChange(event){
            this.setState({
                a: event.target.value
            })
        }

        // DidMount在Render之后，这里才能获取到子组件的值
        // 直接在render() 里是获取不到的
        componentDidMount(){
            console.log('子组件的值：' + this.refs.reactChild.state.childValue);
            this.setState({
                getChildValue : this.refs.reactChild.state.childValue
            })

            //  调用子组件的方法
            this.refs.reactChild.fn();
            this.refs.reactChild.fn2(2);

        }

        render(){
            return(
                <div>
                    <Child ref="reactChild"></Child>
                    <div>父组件变量：{this.state.a}</div>
                    <div>子组件的变量: {this.state.getChildValue}</div>

                    <input value={this.state.a} type="text" onChange={this.handleChange.bind(this)}/>

                </div>
            );
        }
    }

    class Child extends React.Component{
        constructor(props){
            super(props);

            this.state = {
                childValue: 25
            }
        }

        fn(){
            console.log('我是子组件的函数');
        }

        fn2(value){
            console.log(`我是子组件的函数,参数为${value}`);
        }

        render(){
            return(
                <div>
                    <div>子组件</div>
                </div>
            )
        }
    }


    // 组件赋值给变量
    let comp = <Parent/>;
    ReactDOM.render(
        comp,
        app
    );
</script>
```


