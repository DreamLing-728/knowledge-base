### 1.语法理解

先看一段代码
```js
<!DOCTYPE html>
<html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>Title</title>
      <!--要导入的3个包-->
      <script src="../node_modules/react/umd/react.development.js"></script>
      <script src="../node_modules/react-dom/umd/react-dom.development.js"></script>
      <script src="../node_modules/babel-standalone/babel.js"></script>
  </head>

  <body>
    <div id="app"></div>

    <script type="text/babel">

        let oDIv = document.getElementById('app');

        ReactDOM.render(
            // 1. 必须用一个div把全部的标签包起来
            <div>
                // 2.不能直接使用关键字：for要改成htmlfor
                <label htmlFor="userName">姓名：</label>
                // 3.不能直接使用关键字：class要改成className
                <input name="username" id="userName" className="userName"/>
            </div>,

            oDIv
        )
    </script>
  </body>
</html>
```

### 2.模板的使用
{}使用模板，上面的例子可以修改成：
```js
<script type="text/babel">

    let oDIv = document.getElementById('app');

    var un = 'userName';

    ReactDOM.render(
        <div>
            <label htmlFor = {un}>姓名：</label>
            <input name="username" id="userName" className="userName"/>
        </div>,
        oDIv
    )
</script>
```
**来做3个模板的练习**

练习1：输出：100 * 10的结果

练习2：输出：（100 > 5）&& (5 < 7) = ？

练习3：输出：3 > 2 ? '3>2' : '3 < 2' = ？

```js
<script type="text/babel">

    let oDIv = document.getElementById('app');

    ReactDOM.render(
        <div>
            <p>100 * 10 = {100 * 10}</p>
            <p>(100 &gt; 5) &amp;&amp; (5 &lt; 7) = {((100 < 5) && (5 < 7)).toString()}</p>
            <p>(3 &gt; 2) ? '3 &gt; 2' : '3 &lt; 2' = {(3 > 2 ? '3>2' : '3 < 2')}</p>
        </div>,
        oDIv
    )
</script>
```
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/84066e3b003f4c638f786eec76dfb464~tplv-k3u1fbpfcp-watermark.image)

### 3.react里的注释
JSX的XML部分，不能用ctrl+/
应该用：{/* XXX */}
```js
<script type="text/babel">

    let oDIv = document.getElementById('app');

    ReactDOM.render(
        <div>
            {/* <p>100 * 10 = {100 * 10}</p> */}	// 注释
            <p>(100 &gt; 5) &amp;&amp; (5 &lt; 7) = {((100 < 5) && (5 < 7)).toString()}</p>
            <p>(3 &gt; 2) ? '3 &gt; 2' : '3 &lt; 2' = {(3 > 2 ? '3>2' : '3 < 2')}</p>
        </div>,
        oDIv
    )
</script>
```
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3a2871e85b8b487a8124a070d02acdf4~tplv-k3u1fbpfcp-watermark.image)

### 4.熟悉几个函数
#### 1.函数filter
react里的数组循环
例子：有一个数组[1, 2, 4, 5],去掉数组里小于3的数

之前的写法：
```js
let array = [1, 2, 4, 5];
let array2 = [];
for(let i = 0; i<array.length; i++){
    if(array[i] > 3){
        array2.push(array[i]);
    }
}
console.log(array2);
```
react里的写法：
```js
// 用函数filter实现
let array = [1, 2, 4, 5];
let array2 = array.filter((element, key, array) =>  element > 3);
console.log(array2);
```

#### 2.函数map
案例：把一个数组里的每个值都+1
```
let array = [1, 2, 4, 5];
let array2 = array.map((element, key, array) => element+1);
console.log(array2);
```

#### 3.函数forEach
```js
// 注意forEach是没有返回的
let array = [1, 2, 4, 5];
let array2 = array.forEach((element, key, array) => {return (element + 1)});
console.log(array2);		// undefined

// 正确应该这样用
let array = [1, 2, 4, 5];
array.forEach((element, key, array) => console.log(element,key));
```

#### 4.练习
把数组的value和key挂载到app里

因为是react，得使用ES6里的map函数，函数的写法也使用箭头函数，显得更地道。
```js
let array = [1, 2, 4, 5];
let app = document.getElementById('app');
ReactDOM.render(
    <div>
        {
            array.map((element, key) =>
                <div>
                    <span>{element}</span>
                    <apan>{key}</apan>
                </div>
            )
        }
    </div>,
    app
);
```

### 5.条件渲染
```js
let a = true;
let app = document.getElementById('app');
ReactDOM.render(
    <div>
        {a ? <h4>true</h4> : <h4>false</h4>}
    </div>,
    app
);
```
### 6.设置style 
{JSON对象} = {{color："red", backgroundColor:"black"}}
注意：这里的backgroundColor是驼峰命名，因为是JS里的代码，它到浏览器后会转化成background-color，JS的变量名是不允许有-号的，所以用的是驼峰命名
```js
let a = true;
let app = document.getElementById('app');
ReactDOM.render(
    <div>
        {a ? <h4 style = {{color:"pink"}}>true</h4> : <h4>false</h4>}
    </div>,
    app
);
```

### 总结
JSX的语法特点
- 1. 关键字冲突
- 2. 单一根标签
- 3. 所有标签必须闭合
- 4. 模板
- 5. 注释
- 6. 数组的循环
- 7. 条件渲染
- 8. style



