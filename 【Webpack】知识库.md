### 1.创建webpack项目以及初始化依赖包
#### 1.1 确认已经安装了npm和cnpm
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/37f5a537d8924294b07e83aa9532f229~tplv-k3u1fbpfcp-watermark.image)
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2f37f223b8fb4cfc874f357c4fc2b847~tplv-k3u1fbpfcp-watermark.image)
#### 1.2 创建项目文件夹
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/048c0333eb814abba8833e3eb68d9cf7~tplv-k3u1fbpfcp-watermark.image)
#### 1.3 创建package.json
cnpm init -y
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0912fbeebdb24e12978e834982b634de~tplv-k3u1fbpfcp-watermark.image)
#### 1.4 安装webpack
cnpm install webpack –g

cnpm install webpack-cli -g

webpack -v

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5841b875b9f34b68bf7405d143a92a59~tplv-k3u1fbpfcp-watermark.image)

#### 1.5 安装react
cnpm install react react-dom -S
```
上线不用的包就-D，上线用到的包就 -S，我们平时用-S的是 react 和 react-dom
```
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/40f239adf1334acaa328eef22c0946ab~tplv-k3u1fbpfcp-watermark.image)

#### 1.6 创建src目录
- 创建index.js
- 创建index.html
- 创建webpack.config.js
- 编译

先看下整体的目录结构

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d22ac01f05ff44fa806c83815d299bf6~tplv-k3u1fbpfcp-watermark.image)

index.js文件
```js
// 导入react包
import React from 'react'
// 导入render方法
import {render} from 'react-dom'


render((
    <div>Hello World</div>
),document.getElementById('app'));
```

index.html文件
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>

<body>
    <div id="app"></div>
    <!--注意：这里引入的是wenpack打包后的文件-->
    <script src="./build/bundle.js"></script>
</body>
</html>
```

webpack.config.js文件
```js
const path = require('path');

module.exports = {
    mode: 'development',
    // js文件可以不写后缀
    entry: './src/index',
    // webpack打包后输出的文件夹
    output: {
        path: path.resolve(__dirname,'build'),
        filename: 'bundle.js'
    },
    module: {
        rules: [
            // ES6 jsx
            {
                test: /\.jsx?/i,
                use: [
                    {
                        loader: 'babel-loader',
                        options: {
                            presets: ['@babel/preset-react']
                        }
                    }
                ]
            }
        ]
    }
};
```
#### 1.7 webpack打包
命令：webpack
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2eae325c261d458f914f7f154866522e~tplv-k3u1fbpfcp-watermark.image)
打包后，根目录下多出一个build文件夹
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8e971c2595094e40830192e0ba5e59aa~tplv-k3u1fbpfcp-watermark.image)

#### 1.8 最后运行HTML，输出Hello World
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/aa4986c513224ad79690b313a5455b42~tplv-k3u1fbpfcp-watermark.image)

###

