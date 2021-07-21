这篇文章是总结我在仿京东商城项目中的重点内容，也是面试中会经常问到的，通过梳理让自己更好的掌握，形成知识体系，也希望对大家有帮助。

项目地址：(https://github.com/DreamLing-728/react-mobile-JD-shop)
### 1.  CSS3的新特性总结。
CSS主要在边框、背景、文字、过渡四个方面新增了一些属性。

**1.1 边框**
```CSS
border-radius：10px;		// 为边框设置圆角
border-color: #ff0000;		// 为边框设置颜色，但是单独设置是不会起作用的，要搭配属性border-style:solid; 
box-shadow: 10px 10px 5px #888888;		// 用于添加阴影效果
```
**1.2 背景**
```CSS
background-size: 80px 60px;		// 可以直接指定图片的尺寸，在 CSS3 之前，背景图片的尺寸是由图片的实际尺寸决定的
background-origin: content-box;		// 可以指定背景图片放置的区域，有 content-box、padding-box 或 border-box 区域
```
**1.3 文字**
```CSS
text-shadow: 5px 5px 5px #FF0000;		// 给文字设置阴影
word-wrap: break-word;		// 对长单词进行拆分，并换行到下一行
```

**1.4 动画**

**变换效果，transform属性，对应的值有如下几种：**
- transform：translate(x,y)		// 	定义 2D 转换。
- transform：scale(x,y)		// 	定义 2D 缩放。
- transform：rotate(angle)	// 定义 2D 旋转
- transform：translate3d(x,y,z)		// 	定义 3D 转换。
- transform：scale3d(x,y,z)		// 	定义 3D 缩放。
- transform：rotate3d(x,y,z,angle)	// 定义 3D 旋转

**动画效果，animation属性，对应的值有如下几种：**
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/56fb815ebae34751b685fcc8b523347c~tplv-k3u1fbpfcp-watermark.image)

其中的animation-timing-function的值有如下几种：

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c3ae40bc02864ccbb41088a6b273e7e1~tplv-k3u1fbpfcp-watermark.image)

另一种写法：animation 属性简写，用于设置六个动画属性，语法如下：
```
animation: name duration timing-function delay iteration-count direction;
```
**过渡效果：transition属性**
transition的语法和animation一样：
```
transition: property duration timing-function delay;
```
对应的值如下

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/54f55ec704794b18bd36a3246dcb9186~tplv-k3u1fbpfcp-watermark.image)

property：width、height
timing-function的值和上面animation部分的timing-function值一样

**1.4 Css3中有一个布局神器flex**

display:flex是我在项目中用得最多的内容，相信我，只要你用过都会觉得真香。举个栗子，有三个div，你想让这三个div左中右个一个，只需要在三个div的父元素设置如下：
```css
父元素 {
	display: flex;
    justify-content: space-between
    align-item: center
}
```
其中flex的用法非常多，有一篇文章写得很好，介绍给大家[https://www.cnblogs.com/qingchunshiguang/p/8011103.html](https://www.cnblogs.com/qingchunshiguang/p/8011103.html)

### 2. 浏览器兼容的总结
常见的不同浏览器下属性的书写格式
```CSS
transform:rotate(7deg);
-ms-transform:rotate(7deg); 	/* IE 9 */
-moz-transform:rotate(7deg); 	/* Firefox */
-webkit-transform:rotate(7deg); /* Safari 和 Chrome */
-o-transform:rotate(7deg); 	/* Opera */
```
**2.1 在某些浏览器中，图片默认有间隙**

解决方案：

1）给img标签添加左浮动float：left；

2）给img标签添加display：block；

**2.2 不同浏览器的标签默认的margin和padding不同**

解决方案：
```
body,h1,h2,h3,ul,li,input,div,span,a,form …… { margin:0; padding:0; }
```

**2.3 块属性标签float后，又有横行的margin情况下，在IE6显示margin比设置的大**

解决方案：

在float的标签样式控制中加入 display:inline;将其转化为行内属性 

2.4 react项目兼容IE


### 3. fecth和axios的使用总结

fetch和axios都是基于Promise设计的用于前后端进行数据交互的方法。

**Fetch（即ajax2.0）**

把fetch的使用封装到request.js文件里，Fetch方法是react自带的：
```js
function request(pUrl, pType = 'get', data = {}) {
    let config = {}, params = [], headers = null;

    if (pType === 'get') {
        config = {
            method: pType
        }
    } else if (pType === 'post') {
        headers = {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
        for (let key in data) {
            params.push(key + '=' + data[key])
        }
        config = {
            method: pType,
            headers,
            body: params.join('&')
        }
    } else {
        pType = 'post';
        if (data instanceof Object) {
            params = new FormData();
            for (let key in data) {
                params.append(key, data[key]);
            }
        }
        config = {
            method: pType,
            body: params
        }
    }
    
    return fetch(pUrl, config).then((res) => {
        return res.json();
    })
}

export {
    request
};
```
**axios的使用**

同样也是讲axios的请求封装到request.js的文件中，方便其他模块的调用
```js
import axios from 'axios';

function request(pUrl, pType = 'get', data = {}) {
    let config = {}, params = [], headers = null;

    if (pType === 'get') {
        config = {
            method: pType
        }
    } else if (pType === 'post') {
        headers = {
            'Content-Type': 'application/x-www-form-urlencoded'
        }
        for (let key in data) {
            params.push(key + '=' + data[key])
        }
        config = {
            method: pType,
            headers,
            body: params.join('&')
        }
    } else {
        pType = 'post';
        if (data instanceof Object) {
            params = new FormData();
            for (let key in data) {
                params.append(key, data[key]);
            }
        }
        config = {
            method: pType,
            body: params
        }
    }

    return axios(pUrl, config).then((res) => {
        return res.data
    }).catch((e) => {
        console.log('网络错误', e)
    })
}

export {
    request
};
```

### 4. 缓存技术的总结
参考的这篇文章，写得针不戳。[彻底弄懂强缓存与协商缓存](https://www.jianshu.com/p/9c95db596df5)

**缓存的优点**
```
1. 减少不必要的数据传输，可以节省带宽
2. 可以减少服务器的负担，提升网站性能
3. 可以加快网站的速度，用户体验更加友好
```
**缓存的缺点**
```
资源如果有更改但是客户端不及时更新会造成用户获取信息滞后，如果老版本有bug的话，情况会更加糟糕。
```
**强缓存和协商缓存**

缓存部分需要搞懂强缓存和协商缓存。简单理解强缓存就是在客户端缓存的，协商缓存则涉及服务端，需要客户端给服务端发送HTTP请求。

**强缓存的用法**

强缓存是由服务端配置的，当客户端向服务端请求文件，服务端会在response header 里对文件做缓存配置。

比如设置：cahe-control:max-age=31536000,public,immutable

max-age表示缓存的时间是31536000秒（1年），public表示可以被浏览器和代理服务器缓存，immutable是想让用户在刷新页面是也不向服务器发送HTTP请求。（如果浏览器向服务器发送请求就是走的协商缓存）

**强缓存常见的配置如下：**
```js
1. cache-control: max-age=xxxx，public
代表缓存时间是XXXX秒，public表示被浏览器和代理服务器缓存，但是如果当用户主动点击刷新按钮时，浏览器就会对服务器发送请求（即走协商缓存）

2. cache-control: max-age=xxxx，private
private代表资源只能被浏览器缓存，代理服务器不缓存，

3. cache-control: no-cache
不在客户端做强缓存，但是任然在服务端做协商缓存，每次访问都请求服务器

4. cache-control: no-store
不缓存，这个会让客户端、服务器都不缓存，也就没有所谓的强缓存、协商缓存了。
```
**关于协商缓存的配置**

协商缓存也是在服务端的response header配置，etag和last-modified这两个参数，比如：
```js
etag: '5c20abbd-e2e8'
last-modified: Mon, 24 Dec 2020 09:49:49 GMT
```
etag： 就是文件打包后的hash值，唯一
last-modified: 就是文件最后一次修改的时间，精确到秒

当强缓存过期时，走协商缓存的过程是这样的：

情况1：

用户发请求 --> 客户端判断缓存资源是否过期（强缓存）--> 如果过期 --> 客户端给服务端发送http请求 -->  服务端判断资源是否过期 --> 如果没有过期 --> 返回304状态码 --> 返回老资源

情况2：
用户发请求 --> 客户端判断缓存资源是否过期（强缓存）--> 如果过期 --> 客户端给服务端发送http请求 -->  服务端判断资源是否过期 --> 如果过期 --> 返回200状态码 --> 客户端如第一次接收该资源一样，记下它的cache-control中的max-age、etag、last-modified等

### 5. react-redux异步数据流的总结
参考文章，[一篇文章总结redux、react-redux、redux-saga](https://juejin.cn/post/6844903846666321934)

**为什么需要使用redux？**

redux是解决组件之间的通信以及项目的状态变量的保存问题。我们知道组件里有props和state，props是父级分发下来的属性，state是组件内部自行管理的状态，且react的数据流是单向的。如果当react项目的组件层级很多和状态非常复杂时，是不利于数据的管理的，redux的出现可以解决这个问题，可以把数据同一个放到一个地方（即store里）

**什么情况下需要使用redux**

实际上我们大多数情况下不会用到redux，有人曾说过："如果你不知道是否需要 Redux，那就是不需要它。"实际上，我们在遇到react解决不了问题时，才会用到redux。以我的商城项目为例，共有3个地方用到 redux。
- 1. 购物车数据：不同的组件对购物车数据进行展示和操作。
- 2. 用户数据：很多组件都会判断通过用户信息数据来判断登录情况。
- 3. 历史搜索记录：多个页面都会用到搜索组件，且搜索组件里涉及了搜索记录的数据。

**怎么使用react-redux？**

使用react-redux会涉及好多新的名词，我们一个个来看看：

```
1. store: 就是数据存储的地方

2. dispatch: 是store里的一个方法，如果想改变store里的数据，就必须调用dispatch方法（例：this.props.dispatch()）

3. action: 也是一个方法，但是是dispatch方法里的参数，即具体要怎么修改数据（例：this.props.dispatch(action.cart.decAmount({ index: index }))）

4. reducer：dispatch方法会把action的指令放到reducer这个加工函数中，然后返回新的state

5. Provider: 顶层组件，同时要把store放到Provider组件里，才能让所有组件都访问里面的数据

6. connect： 为了让组件可以直接调用this.props.dispatch
```
我们以用户数据为例，把完整的redux过程走一遍

**第一步：action部分**

目录如下：

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c4caf7364ea14d56882e6cf292e50e5d~tplv-k3u1fbpfcp-watermark.image)

useraction.js
```js
// 登录会员
function login(data) {
    return {
        type: 'login',
        data: data
    }
}

// 退出会员
function outLogin() {
    return {
        type: 'outLogin',
        data: {}
    }
}

export {
    login,
    outLogin
}
```
index.js
```js
import * as historykeywords from './hkaction.js';
import * as cartaction from './cartaction';
import * as useraction from './useraction';
export default {
    hk: historykeywords,
    cart: cartaction,
    user: useraction
}
```
**第二步：reducer部分**

目录如下：

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a9284fb06a204c80b10211930e62937f~tplv-k3u1fbpfcp-watermark.image)

userreducer.js
```js
let defaultState = {
    uid: localStorage['uid'] !== undefined ? localStorage['uid'] : '',
    nickname: localStorage['nickname'] !== undefined ? localStorage['nickname'] : '',
    authToken: localStorage['authToken'] !== undefined ? localStorage['authToken'] : '',
    isLogin: localStorage['isLogin'] !== undefined ? Boolean(localStorage['isLogin']) : false
}

function userReducer(state = defaultState, action) {
    switch (action.type) {
        case 'login':
            tologin(state, action.data);
            return Object.assign({}, state, action)
        case 'outLogin':
            outLogin(state, action.data);
            return Object.assign({}, state, action)
        default:
            return state;
    }
}

function tologin(state, action) {
    state.uid = action.uid;
    state.nickname = action.nickname;
    state.authToken = action.authToken;
    state.isLogin = true;
}

function outLogin(state, action) {
    localStorage.removeItem('uid');
    localStorage.removeItem('nickname');
    localStorage.removeItem('auth_token');
    localStorage.removeItem('isLogin');
    state.uid = '';
    state.nickname = '';
    state.authToken = '';
    state.isLogin = false;
}

export default userReducer;
```
index.js
```js
import {combineReducers} from "redux";
import hkReducer from './hkreducer.js';
import cartReducer from './cartreducer.js';
import userReducer from './userreducer.js'
let reducers=combineReducers({
    hk: hkReducer,
    cart: cartReducer,
    user: userReducer
});

export default reducers;
```

**第三步：Provider，把数据放到顶层组件**

根目录下index.js
```js
/*eslint-disable*/
import 'babel-polyfill';
import 'url-search-params-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import RouterComponent from './router';
import * as serviceWorker from './serviceWorker';
import "./assets/css/common/public.css";
import {createStore} from 'redux';
import {Provider} from 'react-redux';
import reducers from './reducers';

let store = createStore(reducers);
class Index extends React.Component{
    render(){
        // console.log(localStorage);
        return(
            <React.Fragment>
                <Provider store = {store}>
                    <RouterComponent></RouterComponent>
                </Provider>
            </React.Fragment>
        )
    }
}

ReactDOM.render(<Index/>, document.getElementById('root'));

serviceWorker.unregister();
```

**第四步：组件中使用store**

模块引入
```js
import action from '../../../actions';
import { connect } from 'react-redux';
```
用connect封装组件
```js
export default connect((state) => {
    return {
        state
    }
})(LoginIndex)
```
方法调用
```js
this.props.dispatch(action.user.login(
                {
                    uid: res.data.uid,
                    nickname: res.data.nickname,
                    auth_token: res.data.auth_token,
                    isLogin: true
                }
            ))
```
完整的四个步骤做完，用redux实现的登录功能就做好了。

### 6. 项目里的懒加载

实际项目中，性能使我们不得不考虑的问题，懒加载是我们优先采取的方式，懒加载就涉及了组件、图片、路由、antd等都需要考虑。

**6.1 图片的懒加载**

**方式1：使用echo.js**

图片的懒加载我们需要用到一个插件echo.js,不需要依赖jquery，且是一个轻量级的插件，可以直接放到项目里，用echo.js我们可以控制只加载可视区域范围的数据，其他地方的数据只有当滚动条滚到时才开始加载。

下载地址：https://github.com/helijun/helijun/tree/master/plugin/echo

使用方式：

第一步：自己封装一个lazyImg模块，然后在模块里引入echo.js插件
```js
import echo from '../libs/echo.js';
function lazyImg(){
    echo.init({
        offset : 100,// 超过可视区域多少像素可以被加载
        throttle : 0 // 设置图片延迟加载的时间
    });
}
export {
    lazyImg
}
```

第二步：获取图片资源的时候，加载lazyImg模块
```js
import {lazyImg} from '../../../assets/js/utils/util';
this.setState({
                aGoods: res.data,
                itemTotal: res.pageinfo.total
            }, () => {
                lazyImg()
            })

```

第三步：在<img>标签的src属性预设图片地址，在data-echo属性设置真正需要加载的图片
```html
<img data-echo={item2.image} src={require("../../../assets/images/common/lazyImg.jpg")} alt={item2.title} />
```

**方式2：前后端配合进行分页请求资源**

第一步：封装一个UpRefresh.js

```js
/*eslint-disable*/
var UpRefresh=function(opts,callback){
    if(opts instanceof Object) {
        this.opts = opts;
        this.iMaxPage=this.opts.maxPage;
        this.fnCallback=callback;
        this.iOffsetBottom=this.opts.offsetBottom;
        this.iCurPage=this.opts.curPage;
        this.init();
    }
};
UpRefresh.prototype={
    init:function(){
        var _this=this;
        _this.eventScroll();
    },
    eventScroll:function(){
        var _this=this;
        window.addEventListener("scroll",_this.scrollBottom());
    },
    scrollBottom:function(){
        var _this=this;
        var bScroll=true;
        return function(){
            if(!bScroll){
                return;
            }
            bScroll=false;
            setTimeout(function(){
                //整个页面滚动条的高度
                var iScrollHeight=document.documentElement.offsetHeight || document.body.offsetHeight;
                //滚动到当前的距离
                var iScrollTop=document.documentElement.scrollTop || document.body.scrollTop;
                //整个窗体的高度
                var iWinHeight=document.documentElement.clientHeight || document.body.clientHeight;
                if(iScrollHeight-(iWinHeight+iScrollTop)<=_this.iOffsetBottom){
                    if(_this.iCurPage<_this.iMaxPage) {
                        _this.iCurPage++;
                        _this.fnCallback(_this.iCurPage);
                    }
                }
                bScroll=true;
            },100);
        }
    }
};

//这个判断支持模块化比如react和vue
if ( typeof module != 'undefined' && module.exports ) {
    module.exports = UpRefresh;
} else if ( typeof define == 'function' && define.amd ) {
    define( function () { return UpRefresh; } );
} else if(typeof window != "undefined") {
    window.UpRefresh = UpRefresh;
}
```

第二步：在组件中的使用
```js
import UpRefresh from '../../../assets/js/libs/uprefresh.js';  //模块引入

// 加载数据
getPageData() {
    this.setParams();
    let url = config.baseUrl + '/api/home/goods/search?' + this.sParams + '&page=1&token=' + config.token; 
    request(url).then((res) => {
        if(res.code === 200){
            // console.log('search-url-res', url, res);
            this.setState({
                aGoods: res.data,
                itemTotal: res.pageinfo.total
            }, () => {
                lazyImg()
            });
            this.maxPage = res.pageinfo.pagenum;
            this.getScrollPage();
        }else{
            this.setState({aGoods: [], itemTotal: 0})
        }
    })
}

getScrollPage() {
  this.setParams()
  // this.curPage++;
  this.oUpRefresh = new UpRefresh({ 'curPage': this.curPage, 'maxPage': this.maxPage, 'offsetBottom': this.offsetBottom }, curPage => {
      let url = config.baseUrl + '/api/home/goods/search?' + this.sParams + '&page=' + curPage + '&token=' + config.token;;
      request(url).then((res) => {
          // console.log('search-getScrollPage-this.curPage-url-res', this.curPage, url, res);
          if (res.code === 200) {
              // 将当前页的内容和新加载页的内容合并
              let aGoodsTemp = this.state.aGoods;
              for (let i = 0; i < res.data.length; i++) {
                  if (res.data.length > 0) {
                      aGoodsTemp.push(res.data[i])
                  }
              }
              this.setState({
                  aGoods: aGoodsTemp
              }, () => {
                  lazyImg();
              })
          }
      })
  })
}

```

图片懒加载的JS原理：

要实现懒加载，我们需要在添加一个滚动监听事件，
```
window.addEventListener("scroll",_this.scrollBottom());
```
回调函数scrollBottom()的核心内容就是：整体内容的高度(document.offsetHeight)-（网页被卷去的高度(document.scrollTop)+网页可视区高度(document.clientHeight)） <= 指定提前加载多少个像素；

**6.2 路由的懒加载**

我们先了解一下为什么要用到路由懒加载？

这是因为如果路由不进行懒加载，就会自动把所有的js文件打包到一个chunk.js文件里，导致的情况就是首屏加载会很慢，所有我们需要用到路由懒加载。

怎么去实现路由懒加载？

我的项目中使用的是webpack + import(), 同时用到了异步请求async + wait。

async封装好的组件如下
```js
import React, { Component } from "react";

export default function asyncComponent(importComponent) {
    class AsyncComponent extends Component {
        constructor(props) {
            super(props);

            this.state = {
                component: null
            };
        }

        async componentDidMount() {
            const { default: component } = await importComponent();

            this.setState({
                component: component
            });
        }

        render() {
            const C = this.state.component;

            return C ? <C {...this.props} /> : null;
        }
    }

    return AsyncComponent;
}
```

实际的使用
```js
import asyncComponents from './components/async/AsyncComponent';

const HomeComponent=asyncComponents(()=>import('./pages/home/home/index'));
```

**6.3 antd组件的按需引入**

我的项目是使用脚手架create-react-app创建的项目，所以需要以下两个步骤就可以完成antd的按需引入了

- 第一步：安装依赖 npm i babel-plugin-import -D
- 第二步：在package.json中配置如下
```js
"babel": {
    "presets": [
      "react-app"
    ],
    "plugins": [
      [
        "import",
        {
          "libraryName": "antd-mobile",
          "style": "css"
        }
      ]
    ]
  },
```

以上就是项目的全部内容了，其实还可以更加详细的深入研究，后续可能我会每一部分都出一篇文章，如果对你有帮助，就给我一个小小赞吧。