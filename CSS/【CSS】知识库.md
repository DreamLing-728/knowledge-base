### 题目列表
- 1.简述主要的浏览器内核？
- 2.DIV+CSS布局与table布局比较，有什么优点？
- 3.IE的Quirks模式和Standards模式的区别?
- 4.HTML文件顶部的<!DOCTYPE>的作用？
- 5.简述src和href的区别？
- 6.简述WebP这种图像格式的特点
- 7.网页加载大量图片，如何提高加载速度
- 8.哪些方法可以引入CSS样式
- 9.列举CSS选择器
- 10.什么是CSS Hack？IE 6/7/8/9/10的hack分别是什么？
- 11.块级元素和行内元素的区别？行内元素设置margin和padding的区别？
- 12.rgba()和opacity的区别
- 13.CSS中能让文字在水平和垂直方向重叠的属性是什么
- 14.区分块级元素、行内元素、行内块元素的区别
- 15.论述你知道的居中一个元素的方法
- 16.px，em，rem，%，无单位的区别
- 17.display：none和visibility: hidden的区别？还有什么方法可以让一个元素消失
- 18.CSS link和@import的区别
- 19.介绍盒子模型？IE盒子模型和W3C盒子模型的区别？CSS3中如何设置？
- 20.论述什么是BFC？！！！高级题
- 21.CSS优先级的计算方法?
- 22.display中值的作用
- 23.position中值的作用？
- 24.浮动的知识点
- 25.清除浮动的四种方法
- 26.超链接访问过后hover的样式就不出现了，为什么？
- 27.描述包含块的概念？absolute的包含块计算方式和标准流的包含块有什么不同？
- 28.论述如何使用伪对象（伪元素）after和before？
- 29.html中meta标签的用处？
- 30.论述什么是media query
- 31.z-index叠放次序
- 32.编写一个表格，奇数行的背景颜色是粉色，偶数行的背景颜色是蓝色？
- 33.用CSS画一个三角形？
- 34.让一个宽高都为200px的div居中
- 35.写一个三栏布局，左右固定，中间自适应
- 36.实现两个div，等宽，随body宽度变化，中间有空隙10px
- 37.实现两个div，等宽，随body宽度变化，中间有空隙10px
- 38.html里head标签里的内容设置
### 1.简述主要的浏览器内核？
四大内核
```
- 1.blink：Chrome，Opera（2个都是在13年改用的blink，13年以前，Chrome（webkit），Opera（presto））
- 2.gecko：Firefox
- 3.webkit：Safari
- 4.trident：IE（IE Eage用的不是trident）
```

### 2.DIV+CSS布局与table布局比较，有什么优点？
```
- 1.符合W3C的标准
- 2.结构与样式分离，更易于维护
- 3.只包含HTML结构，可以提高页面的加载速度，同时有利于浏览器对网页的搜索
```

### 3.IE的Quirks模式和Standards模式的区别?
在W3C标准出现以前，IE一直用的是Quirks模式，而支持CSS标准的是Standard模式

区别：
```
- Standard模式的宽度和高度不包括padding和border，而Quirk模式包括
- Standard模式给span设定宽高无效，而Quirk模式有效
```

### 4.HTML文件顶部的<!DOCTYPE>的作用？
<!DOCTYPE>是文档类型的声明，告诉浏览器用什么版本的HTML，有如下三个版本：
- **HTML4.01**：是基于SGML的，需要对DTD进行引用
```
SGML：标准通用标记语言
DTD：文档类型的定义
（三种类型: strict（严格），transitional（过渡），frameset（框架））
```
- **XHTML**：XHTML与HTML没有太大的区别，主要区别在于
```
XHTML 元素必须被正确地嵌套。
XHTML 元素必须被关闭。
标签名必须用小写字母。
XHTML 文档必须拥有根元素。
```
- **HTML5**：不基于SGML，也不会引用DTD，但是需要用doctype规范浏览器的行为，意在告诉浏览器使用同一的标准即可

### 5.简述src和href的区别？
src
```
1.表示引入
2.解析会被暂停，等资源加载完成后，才会继续解析
3.常用于js和img的引入
```
href
```
1.表示引用
2.解析不会被暂停，资源加载和解析同步进行
3.常用于css的引用
```

### 6.简述WebP这种图像格式的特点
```
1.谷歌研发的
2.体积小，大约是jpeg的2/3
3.支持有损压缩和无损压缩，需要消耗更多的CPU资源
4.常用的图片格式还有：jpg，png，jpeg，gif，svg
```

### 7.网页加载大量图片，如何提高加载速度
```
1.图片懒加载（通过瀑布流方式，使用JS，当鼠标滑动到对应位置时才加载图片）
2.先加载固定缩略图（当图片过大的时候）
3.可以将图片大小直接缩小到展示尺寸大小
```

### 8.哪些方法可以引入CSS样式
```
1.行内样式
2.内部样式
3.引入外部样式的CSS文件
```

### 9.列举CSS选择器
```
1.标签选择器：div {width：100px；}
2.类选择器： .[类名] {width：100px；}
3.ID选择器:  #[id名] {width：100px；}
4.后代/子代选择器
    后代：空格	#links a{color:blue;}
    子代：>	#links>a {color:blue;}
   【区别：都表示“祖先-后代”的关系，但是>必须是“爸爸>儿子”，而空格不仅可以是“爸爸儿子”，还能是“爷爷儿”、“太爷爷儿子】
5.相邻兄弟选择器
    h1 + p {color:blue}
    【+和~的区别：类似上面一个，两者都表示兄弟关系，但是+必须是“大哥+二哥”，~还能是“大哥~三弟”、“二哥~四妹”】
6.通用选择器
	* { }
7.伪类选择器（link，visited，hover，active）
	p：hover{content：‘a’}

8.伪元素选择器（before，after）
```
选择器优先级的计算：

- 内联：1000
- id：100
- 类：10
- 元素和伪类：1

累加后值越大，优先级越高
### 10.什么是CSS Hack？IE 6/7/8/9/10的hack分别是什么？
指不同浏览器，或者指同一浏览器的不同版本对CSS的支持不同
针对这种不同，我们要针对不同的浏览器写不同的CSS代码，最后让CSS代码在不同的浏览器上都可以正常运行（其实我理解就是写代码要兼容各种浏览器）

### 11.块级元素和行内元素的区别？行内元素设置margin和padding的区别？
```
1.块级元素独占一行，行内元素默认排在一行上
2.块级元素设定宽高有效，行内元素设定宽高无效
3.块级元素设置内边距padding时，上右下左都有效，行内元素设置内边距padding时，左右有效，上下会影响background的高度，但并不影响实际占位的高度计算（img、input属于行内替换元素。height/width/padding/margin均可用。效果等于块元素。）
4.块级元素设置外边距margin时，上右下左都有效，行内元素设置会外边距margin时，左右有效，上下无效
5.块级元素不设置宽度时，其宽度尽量占满父元素的宽度。行内元素不设置宽度时，其宽度是其内容撑起的宽度
6.块级元素可以容纳其他的块级元素和行内元素，行内元素只能容纳文本和行内元素
```

### 12.rgba()和opacity的区别
```
1.都能实现透明的效果
2.rgba只针对元素的颜色以及背景色，opacity针对整个元素，包括元素里的字体也变得透明
```
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1cc5a0e108b14dcc979c3a87cb40ef58~tplv-k3u1fbpfcp-watermark.image)

### 13.CSS中能让文字在水平和垂直方向重叠的属性是什么
```
垂直方向：line-height
水平方向：letter-spacing，word-spacing
```

### 14.区分块级元素、行内元素、行内块元素的区别
```
块元素： <ul> <ol> <li> <p> <div> <hx> <table> <form> <lable>
  1.默认自动换行
  2.设置宽高都有效
  3.margin和padding上右下左都有效
  4.独占一行

行内元素： <span> <a> <select> <br>
  1.不会自动换行
  2.设置宽高都无效
  3.margin左右有效，上下无效，padding上右下左都有效，会撑大空间，左右参与宽度计算，上下不参与高度计算
  
行内块元素：<img> <input> <button>
  1.不会自动更换行
  2.设置宽高有效
  3.height/width/padding/margin设置均有效
```

### 15.论述你知道的居中一个元素的方法
我的这篇文章有详细讲述：[史上最全居中整理](https://juejin.im/post/6858048575411060743)

### 16.px，em，rem，%，无单位的区别
```
px：像素，绝对长度单位
em：指当前元素font-size的倍数
rem：root em 指相对html根元素font-size的倍数
%：
    width：基准是父元素的宽度
    height：基准是父元素的高度
    padding，margin：基准是父元素的宽度！！！，margin-top：2%，也是父元素的个宽度
    font-size：基准是父元素font-size的大小
    left，right：基准是父元素包含块的宽度（找父元素里第一个position不是static的元素）
    top，bottom：基准是父元素包含块的高度
无单位：
    数值是0的时候可以不写单位
```
### 17.display：none和visibility: hidden的区别？还有什么方法可以让一个元素消失
```
display：noen
    元素从render tree上被拿下来
    不参与layout过程，高度和宽度不会被渲染，不占位置
    
visibility: hidden
    元素还在render tree上面
    参与layout过程，高度和宽度还会渲染，占位置
    
元素消失的其他方法：
    宽度和高度设置为0
    通过z-index让其他元素覆盖本元素（z-index设置等很低）
```
### 18.CSS link和@import的区别
```
CSS link：
    是html里面的标签
    加载过程是异步的，不会阻塞浏览器的解析过程
@import：
    是CSS里面的标签
    加载过程是同步的，会阻塞浏览器的解析过程（能不用就不用）
```

### 19.介绍盒子模型？IE盒子模型和W3C盒子模型的区别？CSS3中如何设置？
```
W3C标准盒子模型：
	width（content）
    
IE盒子模型：
	width（content+padding+border）
    
如何设置：
	box-sizing：content-box（使用W3C盒子模型）
    box-sizing：border-box （使用IE盒子模型）
```

### 20.论述什么是BFC？！！！高级题
**BFC**：Block Formatting Conext，块格式上下文，是W3C CSS2.1中的一个概念

**FC**：是一个渲染区域，遵循相应的渲染规则，这些规则决定了：内部元素的定位方式、与外部元素的位置关系

**BFC的布局渲染规则**：
```
1.内部BOX会在垂直方向，一个接一个的放置，一个BOX占一行
2.Box垂直方向的距离由Margin决定，属于同一个BFC的两个相邻Box的margin会发生重叠（只在垂直方向会重叠，水平方向不会）
3.当构建BFC区域的元素紧接着一个浮动盒子时，即，是该浮动盒子的兄弟节点，BFC区域会首先尝试在浮动盒子的旁边渲染，但若宽度不够，就在浮动元素的下方渲染
4.BFC的区域不会与float box重叠
5.BFC就是页面上一个隔离的独立容器，容器里面的子元素不会影响到外面的子元素，反之也是如此
6.计算BFC高度时，浮动元素也参与计算
```
**如何触发BFC**
```
html根元素
float值不是none的元素（该元素触发BFC）
overflow不是visible的元素（该元素触发BFC）
display值为inline-block，table-cell，table-caption的元素
position的值为absolute，fixed的元素
```
**BFC的4个代码实验**
```
自适应两栏布局
阻止元素被浮动元素覆盖
清除浮动
分属不同的BFC的box，margin不会合并
```

### 21.CSS优先级的计算方法?
覆盖原则
```
如果优先级不同，高优先级选择器会覆盖低优先级选择器的属性
如果优先级相同，定义在后面的选择器会覆盖定义在前面的选择器的属性
```
优先级的计算方法
（把所有出现的单个选择器的优先级进行累计，不进位）
```
*，继承=0,0,0,0
元素属性（伪类）=0,0,0,1
类=0,0,1,0
ID =0,1,0,0
行内：1,0,0,0
！important=无穷大，王炸
```
### 22.display中值的作用
块级元素有：div，hx，p，ul，ol，li
```
所有的块级元素自己占一行
块级元素可以设定宽高
块级元素的margin，padding有效
块级元素的宽度是父节点宽度的100%
块级元素可以容纳其他的块级元素或者行内元素（例外：p，hx里通常只放文字）
```
行内元素有：span，a
```
行内元素可以并列在一行上
行内元素设定宽高无效
行内元素设定内边距padding是，左右有效，上下也有效，会影响背景，但是不参与高度计算
行内元素设定外边距margin时，左右有效，上下无效
行内元素的宽度是其内容的宽度
行内元素通常只容纳文本或者其他的行内元素
    例外：a元素内部可以放置块级元素
    注意：a元素内部不能再放置a元素
    p是块元素，但是其不能包含除了它本身之外的任何块元素，a是内联元素，但是它可以包含除了它本身外的任意块元素
```
常见的行内块元素有：img，input，td
```
相邻的行内块元素可以在一行（行内元素）
行内块元素可以设置宽高，内边距，外边距（块级元素）
```
### 23.position中值的作用？
static:不设定定位的元素，默认方式是static
```
1.不脱离标准流
2.偏移不起作用：top,right,bottom,left
3.消除定位（position：static定位默认消除）
```
relative:相对定位
```
1.不脱离标准流
2.偏移起作用：top，right，bottom，left，
偏移的起始点是元素本来应该所在位置的左上点
3.不破坏标准流，把元素移动到需要的地方上
4.如果同时设定了left和right，只有left有效，同时设定了top和bottom，top有效
5.relative作为absolute的基准
6.relative+偏移  VS  static+margin的区别？
    relative只是移动元素，但是标准流不受影响
    static+margin虽然也可移动元素，但是会影响标准流
```
absolute:绝对定位
```
1.脱离标准流，跟着滚动条一起滚动
2.偏移起作用，top，right，bottom，left
	2.1如果没有任何一层的祖先有定位（relative，absolute，fixed），以浏览器的可视区为起始点
	2.2如果父元素有定位（relative，absolute，fixed），以父元素的边界内角为起始点
（不受父元素padding，border的影响，margin会影响）
    2.3如果有一个或者多个祖先元素有定位（relative，absolute，fixed）,以最近的有定位的祖先元素的内角为起始点
```
fixed:固定定位
```
1.脱离标准流，不和滚动条一起滚动
2.偏移起作用：top，right，bottom，left
3.不受父元素的影响，只依据浏览器的可视区viewport定位
4.当一个元素被设定为固定宽度时，会产生模式转换=》都会变成行内块元素，即没有设定宽度的时候，其宽度为内容撑起的宽度
```
面试：能脱离标准流的有哪些
```
浮动
absolute
fixed
```
注意：所有脱离标准流的动作，都会产生模式转换，对应元素变为行内块元素
### 24.浮动的知识点
浮动定义
```
浮动：浮动指元素脱离标准流，移动到其父元素指定的位置的过程
```
浮动与父元素的关系
```
浮动的子元素无法超出父元素的范围，如果父元素有padding，浮动的子元素无法超出父元素padding的范围
在工程中：一个父元素下尽量让所有的子元素都浮动
```
浮动与inline-block的关系
```
一个块级元素浮动后，会具有inline-block的一些属性，比如：div设置浮动后，在不设定width的情况下，宽度为其内容撑起的宽度（平时块元素div的宽度=父元素的宽度）
一个行内元素浮动以后，会产生类似inline-block的特性，可以设置宽度和高度
```
### 25.清除浮动的四种方法
这篇文章讲得很好[清除浮动的4中方式以及原理](https://juejin.im/post/6844903504545316877#heading-5)

下面我这里只是做一个总结

为什么要清除浮动，当父元素里的所有属性都设置了float（脱离了标准流），且父元素的高度不能设定时

1.利用clear样式：我们给需要清除浮动的元素添加clear: left, right, both

2.在父元素里添加：overflow：hidden(auto)

3.父元素结束标签之前插入清除浮动的块级元素

4.使用after伪元素清除浮动
（其实相当于加了个after元素）
网易在用
```
<style>
        .parent{
            border: 1px solid blue;
        }
        .clearfix:after{

            content: "";
            display: block;
            height: 0;
            clear:both;
            visibility: hidden;
        }
        /*兼容IE浏览器*/
        .clearfix{
            *zoom: 1;
        }
        #div1,
        #div2 {
            float:left;
            width: 100px;
        }
        #div1{
            height: 100px;
            background-color: pink;
        }
        #div2{
            height: 200px;
            background-color: black;
        }
</style>

<div class="parent clearfix">
        <div id="div1"></div>
        <div id="div2"></div>
</div>
```
双伪元素（befor，after）
小米在用
```
<style>
        .parent{
            border: 1px solid blue;
        }
        /*清除浮动*/
        .clearfix:before,
        .clearfix:after{
            content: "";
            display: table;
        }
        .clearfix:after{
            clear: both;
        }

        /*兼容IE*/
        .clearfix{
            *zoom: 1;
        }
        #div1,
        #div2 {
            float:left;
            width: 100px;
        }
        #div1{
            height: 100px;
            background-color: pink;
        }
        #div2{
            height: 200px;
            background-color: black;
        }
    </style>

<div class="parent clearfix">
        <div id="div1"></div>
        <div id="div2"></div>
</div>
```

### 26.超链接访问过后hover的样式就不出现了，为什么？
原因：同时写了四种伪类，：link，：visited，:hover,  :active

导致：一旦链接被点击过，visited写在最后，会把前面定义的覆盖掉，导致hover无法生效

解决办法：按照  :link,  :visited,  :hover,  :active 的顺序进行定义

### 27.描述包含块的概念？absolute的包含块计算方式和标准流的包含块有什么不同？
包含块：containing block，CSS2.1中的概念

一个元素盒子的位置和尺寸需要根据一个矩形来进行计算，而确定这个矩形的元素称为包含块

包含块的规则
```
HTML根元素是一个包含块，也称初始包含块，是viewport的大小

position：relative/static的元素，包含他的块是它最近的祖先（这个祖先的要求是一个块元素）

position：fixed的元素，包含它的块是html根元素对应的初始块

position：absolute的元素，包含块是离它最近的，祖先的，position不等于static的元素，并且是除去border和padding后里面的矩形
```

### 28.论述如何使用伪对象（伪元素）after和before？
语法：E:after或者E::after，后者是CSS3中的语法

```
p:before{
    content: "H"  /*在a前面加一个H*/
}

p:after{
    content: "H"   /*在a后面加一个H*/
}

<p>
  	a
</p>
```

### 29.html中meta标签的用处？
定义：meta指元数据，不显示

为浏览器提供信息
（<meta name:"keywords",  content="HTML,PHP">）
```
网页的描述
关键词
作者
修改时间
```
设定meta的主要作用
```
设定字符集（utf-8）
SEO优化
设定viewport
```
### 30.论述什么是media query
用途：主要用于响应式布局
```
语法一：<link rel="stylesheet" media="(max-width:800px)"  href="example.css">
(当最大宽度不超过800px的时候，引用example.css文件)

语法二：@media(max-width:800px{ })
```

### 31.z-index叠放次序
```
一个数值，没有单位

默认数值是0，数值越大越靠上，可以覆盖数值小的元素

如果没有设定，后定义的元素在新定义的元素之上

设定z-index只对定位设定为relative，absolute，fixed三种有效，对标准流，浮动无效
```

### 32.编写一个表格，奇数行的背景颜色是粉色，偶数行的背景颜色是蓝色？
```
<style>
    /*<!--even:偶数-->*/
    table tr:nth-child(even)>td{
        background-color: blue;
    }
    table tr:nth-child(odd)>td{
        background-color: pink;
    }
</style>

<table>
    <tr>
        <th>标题</th>
    </tr>
    <tr>
        <td>data1</td>
    </tr>
    <tr>
        <td>data2</td>
    </tr>
    <tr>
        <td>data3</td>
    </tr>
    <tr>
        <td>data4</td>
    </tr>
</table>
```
链接：[nth-child的完整用法](http://www.internetzg.com/view_news.asp?id=578)

### 33.用CSS画一个三角形？
```
<style>
    /*<!--知道底边和高，画一个任意的三角形-->*/
    /*底边一部分是100px，另一部分是100px，高是200px*/
    #traingle{
        width: 0;
        height: 0;
        /*1. 画正方形里左边的三角形*/
        /*把剩下的面积变透明*/
        /*border: 100px solid transparent;*/
        /*因为宽高是0，所以左边的宽就是从左边到中心点的四分之一面积*/
        /*border-left-color: blue;*/

        /*2. 画任意的三角形*/
        border-left: 100px solid transparent;
        border-right: 100px solid transparent;
        border-bottom: 200px solid blue;
        /*再逆时针设置旋转角度*/
        /*顺时针为正，逆时针旋转30度*/
        transform: rotate(-30deg);
    }
</style>

<div id="traingle">

</div>
```

### 34.让一个宽高都为200px的div居中
第15题里一共整理的14中居中方法，随便用啦！

### 36.写一个三栏布局，左右固定，中间自适应
#### 方式1：浮动
```
<style>
    div{
        height: 800px;
    }
    #left{
        width: 100px;
        background-color: blue;
        float: left;
    }
    #right{
        width: 100px;
        background-color: #00FF00;
        float: right;
    }
    #center{
        background-color: black;
        overflow: hidden;
    }
</style>

<div>
    <div id="left"></div>
    <div id="right"></div>
    <div id="center"></div>
</div>
```
原理
```
把中间的div变成BFC（通过overflow：hidden）
变成BFC后，当构建BFC区域的元素紧接着一个浮动盒子时，即，是该浮动盒子的兄弟节点，BFC区域会首先尝试在浮动盒子的旁边渲染，但若宽度不够，就在浮动元素的下方渲染。
```
#### 方式2：绝对定位法，左右绝对定位，中间自适应
```
<style type="text/css">
    html,
    body {
        margin: 0;
        width: 100%;
    }

    #left,
    #right {
        width: 200px;
        height: 200px;
        background-color: #f00;
        position: absolute;
    }

    #left {
        left: 0;
    }

    #right {
        right: 0;
    }

    #center {
        margin: 0 210px;
        height: 200px;
        background-color: #eee;
    }
</style>

<body>
    <div id = "left">我是左边</div>
    <div id = "right">我是右边</div>
    <div id = "center">我是中间</div>
</body>
```

#### 方式3：圣杯模式
！！！考点：圣杯模式
（中间先加载，左右两边后加载）
```
<style>
    div{
        height: 500px;
    }
    #wrap{
        width: 100%;
        float: left;
        background-color: transparent;
    }
    #left{
        width: 100px;
        background-color: blue;
        margin-left: -100%;
        float: left;
    }
    #right{
        width: 100px;
        background-color: #00FF00;
        float: left;
        margin-left: -100px;
    }
    #center{
        margin: 0 110px;
        background-color: black;

    }
</style>

<div id="wrap">
	<div id="center"></div>
</div>
<div id="left"></div>
<div id="right"></div>
```

### 37.实现两个div，等宽，随body宽度变化，中间有空隙10px
```
<style>
		*{
        	padding： 0;
            margin: 0;
        }
        #left,
        #right {
            height: 100px;
            width: calc(50% - 5px);
            background-color: black;
        }
        #left{
            float: left;
        }
        #right{
            float: right;
        }
    </style>

<div id="left"></div>
<div id="right"></div>
```

### 38.html里head标签里的内容设置
1. meta-charset：兼容中文
```
<meta charset="utf-8">
```

2. title：浏览器标签页显示的文字
```
<title>商城</title>
```

3. link-shorcut-icon: 浏览器标签页的图标
```
<link rel="shorcut icon" href="%PUBLIC_URL%/favicon.ico">
```

4. meta-viewport
```
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

viewport: 移动设备的viewport就是我们设备屏幕上用来显示网页的区域
width：可视区域的宽度，值可为数字或关键词device-width
intial-scale:页面首次被显示是可视区域的缩放级别，取值1.0则页面按实际尺寸显示，无任何缩放
maximum-scale=1.0, minimum-scale=1.0;可视区域的缩放级别，
maximum-scale用户可将页面放大的程序，1.0将禁止用户放大到实际尺寸之上
user-scalable:是否可对页面进行缩放，no 禁止缩放

```

5. meta-format-detection
```
<meta name="format-detection" content="telephone=no,email=no,date=no,address=no" />

telephone
主要作用是是否设置自动将你的数字转化为拨号连接

email
告诉设备不识别邮箱，点击之后不自动发送

adress
adress=no 禁止跳转至地图
adress=yes 开启点击地址直接跳转至地图的功能, 默认开启
```

6. meta-theme-color: 主题颜色
```
<meta name="theme-color" content="#000000" />
```

7. meta http-equiv="X-UA-Compatible"
```
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

如果当前IE浏览器安装了GCF插件，则以chrome内核渲染页面，否则就以当前IE浏览器支持的最高版本模式来渲染
```

### 39.伪类和伪元素

根本区别：是否创造了新的元素

伪类：
```
link、visite、hover、active、hover
```

伪元素
```
after、before
```

### 40. margin: 0 auto有效的条件？
```
1. 需要居中的元素要设置宽度
2. 父元素不能是绝对定位或者浮动
3. 有时需要给父级元素添加text-align: center;
4. 在HTML中使用<center></center>标签，需考虑好整体构架，否者全部元素都会居中的。
5. 有时可能涉及到 <!DOCTYPE>类型相关定义。
```

### 41. z-index无效是什么导致的？
```
1. 父元素的position属性不能是relative
2. 当前标签需要设置position（不能是static）
3. 当前标签不能有float属性
```