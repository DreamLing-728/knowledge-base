## 大纲
- 1.JS的基本数据类型部分?
- 2.数据类型的显示转换和隐式转换？
- 3.数组常用的方法有哪些？
- 4.有几种清空数组的方法？
- 5.传统事件绑定和W3C标准事件绑定（DOM事件流）有什么区别？
- 6.IE8事件流和DOM事件流区别？如何同时兼容？
- 7.call、apply、bind的区别？
- 8.论述JS中的继承方法？
- 9.论述this指针？
- 10.论述作用域和闭包
- 11.什么是事件的委托？
- 12.如何阻止事件冒泡和默认事件行为？
- 13.如何实现DOM的增删改查？
- 14.什么是本地对象、内置对象、宿主对象？
- 15.document load 和document ready的区别？
- 16.==和===的区别？
- 17.创建函数   的方法?
- 18.创建对象的方法？
- 19.简述什么是伪数组？
- 20.为什么0.1+0.2不等于0.3，怎么让它等于0.3？
- 21.简述字符集有哪些？
- 22.深拷贝和浅拷贝的区别？
- 23.实现给数字添加千分位符的方法?
- 24.描述一下cookies，sessionStorage和localStorage的区别？
- 25.回流和重绘？
- 26.输入URL到展示页面的过程?
- 27.三次握手的过程？
- 28.http的知识点？
- 29.json对象转数组有哪些方法？
- 30.讲一下promise？
- 31.JS的事件循环机制？
- 32.箭头函数与普通函数的区别？
- 33.如何把多维数组转化为一维数组？
- 34.讲下原型、原型链？
- 35.如果对象不想被更改怎么做？
- 36.什么是防抖和节流？有什么区别？如何实现？
- 37.介绍下Set、Map、WeakSet、WeakMap的区别？
- 38.讲一下同源策略？
- 39.var、let、const的区别
- 40. rem 的实现原理

### 1.JS的基本数据类型部分
**1.1 JS的基本数据类型？**
6种=5种原始类型+1中引用类型
- Number
- String
- Boolean
- Null
- Undefined
- Object（对象、数组、函数）
ES6里面新增了Symbol，表示独一无二的值，属于原始类型

**1.2 原始类型和引用类型的区别？**

原始数据类型在内存中是栈存储，引用类型是栈存储+堆存储。

原始类型举例
```js
var a = 10;
var b = a;
b = 20;
console.log(a); // 10值
```
存储过程

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2bd5ed23be774117986810d4b5afc0e7~tplv-k3u1fbpfcp-watermark.webp)

引用类型举例
```js
var obj1 = new Object();
var obj2 = obj1;
obj2.name = "我有名字了";
console.log(obj1.name); // 我有名字了
```
存储过程
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/79e073eb98ff4cfbbdbafef4bb8c3ed0~tplv-k3u1fbpfcp-watermark.webp)

**1.3 数据类型的检测方式有几种**

**共4种**

**方式1：typeof**

- 1.检测结果共6种：number，string，boolean，undefined，object，function（都是小写）
```js
console.log(typeof "");
console.log(typeof 1);
console.log(typeof true);
console.log(typeof null);
console.log(typeof undefined);
console.log(typeof []);
console.log(typeof function(){});
console.log(typeof {});
```
```
答案：
console.log(typeof ""); string
console.log(typeof 1); number
console.log(typeof true); boolean
console.log(typeof null); object
console.log(typeof undefined); undefined
console.log(typeof []); object
console.log(typeof function(){}); function
console.log(typeof {}); object
```
typeof的缺陷：null，数组，日期，正则都识别成object，所以用到方式2

**方式2：Object.prototype.toString.call（）**

这个方式可以正确检测null，数组，如下：

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/dc952c8ef91145038746c498dfeea48f~tplv-k3u1fbpfcp-watermark.image)

**检测原理：**
toString()方法：将传入的字符串数据类型转换成字符串输出，我们常见的是这样的
```
var num = 123
num.toString() // '123'
```
普通数据类型和Object.prototype上都有toString()方法，但是这两个是不一样的，普通数据类型继承了Object的toString()方法，同时也进行了改写，所以只有Object上的toString()才能用来检测数据类型。.call是用来改变toString()方法的指向，使其指向传入的对象。


**方式3：instance of**
```js
console.log("1" instanceof String);
console.log(1 instanceof Number);
console.log(true instanceof Boolean);
console.log(new String("1") instanceof String);
console.log(new Number(1) instanceof Number);
console.log(new Boolean(false) instanceof Boolean);
console.log([] instanceof Array);
console.log(function(){} instanceof Function);
console.log({} instanceof Object);
```
```js
console.log("1" instanceof String); 	false
console.log(1 instanceof Number);		false
console.log(true instanceof Boolean);	false
console.log(new String("1") instanceof String);		true
console.log(new Number(1) instanceof Number);		true
console.log(new Boolean(false) instanceof Boolean);		true

console.log([] instanceof Array);		true
console.log(function(){} instanceof Function);		true
console.log({} instanceof Object);		true
```
基本数据类型里的String、Number、Boolean都需要用new关键字创建才能正确判断，比如1-3项是false，4-6项是true。但是也会有一个问题：null，undefined用new关键字创建也不能通过instance of判断。

**检测原理：**
原型链的查找机制，举个例子
```js
function Farther(){
    this.name = 'cml';
}
function Son() {
    this.age = 18;
}
Son.prototype = new Farther();
var s = new Son();
console.log(s instanceof Son)
console.log(Son.prototype instanceof Farther)
console.log(s instanceof Farther)
```
整个的关系图是这样的：
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7897fa702bbf49d7b26a479aad41a73e~tplv-k3u1fbpfcp-watermark.image)
var s = new Son()，s对象有一个__proto__属性，指向构造函数Son的prototype原型对象，所以s instanceof Son是true。
Son.prototype = new Farther();把Son.prototype对象的__proto__属性指向构造函数Farther的prototype原型对象，所以Son.prototype instanceof Farther, 再通过原型链的继承，所以s instanceof Farther也是true

**方式4：constructor**
```js
console.log(("1").constructor === String);
console.log((1).constructor === Number);
console.log((true).constructor === Boolean);
console.log(([]).constructor === Array);
console.log((function() {}).constructor === Function);
console.log(({}).constructor === Object);
console.log((null).constructor === Null);
console.log((undefined).constructor === Undefined);
```
```js
答案
console.log(("1").constructor === String);	// true
console.log((1).constructor === Number);	// true
console.log((true).constructor === Boolean);	// true
console.log(([]).constructor === Array);	// true
console.log((function() {}).constructor === Function);	// true
console.log(({}).constructor === Object);	// true
console.log((null).constructor === Null);	// 报错
console.log((undefined).constructor === Undefined);		// 报错
```
除了null和undefined我们都是可以正常判断的

**检测原理：**
构造函数实例化对象的constructor属性是指向构造函数的
```
function Fn(){};
var f=new Fn();
console.log(f.constructor===Fn);
```

### 2.数据类型的显示转换和隐式转换？
**显示转换：**
Number(), parseInt(), String(), Boolean()

**2.1 Number()**

转换规则如下

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8b70af5c7e5b41fab527178d3ebbac7f~tplv-k3u1fbpfcp-watermark.image)
```js
console.log(Number(123))
console.log(Number('123'))
console.log(Number('123abc'))
console.log(Number(''))
console.log(Number(true))
console.log(Number(false))
console.log(Number(null))
console.log(Number(undefined))
console.log(Number([]))
console.log(Number([1]))
console.log(Number([1,2,3]))
console.log(Number({}))
console.log(Number({1}))
console.log(Number({a: 1}))
```
答案
```js
Number(123)		123
Number('123')		123
Number('123abc')	NaN
Number('')		0
Number(true)	1
Number(false)	0
Number(null)	0
Number(undefined)	NaN
Number([])		0
Number([1])		1
Number([1,2,3])		NaN
Number({})		报错
Number({1})		报错
Number({a: 1})		NaN
```
最后对象会报错，因为会被识别成代码框，{a: 1}转化的结果是NaN

**2.2 parseInt()**

Number()的转换是比较严格的，需要全部能转换，否则结果是NaN，比如‘123abc’的结果是NaN，但是parseInt就没有这么严格，遇到不能转换的就停下来，把已转换的结果返回。

```
console.log(parseInt('123abc'))		// 123
```

**2.3 String()**

String的转换规则
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c0ac98255c534375ab2b56d32ce08977~tplv-k3u1fbpfcp-watermark.image)
```js
console.log(String(1))
console.log(String('1'))
console.log(String(true))
console.log(String(false))
console.log(String(undefined))
console.log(String(null))
console.log(String([1,2,3]))
console.log(String({a: 1}))
```
答案
```js
console.log(String(1))		'1'
console.log(String('1'))	'1'
console.log(String(true))		'true'
console.log(String(false))		'false'
console.log(String(undefined))		'undefined'
console.log(String(null))		'null'
console.log(String([1,2,3]))		'1,2,3'
console.log(String({a: 1}))		'[object, Object]'
```

**2.4 Boolean()**

转换规则
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8648a151a6b9434e82caa4bc4116f8bf~tplv-k3u1fbpfcp-watermark.image)

```
console.log(Boolean(true))
console.log(Boolean('abcd'))
console.log(Boolean(1))
console.log(Boolean({a: 1}))


console.log(Boolean(false))
console.log(Boolean(''))
console.log(Boolean(0))
console.log(Boolean(NaN))
console.log(Boolean(null))
console.log(Boolean(undefined))
```
答案
```
前4个是true，后面都是false
```
- 2.隐式类型转换：
- 	2.1 字符串和任何其他类型做加法，其他类型会被隐式转成字符串
-   2.2 能够转化成数字的字符串，参与减法，负号运算，会被转化成数字
-   2.3 非boolean类型在if，？：，！运算时变成boolean
-   2.4 ==判断的时候，1==‘1’（true），null==undefined（true）

**常见的数据类型比较试题**
```
[] == ![]
{} == !{}
'a' ++ 'b'
2 + '1'
2 - '1'
2 * '1'
1 == [1]
1 == {1}
null + 1
undefined + 1
true + 1
false + 1
```

```
[] == ![] 	// true
{} == !{} 	// false
'a' ++ 'b'	// 报错
2 + '1'		// 21
2 - '1'		// 1
2 * '1'
1 == [1]	// true
1 == {1}	// 报错，会把{}识别成块作用域
null + 1	// 1
undefined + 1		// NaN
true + 1	// 2
false + 1		// 1
```

### 3.数组部分？
#### 3.1 数组的方法有哪些
**3.1 操作方法**

**增**
```
push(): 原数组改变，添加元素到数组的末尾，返回数组的长度
unshift()：原数组改变，添加元素到数组的头部，返回数组的长度
concat()：原数组不变，新建一个新数组副本，把参数添加到新数组的尾部，返回新数组
```

**删**
```
pop()：原数组改变，删除数组最后一项，返回被删除的项
shift()：原数组改变，删除数组第一项，返回数组长度
splice(): 原数组改变，参数(开始位置，长度)，返回删除元素的数组
slice(): 原数组不变，参数(开始位置，结束位置)，返回原数组被截取的部分
```

**改**
```
splice(): 原数组改变，参数(开始位置，删除长度，插入的元素1，插入元素2)，返回被删除元素的数组

代码：
var a = ['1', '2', '3'];
var remove = a.splice(1, 1, '4', '5');
console.log(a);	//['1', '4', '5', '3'];
console.log(remove); //['2']
```

**查**
```
indexOf(): 查找元素所在的位置，返回对应的索引值，没有找到则返回-1
includes(): 查找数组是否包此元素，包含返回true， 不包含返回false
find(): 参数是一个方法,方法里的参数是(element, index, array),返回符合条件的第一个元素

代码：
var a = [1,2,3,2]
console.log(a.find((element, index, array) => element>2))
```

**3.2 排序方法**
```
reverse(): 将数组的顺序翻转，返回翻转后的数组
sort(): 参数可以是一个方法, 返回排序后的数组

代码
var a = [3,1,2,3,2,1]
console.log(a.sort((a,b) => a-b)) // [1, 1, 2, 2, 3, 3]
```

**3.3 转换方法**
```
join(): 根据传入的参数拼接成字符串，默认是根据","拼接
```

**3.4 迭代方法**
```
map(): 参数是一个方法，把原数组的每一项都运行这个方法，把运行结果形成的数组返回
filter()：参数是一个方法，把原数组的每一项都运行这个方法，把运行结果为true形成的数组返回
forEach()：参数是一个方法，把原数组的每一项都运行这个方法，没有返回
some()：参数是一个方法，把原数组的每一项都运行这个方法，有一项为true，则返回true
every()：参数是一个方法，把原数组的每一项都运行这个方法，全部为true，才会返回true
```

#### 3.2 数组的应用
**应用1：有几种清空数组的方法？**
- 1.通过pop()和shift()方法一个个弹出
- 2.a.length = 0,length会变，直接清空
- 3.delete a[i], length不变，只是对应索引下的值变成empty
```js
var a = [1, 2, 3];
for(var i=0; i<a.length; i++){
    delete a[i];
}
console.log(a[1], a.length);	// undefined 3
```
- 4.a.splice(0),从第0个开始一直到结尾，全部截走
- 5.重新赋值，a = [ ] 

**应用2：数组去重的方法**

**方法一：建新的数组，用indexOf()判断是否在新的数组内**
```js
function action(arrinit){
    let result = [];
    arrinit.forEach(item => {
        if(result.indexOf(item) < 0){
            result.push(item)
        }
    });
    return result;
}
```
**方法二：双重for循环原数组，用splice方法删除数据**
```js
function action(arrinit){
    for(let i = 0; i < arrinit.length; i ++){
        for(let j = i + 1; j < arrinit.length; j ++){
            if(arrinit[i] == arrinit[j]){
                arrinit.splice(i, 1);
                i --;
            }
        }
    }
    return arrinit;
}
```
**方法三：借助set**
```js
function action(arrinit){
    let m = new Set(arrinit);
    // let result = [...m];     // 方式1
    let result = Array.from(m);     // 方式2
    return result;
}
```
**方法四：借助ES6的Map数据结构也可以去重**

```js
function action(arrinit){
    let result = []
    let m = new Map();
    arrinit.forEach(element => {
        if(!m.has(element)){
            m.set(element, true);
            result.push(element);
        }
    });
    return result;
}
```

**方法五：借助数组的includes方法**
```
function action(arrinit){
    let result = [];
    for(let i = 0; i < arrinit.length; i ++){
        if(!result.includes(arrinit[i])){
            result.push(arrinit[i]);
        }
    }
    return result;
}
```
**方法六：借助数组的filter方法**
```js
function action(arrinit){
    return arrinit.filter((item, index) => {
        return arrinit.indexOf(item) === index;
    })
}
```
**方法七：先sort，再比较两个相邻的元素**
```js
function action(arrinit) {
    arrinit.sort();
    for (let i = 0; i < arrinit.length - 1; i++) {
        if (arrinit[i] == arrinit[i + 1]){
            arrinit.splice(i, 1);
            i --;
        }
    }
    return arrinit;
}
```
**方法八：利用对象的属性不能相同去重**
```js
function action(arrinit){
    let resultarr = [];
    let resultabj = {};
    arrinit.forEach(item => {
        if(!resultabj[item]){
            resultabj[item] = 1;
            resultarr.push(item)
        }
    });
    return resultarr;
}
```

**应用3.数组扁平化的方法**

方法1：ES6的flat方法
```js
function action(arrinit){
    let result = arrinit.flat()
    return result;
}
```

方法2：ES6的扩展运算符(但是这个只能把二维变一维)
```js
function action(arrinit){
    let result = [...arrinit];
    return result;
}
```

方法3：数组.join() ==> 字符串 ==> 字符串.split()
```js
function action(arrinit){
    let result = arrinit.join().split();
    return result;
}
```

方法4：数组.toString() ==> 字符串
```js
function action(arrinit){
    let result = arrinit.toString().split();
    return result;
}
```

方法5：递归
```js
let result = [];
function action(arrinit){
    arrinit.forEach(element => {
        if(typeof(element) !== 'object'){
            result.push(element);
        } else {
            action(element);
        }
    });
}
```

方法6：借助reduce()和concat()【注意不能用push，因为return arr.push() 后的是元素，不是数组arr】
```js
function action(arrinit){
    return arrinit.reduce((prev, cur) => {
        console.log(prev, cur);
        // console.log((typeof(cur) === 'object') ? action(cur) : cur)
        let result = prev.concat(((typeof(cur) === 'object') ? action(cur) : cur));
        console.log(result)
        return result
    }, [])
}
```
四个参数：初始值（或者上一次回调函数的返回值），当前元素值，当前索引，调用 reduce 的数组

### 4.字符串的常用方法有哪些？
**4.1 操作方法**

**增**
```
+：直接用+号进行字符串的拼接
concat(): 把字符串拼接传入的参数
```
**删**

```
slice(): 参数（开始位置，结束位置），返回根据参数截取后的字符串
substring():参数（开始位置，结束位置），返回根据参数截取后的字符串
substr(): 参数（开始位置，长度），返回返回根据参数截取后的字符串

这三个都不改变原字符串
```

**改**
```
trim(),trimLeft(),trimRight(): 原字符串不改变，删除字符串前后、前、后的空，返回新的字符串
repeat(): 原字符串不改变，参数是数字n，表示原字符串重复到n次，返回新的字符串
padStart(),padEnd(): 参数(填充后字符串的长度n，填充字符串a)，表示在头部或者尾部填充字符串a，知道字符串长度是n，返回新的填充后的字符串。
toLowerCase(),toUpperCase(): 字符串大小写转化
```

**查**
```
indexOf(): 参数是字符，在字符串中找到对应字符后，返回所找到字符串的索引，没找到返回-1
includes(): 参数是字符串，在字符串中找到对应字符后，返回true，没找到返回false
charAt(): 参数是索引数字，返回字符串中对应索引下的字符串
startWith(): 参数是字符串a，判断原字符串是否以字符串a开头，是返回true，不是返回false
```


**4.2 转换方法**

字符串转换成数组
```
split(): 参数是字符串a，将字符串根据参数a切隔成数组，返回切隔后的数组
```

**4.3 正则匹配方法**
- match(): 参数是正则表达式a，将字符串匹配正则a，把所有符合正则的字符串形成数组返回
```
var a = "bat, dad, cat, fat, dat"
console.log(a.match(/.at/g))		//  ["bat", "cat", "fat", "dat"] 这里的正则要带g
```

search(): 参数是正则表达式a，将字符串匹配正则，找到则返回匹配的索引，找不到返回-1
```
var a = "bat, dad, cat, fat, dat"
console.log(a.search(/at/))		// 1
```
replace(): 参数(匹配内容，替换元素)，返回被替换后的字符串
```
var a = "ba t, dad, cat, fat, dat"
console.log(a.replace('bat', 'cat'))	// "cat, dad, cat, fat, dat"
```

### 5.传统事件绑定和W3C标准事件绑定（DOM事件流）有什么区别？

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8487207102674db783c51723237767a5~tplv-k3u1fbpfcp-watermark.image)
### 6.IE8事件流和DOM事件流区别？如何同时兼容？
绑定事件的兼容
```js
Element.prototype.addEvent = function(type, func){
    var element = this;
    if(element.addEventListener){
        element.addEventListener(type, func);
    }else if(element.attachEvent){
        element.attachEvent('on' + type, function(){
            func.call(element);    //  IE 8 及更早 IE 版本
        });
    }else{
        element['on' + type] = func;
    }
}
```
阻止冒泡的兼容
```js		
Element.prototype.stopPropagation = function(e){
    e = e || window.event;

    if(e.stopPropagation){
        e.stopPropagation();
    }else{
        e.cancelBubble = true;
    }
}
```
阻止默认事件的兼容
```js
Element.prototype.preventDefault = function(e){
    e = e || window.event;
    if(e.preventDefault){
        e.preventDefault();
    }else{
        e.returnValue = false;
    }
}
```
找到触发元素getTarget的兼容
```js
Element.prototype.getTarget = function(e){
    e = e || window.event;
    return (e.target || e.srcElement);
}
```
### 7.call、apply、bind的区别？
**call和apply相同点**
- 都可以用于绑定this，从而改变this的指向
- 都能够改变函数执行时的上下文，将一个对象的方法交给另一个对象来执行，调用 call 和 apply 的对象，必须是一个函数 Function
- call和applay的第一个参数都是一个对象

**call和apply区别**
- functionObject.call(this,参数1，参数2)
- functionObject.apply（this，[参数1，参数2，。。。]）
- functionObject.apply(this,arguments)，在构造函数里用

**案例**

使用call
```js
function superClass (c, d) {
    this.a = 1;
    this.b = 1;
    this.print = function () {
        console.log(this.a+this.b);		// 2
        console.log(c + d);		// 4
    }
}

function subClass () {
    superClass.call(this, 2, 2);
    this.print();
}

subClass();
```
使用apply
```js
function superClass (c, d) {
    this.a = 1;
    this.b = 1;
    this.print = function () {
        console.log(this.a+this.b);		// 2
        console.log(c + d);		// 4
    }
}

function subClass () {
    superClass.apply(this, [2, 2]);
    this.print();
}

subClass();
```
functionObject.apply(this,arguments)，在构造函数里用法
```js

```
派生类subClass想用基类的print()方法，所以通过 【基类.call(派生类this对象，参数)】，把参数传给基类，基类的方法处理参数后，再把基类的方法给到派生类使用。

**bind 和 apply、call 区别**

刚才的例子用bind是这样实现的
```js
function superClass (c, d) {
    this.a = 1;
    this.b = 1;
    this.print = function () {
        console.log(this.a+this.b);		// 2
        console.log(c + d);		// 4
    }
}

function subClass () {
    superClass.bind(this, 2, 2)();		// 这里需要多加一个括号
    this.print();
}

subClass();
```
bind 是创建一个新的函数，我们必须要手动去调用

**深入理解一下bind()**

看下面这段代码的1/2/3处分别输出什么？
```js
var value = 'window'

var obj = {
    value: 'A',
    f: function () {
        console.log(this.value)
    }
}

var f = obj.f

f()		// 1
f.bind(obj)()		// 2
f.bind(this, obj)()		// 3
f.bind(this)()		// 4
```
答案分别是：window, A, window, window

我们再来看一段代码,请思考一下最后输出的是什么？
```js
function A(){
    console.log('A')
    console.log(this)
}

function B(){
    console.log('B')
    console.log(this)
}

function C(){
    console.log('C')
    console.log(this)
}

A.bind(B).call(C)

```
答案：最后执行的是A方法，打印的是A和function B(){
    console.log('B')
    console.log(this)
}

最后执行A方法是比较好理解的，但是为什么this最后打印的是function B()？而不是function C()呢？有一句话是这样说的，函数一旦使用bind方法绑定参数之后，将不能再被更改，如果想要知道为什么，我们要看bind()方法的实现原理。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4e75c05f36654cfb82babe7576f2d36d~tplv-k3u1fbpfcp-watermark.image)

根据原理我们实际用代码模拟一下bind的底层实现。

```js
Function.prototype.mycall = function (context) {
    console.log('mycall');
    var context = context || window;
    context.fn = this;

    var args = [];
    for (var i = 1, len = arguments.length; i < len; i++) {
        args.push('arguments[' + i + ']');
    }

    var result = eval('context.fn(' + args + ')');

    delete context.fn
    return result;
}

Function.prototype.myapply = function (context, arr) {
    var context = Object(context) || window;
    context.fn = this;

    var result;
    if (!arr) {
        result = context.fn();
    }
    else {
        var args = [];
        for (var i = 0, len = arr.length; i < len; i++) {
            args.push('arr[' + i + ']');
        }
        result = eval('context.fn(' + args + ')')
    }

    delete context.fn
    return result;
}



if (!Function.prototype.mybind) {
    Function.prototype.mybind = function (oThis) {
        console.log('mybind');
        if (typeof this !== "function") {
            throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
        }

        var aArgs = Array.prototype.slice.call(arguments, 1),
            fToBind = this,
            fNOP = function () { },
            fBound = function () {
                return fToBind.apply(this instanceof fNOP
                    ? this
                    : oThis || this,
                    aArgs.concat(Array.prototype.slice.call(arguments)));
            };

        fNOP.prototype = this.prototype;
        fBound.prototype = new fNOP();

        return fBound;
    };
}


A = {
    value: 'A',
    f: function () {
        console.log('this指向', this.value)
    }
}

var f = A.f

var B = { value: 'B' }
var C = { value: 'C' }

f.mybind(C).mycall(B)
```

### 8.论述JS中的继承方法
共7种

**1.原型链继承**

**特点：**

子类实例可以继承3部分东西，分别是子类属性、父类属性和父类的原型，当子类属性和父类属性有重复时，子类部分会覆盖父类部分。

**缺点：**
- 子类无法向构造函数传参数
- 父类的属性和方法共享给所有的子类，父类中修改，子类也会跟着改。（浅拷贝）
```js
// 父类
function Father(name) {
    this.name = name;
    this.sum = function () {
        alert(this.name);
    }
}
Father.prototype.age = 10;

// 1.原型链继承
function Child() {
    this.name = 'ker';
}
Child.prototype = new Father();   //!!!!!
var child = new Child();   //实例people
child.sum();    //可调用方法
console.log(child.name)  //ker
console.log(child.age)  //10
console.log(child instanceof Father)    //true
```


**2.借用构造函数继承**

在子类构造函数中以call或者apply方式调用父类构造函数

**特点：**
- 只继承父类的属性，不继承父类的原型属性
- 解决了原型链继承的缺点：一改则全改的问题
- 解决了原型链继承的缺点：子类构造函数可以向父类构造函数传参
- 可以继承多个构造函数的属性：不同的函数

**缺点：**
- 只能继承父类构造函数的属性
- 无法进行复用，每个新实例都会把父类属性进行拷贝，臃肿（深拷贝）
```js
// 父类
function Father(name) {
    this.name = name;
    this.sum = function () {
        alert(this.name);
    }
}
Father.prototype.age = 10;

// 2.借用构造函数继承
function Child() {
    Father.call(this,'people');    //!!!!!
}
var child = new Child();
console.log(child.name);  //people
console.log(child.age);    //undefined
console.log(child instanceof Child);  //true
console.log(child instanceof Father);   //false
```

**3.组合继承（用得最多）**

原型链继承+借用构造函数继承

**特点：**
- 可以向父类传参
- 可以继承父类的属性和原型

**缺点：**
- 原型式浅拷贝，但子类属性是深拷贝，属性是无法共享的

```js
// 父类
function Father(name) {
    this.name = name;
    this.sum = function () {
        alert(this.name);
    }
}
Father.prototype.age = 10;

//3.组合继承
function Child(name) {
    Father.call(this,name);
}
Child.prototype = new Father();
var child = new Child('dream');
console.log(child.name);    //dream
console.log(child.age);   //10
```

**4.ES6的class继承**

**特点：**
- ES6比较清晰好理解，可以优先考虑class的用法
- 可以同时继承属性和原型（属性是深拷贝，原型是浅拷贝）

**缺点：**
和组合式继承的缺点一样，类属性是深拷贝，属性是无法共享的

```js
// 父类
class Father {
	// 该方法在构造函数上，不共享
	constructor(name){
    	this.name = name;
    }
    
    // 该方法在原型上，共享
    f(){
    	console.log(this.name);
    }
}

// 原型上的，共享
Father.prototype.age = 10;

// 子类
class Child extends Father{
	constructor(name, gender){
    	super(name);
        this.gender = gender;
    }
}

var child = new Child('dream', '女');
console.log(child.name);	// dream
console.log(child.age);	// 10
console.log(child.gender);		// 女
child.f();		// dream
```

**5.原型式继承**

该方法的原理是创建一个构造函数，构造函数的原型指向对象（这个对象是父类的实例），然后调用 new 操作符创建实例，并返回这个实例，本质是一个浅拷贝

**特点：**
- 子类会继承父类的属性和原型（都是浅拷贝，都会被共享）

**缺点：**
- 不可以传参
```js
// 父类
function Father() {
    this.name = 'dream';
    this.sum = function () {
        alert(this.name);
    }
}
Father.prototype.age = 10;

function Child(obj) {
    function F() { }
    F.prototype = obj;
    return new F();
}
var obj = new Father();  //父类的实例
var child = Child(obj);
console.log(child.age);   //10
console.log(child.name);	// dream
child.sum();		// dream
```

**6.寄生式继承**

特点：
- 属性和原型都可以继承（都是深拷贝）
- 和原型式继承类似，只是多了一个传参的功能

```js
function Father() {
    this.name = 'dream';
    this.sum = function () {
        alert(this.name);
    }
}
Father.prototype.age = 10;

function Child(obj) {
    function F() { }
    F.prototype = obj;
    return new F();
}

// 给原型式继承套个壳子,达到传参数的效果
function subobject(obj) {
    var sub = Child(obj);
    sub.name = 'GEM';
    return sub;
}

var obj = new Father(); 
var child = subobject(obj);

console.log(child.name);	// GEM
console.log(child.age);		// 10
```

**7.寄生式组合继承**

特点：
- 可以传参
- 可以继承父类的属性和原型（属性是深拷贝，原型式浅拷贝，和组合继承很像）
缺点：
- 可读性不太好，不是很好理解
```js
function Father(name) {
    this.name = name;
    this.sum = function () {
        alert(this.name);
    }
}
Father.prototype.age = 10;

// 这一步继承父类的原型
function Child(obj) {
    function F() { }
    F.prototype = obj;
    return new F();
}

var child = Child(Father.prototype);

// 用一个中介函数继承父类的属性
function Temp() {
    Father.call(this,'dream');   //这一步继承父类的属性
}
Temp.prototype = child;		// 这时候中介函数有了父类的原型和属性

// 可以开始使用中介类了
var temp = new Temp();
console.log(temp.name);
console.log(temp.age);
```
### 9.论述this指针
永远记住一句话：**this 永远指向最后调用它的那个对象**！！！
记住这句话，this指针你就懂了一大半。

再详细看一下7中情况下绑定的this指向

**1.默认绑定：在非函数脚本中，this被初始化为window**

```js
console.log(this);
```
输出

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fb808d00b36b428c82becf5006c8e095~tplv-k3u1fbpfcp-watermark.webp)

**2.默认绑定：在普通函数调用中，this被初始化为window**

```js
function f(){
    console.log(this);
}

f();
```
输出

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/15e7beba21fa47d8a6900bc0cc6b0591~tplv-k3u1fbpfcp-watermark.webp)

**3.隐式绑定：对象的函数通过对象调用，this被初始化为对象**

```js
var name = 'window';
function f3(){
    console.log(this.name);
}

var obj = {
    name: 'obj',
    f2: function(){
        console.log(this.name);
    },
    f3: f3,
    f4: function(){
        console.log(this);
    }
}

obj.f2();	// obj
f3();	// window
obj.f3();	// obj
var f31 = obj.f3;
f31();	// window
```

**4.显示绑定：call/apply/bind中，this被初始化为第一个参数**

```js
var name = 'window';
function f3(){
    console.log(this.name);
}

var obj = {
    name: 'obj',
    f2: function(){
        console.log(this.name);
    },
    f3: f3,
    f4: function(){
        console.log(this);
    }
}

var f32 = obj.f3;
f32.call(obj);	// obj
f32.apply(obj);		// obj
f32.bind(obj)();	//obj
```

**5.new绑定：用new调用构造函数中，this指向刚刚创建的对象**

```js
function Create(){
    this.name = 'create';
    console.log(this);
}

var c = new Create();  //上面会输出create对象
```

**6.隐式丢失：如果把函数作为callback赋值给setTimeout，那么this被初始化为windows**

```js

var name = 'window';
function f3(){
    console.log(this.name);
}

var obj = {
    name: 'obj',
    f2: function(){
        console.log(this.name);
    },
    f3: f3,
    f4: function(){
        console.log(this);
    }
}

setTimeout(obj.f3, 1000);   //输出window, 这是个特例
```
### 10.论述作用域和闭包
什么是作用域？：**作用域指的是您有权访问的变量集合**。

有两种作用域类型：**局部作用域、全局作用域**。

什么是执行环境？：**定义了执行期间可以访问的变量和函数。**

有两种执行环境：**全局执行环境（GO），函数执行环境（AO）**

什么是作用域链？：**AO和GO构成的链**

**预编译过程：**

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/53068311a9c546bcbf8aeaaab5b64187~tplv-k3u1fbpfcp-watermark.webp)

**函数调用的过程：**
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b40de32d3c4d461a8eb2ef615824b992~tplv-k3u1fbpfcp-watermark.webp)

**什么是闭包**？

闭包就是能够读取其他函数内部变量的函数。每个函数里变量的作用域是当前的函数的执行环境，形成的作用域链就是函数内部可以访问函数外部或者全局的变量，反过来是不可以的，闭包可以实现这个效果。

**闭包的原理**

正常情况下，在函数调用结束的时候，会释放当前AO执行环境里的变量，闭包就是让这个变量的引用计数不为0，从而函数里的变量不被释放，从而实现从外到里访问函数变量的效果

**最简单的闭包例子**
```js
function A(){
    var value = 'A';
    function B(){
        return value
    }
    return B;
}
console.log(A()())
```

**闭包的应用**
```js
function actionList(){
    var list = [];
    return function(option){
        if(list.indexOf(option) > -1){
            console.log('已存在')
        } else{
            list.push(option);
            console.log('不存在')
            console.log(list);
        }
    } 
}

var action = actionList();
action('张三')
action('李四')
action('张三')
```



### 11.什么是事件的委托？
把本注册在子元素的事件注册到父元素上，再寻找到事件的起源，实现相应的效果
```js
var ul = document.querySelector('#ul');
ul.addEvent('click', function(e){
    var target = this.getTarget();

    if(target !== this){
        target.innerHTML = '点过';
    }
});
```
### 12.如何阻止事件冒泡和默认事件行为？
阻止事件冒泡
```js
Element.prototype.stopPropagation = function(e){
    e = e || window.event;

    if(e.stopPropagation){
        e.stopPropagation();
    }else{
        e.cancelBubble = true;
    }
}
```
阻止事件默认行为
```js
Element.prototype.preventDefault = function(e){
    e = e || window.event;
    if(e.preventDefault){
        e.preventDefault();
    }else{
        e.returnValue = false;
    }
}
```
### 13.如何实现DOM的增删改查？
 **节点部分**

创建

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4a95265b7c44495188f43cb45a86c937~tplv-k3u1fbpfcp-watermark.webp)

案例：
```html
<!DOCTYPE html>
<html>
<body>

<div id="div1">
<p id="p1">这是一段文字。</p>
<p id="p2">这是另一段文字。</p>
</div>

<script>
var para = document.createElement("p");
var node = document.createTextNode("这是新的文本。");
para.appendChild(node);
var element = document.getElementById("div1");
element.appendChild(para);

var clone = para.cloneNode(true);
element.appendChild(clone);
</script>

</body>
</html>
```
删

removeChild()

```html
<!DOCTYPE html>
<html>
<body>

<div id="div1">
<p id="p1">这是一段文字。</p>
<p id="p2">这是另一段文字。</p>
</div>

<script>
var parent = document.getElementById("div1");
var child = document.getElementById("p1");
parent.removeChild(child);
</script>

</body>
</html>
```
改

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/823df5f193364f95acef0ca487960abd~tplv-k3u1fbpfcp-watermark.webp)
```html
<div id="div1">
<p id="p1">这是一个段落。</p>
<p id="p2">这是另一个段落。</p>
</div>

<script>
var para = document.createElement("p");
var node = document.createTextNode("这是新文本。");
para.appendChild(node);

var parent = document.getElementById("div1");
var child = document.getElementById("p1");

parent.replaceChild(para, child);
element.appendChild(para);
element.insertBefore(para, child);
</script>
```

查

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bd64130e4f4b47fa85624538b0ea9c5a~tplv-k3u1fbpfcp-watermark.webp)


**属性部分**

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1da30235a5ef4dcb8b25899d3b660ff2~tplv-k3u1fbpfcp-watermark.webp)

### 14.什么是本地对象、内置对象、宿主对象？
- 本地对象：可以实例化的对象，Array，RegExp
- 内置对象：不可以实例化的对象，Math
- 宿主对象：浏览器提供的缺省对象，比如浏览器中BOM和DOM中的window，document

### 15.document load 和document ready的区别？
ready：

HTML文件下载完了，DOM parse完了，window.addEventListener('DOMContentLoaded', function(){ } )

load：

CSS和图片加载完，window.onload = function(){}

### 16.==和===的区别？
==:
- 存在隐式类型转化，转化后相等即为true，但是判断引用类型时地址也要相等，否则为false

===:
- 要求完全相等：值相等，类型相等，引用类型地址也要相等

### 17.创建函数的方法?
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c841f4ea92584c428de80eeec25674df~tplv-k3u1fbpfcp-watermark.webp)

前三种比较简单，第四种我们举个例子
```js
var f = new Function('a', 'b', 'return a+b');
var result = f(1, 2);
console.log(result);
```

### 18.创建对象的方法？
**工厂模式**
```js
function createPerson(name){
    var obj = new Object();
    obj.name = name;
    obj.f = function(){
        console.log('hello');
    }
    return obj;
}
```
**构造函数模式**
```js
function Person(name){
    this.name = name;
    this.f = function(){
        console.log('hello');
    }
}

var person2 = new Person('dream');
console.log(2, person2);
```
**原型模式**
```js
function Person1(){
}

Person1.prototype.name = 'dream';
Person1.prototype.f = function(){
    console.log('hello');
}

var person3 = new Person1();
console.log(3, person3);

```
**原型-构造函数模式**
```js
function Person2(name){
    this.name = name;
}

Person2.prototype.f = function(){
    console.log('hello');
}

var person4 = new Person2('隔壁王校长4');
console.log(4, person4);
```
**动态原型-构造函数模式**
```js
function Person3(name){
    this.name = name;
    if(typeof this.f !== 'function'){
        Person3.prototype.f = function(){
            console.log('hello');
        }
    }
}
```
**寄生构造函数**
```js
function Array2(){
    var newArray = new Array();
    newArray.f = function(){
        console.log('hello');
    }
    return newArray;
}

var a = new Array2();
console.log('111'+typeof(a));
a.f();
```
**稳妥构造函数**
```js
function Array3(){
    var newArray = new Array();
    newArray.f = function(){
        console.log('hello');
    }
    return newArray;
}


var a2 = Array3();
console.log(a2);
```
### 19.简述什么是伪数组？
伪数组也称为类数组

数组是一个Array，伪数组是一个Object

DOM中有很多数组都是伪数组

**伪数组的特点**
- 有下标索引，可以通过索引访问
- 有length属性
- 不具有数组的pop()，push()等方法

### 20.为什么0.1+0.2不等于0.3，怎么让它等于0.3？
0.1和0.2在转换成二进制后会无限循环，由于标准位数的限制后面多余的位数会被截掉，此时就已经出现了精度的损失，相加后因浮点数小数位的限制而截断的二进制数字在转换为十进制就会变成0.30000000000000004。

以下办法可以得到0.3：
- parseFloat((0.1 + 0.2).toFixed(1))
- parseFloat((0.1 + 0.2).toPrecision(1)) [括号里填1-15都行]

```
- parseFloat 解析一个字符串，并返回一个浮点数
- toFixed 把数字转换为字符串，结果的小数点后有指定位数的数字
- toPrecision 把数字格式化为指定的长度
```

JS其他重要的数学方法：
- 四舍五入：Math.round()
- 向上取整：Math.ceil()
- 向下取整：Math.floor(),或者用parseInt
- 取最大值：Math.max(1, 2)   // 返回2
- 取最小值：Math.min(1, 2)	// 返回1
- 生成随机数：Math.random()


### 21.简述字符集有哪些
**ASCII字符集**：支持128个字符，每个字符一个字节，太小

**GB字符集族**：
- GB2312
- GBK
- GB18030

**Unicode字符集族**：
- UTF-8
- UTF-16
- UTF-32

**UCS字符集族**
- UCS-2
- UCS-4

### 22.深拷贝和浅拷贝区别？
参考文章[浅拷贝和深拷贝](https://juejin.im/post/6844904197595332622)
这篇文章写的实在是太好了[如何写出一个惊艳面试官的深拷贝?](https://segmentfault.com/a/1190000020255831)

**基本数据类型**：深拷贝和浅拷贝没有区别，都是在栈内存中拷贝新的区域存放数据。

**引用数据类型**：
- 	浅拷贝：堆内存里的数据是没有被拷贝的，只是把栈内存中的引用地址拷贝了一份给到新的对象，如果其中一个对象改变了数据，就会影响到另一个对象。
- 	深拷贝：堆内存里的数据和栈内存的引用地址，都拷贝了一份，其中一个对象改变数据的值，不会影响另一个对象。

**怎么实现一个浅拷贝**

方式一：数组concat() 基于当前数组的所有项创建一个新的数组返回
```js
let A = [{ a: '1', b: '2', obj: {c: '3'}}];
let B = A.concat();
console.log(B);     // [{ a: '1', b: '2', obj: {c: '3'}}]
B[0].a = '11';
B[0].obj.c = '33';
console.log(A);     // [{ a: '11', b: '2', obj: {c: '33'}}]
```

方式二：数组slice(start, end) 截取原数组的数据后放到新数组中返回
```js
let A = [{ a: '1', b: '2', obj: {c: '3'}}, {d: '4'}];
let B = A.slice(0,1);
console.log(B);     // [{ a: '1', b: '2', obj: {c: '3'}}]
B[0].a = '11';
B[0].obj.c = '33';
console.log(A);     // [{ a: '11', b: '2', obj: {c: '33'}}, {d: '4'}]
```

**怎样实现一个深拷贝**

方式一: Object.assign()，一级对象是深拷贝，二级对象是浅拷贝
```js
let A = { a: '1', b: '2', obj: {c: '3'}};
let B = Object.assign({}, A);
B.a = '11';
B.obj.c = '33';
console.log(B);  // { a: '11', b: '2', obj: {c: '3'}}
console.log(A);     // { a: '1', b: '2', obj: {c: '3'}}
```

方式二：扩展运算符... 一级对象是深拷贝，二级对象是浅拷贝
```js
let A = { a: '1', b: '2', obj: {c: '3'}};
let B = {...A}
B.a = '11';
B.obj.c = '33';
console.log(B);     // { a: '11', b: '2', obj: {c: '33'}}
console.log(A);     // { a: '1', b: '2', obj: {c: '33'}}
```

方式三：JSON.parse(JSON.stringify())

一级二级对象都是深拷贝，利用JSON.stringify将对象转成JSON字符串，再用JSON.parse把字符串解析成对象
```js
let A = { a: '1', b: '2', obj: {c: '3'}};
let B = JSON.parse(JSON.stringify(A))
B.a = '11';
B.obj.c = '33';
console.log(B);     // { a: '11', b: '2', obj: {c: '33'}}
console.log(A);     // { a: '1', b: '2', obj: {c: '33'}}
```

 方式四-1：遍历对象（一级对象），简单的for循环只能拷贝一级对象
```js
let A = { a: '1', b: '2'};
let B = {};
for (let key in A) {
    console.log(A[key]);
    if (typeof (A[key]) !== 'object') {
        B[key] = A[key];
    } 
}
B.a = '11';
console.log('B', B);     // { a: '11', b: '2' }
console.log('A', A);     // { a: '1', b: '2' }
```

方式四-2：递归遍历对象（有二级对象），需要用到递归
```js
let A = { a: '1', b: '2', obj: { c: '3' } };
递归函数
function deepClone(target) {
    console.log('typeof', typeof(target));
    if (typeof (target) !== 'object') {
        return target;
    } else {
        console.log('这是个对象');
        let targetObj = {};
        for(let key in target){
            targetObj[key] = deepClone(target[key]);
        }
        return targetObj;
    }
}

let B = deepClone(A);
B.a = '11';
B.obj.c = '33';
console.log('B', B);     // { a: '11', b: '2', obj: {c: '33'}}
console.log('A', A);     // { a: '1', b: '2', obj: {c: '33'}}
```

方式四-3：遍历对象(包含了二级对象是数组的情况)
```js
let A = { a: '1', b: '2', obj: ['3'] };
function deepClone(target) {
    console.log('typeof', typeof(target));
    if (typeof (target) !== 'object') {
        return target;
    } else {
        console.log('这是个对象');
        let targetObj = Array.isArray(target) ? [] : {};
        for(let key in target){
            targetObj[key] = deepClone(target[key]);
        }
        return targetObj;
    }
}

let B = deepClone(A);

B.a = '11';
B.obj[0] = '33';
console.log('B', B);     // { a: '11', b: '2', obj: ['33'] }
console.log('A', A);     // { a: '1', b: '2', obj: ['3'] }
```



### 23.实现给数字添加千分位符的方法?（把数字变成货币形式)

**方法1：数字分析， 取到整数部分， %1000 操作， 然后加逗号 拼接字符串**
```js
function toBillNum (num){

    var intNum = num.toString().split('.')[0];  // 整数部分
    var deciNum = num.toString().split('.')[1];     // 小数部分

    // 如果整数部分小于1000，直接返回
    if(intNum < 1000){
        return intNum;
    }

    // 整数部分大于1000
    var doc = Math.round(intNum/1000);  // 判断是否加，
    var array = [];     // 用数组存放逗号隔开的每部分
    while (doc > 1 || doc == 1){
        array.unshift(intNum%1000);
        array.unshift(',')
        intNum = Math.round(intNum/1000);
        doc = intNum/1000;
    }
    array.unshift(intNum);

    // 把数组变成字符串
    var result = array.join('');

    // 把整数部分和小数部分载拼接起来
    return result + '.' + deciNum;
}

console.log(toBillNum(11177239444.3));		//11,177,239,444.3
```

**方法2：按字符串处理，每隔3位加一个，**

```js
function toBillNum (num){
    // 变字符串
    var numToString = num.toFixed(2).toString();

    // 分成整数部分和小数部分
    var intNum = numToString.split('.')[0];    // 整数
    var deciNum = numToString.split('.')[1];    // 小数


    // 如果整数部分长度小于3，原样返回
    if(numToString.length <= 3){
        return numToString;
    }

    // 如果长度大于3，分成左中右三部分
        // 左：slice(0, length % 3)
        // 右：slice(length - 6)
        // 中：slice(左.length, length-6)
    var left = intNum.slice(0,intNum.length % 3);
    var right = intNum.slice(left.length);
    console.log(left + ':' + right);

    // 处理中间部分
    var end = 3;
    var rightResult = right.slice(0, end);
    while(end < right.length){
        rightResult = rightResult + ',' + right.slice(end, end + 3) ;
        end = end + 3;
    }

    // 整数左边 + 整数右边 + 小数部分
    var result = left + ',' + rightResult + '.' + deciNum;

    return result;
}

console.log(toBillNum(11177239444.23565));		// 11,177,239,444.24
```

**方法3：正则表达式**

判断字符是不是千分位的正则
```
^[0-9]{1,3}(,[0-9]{3})*(.([0-9]{1,2}))?$
```
字符替换成千分位的正则
```js
var num = "12345678".replace(/[1-9]\d{0,2}(?=(\d{3})+$)/g,'$&,');
console.log(num);	// 12,345,678
```


### 24.描述一下cookies，sessionStorage和localStorage的区别？
- localStorage：存储在本地，且可长期存储
- sessionStorage：存储在本地，会话过程中才有效，浏览器关闭后自动删除
- cookies：是为了识别用户身份而存在本地终端的数据，会在http请求中携带，在浏览器和服务器中来回传递

### 25. 回流和重绘？
参考文章[你真的了解回流和重绘吗](https://juejin.im/post/6844903779700047885#heading-11)

**一、浏览器渲染过程**

为了构建渲染树，浏览器主要完成了以下工作（浏览器引擎做的）：
```
1. 先把HTML文件的结构进行parse，得到DOM tree
2. 再把CSS的结构进行parse，得到Style rules
3. 把DOM tree 和 CSS rules合并，得到Render tree
```

为了能显示画面，渲染引擎做了以下工作：
```
4. Layout（回流）：根据生成的Render tree，得到节点的几何信息【位置、大小（font-size、position等）】
5. Painting (重绘) ：根据Render tree和回流得到的几何信息，得到节点的绝对像素（这个绝对像素指的是什么？指的是我们实际的像素值）
6. 最后一步Display : 将像素发送给GPU，展示在页面上。
```

**二、回流**

因为回流阶段是确定节点的位置和大小，所以当节点的位置和大小发生变化时，就会触发回流，有以下几种情况：
```
1. 页面开始渲染的时候
2. 元素的位置发生变化（float，top，right，bottom，left等）
3. 元素的大小发生变化（width，height，padding，margin，border等）
4. 窗口尺寸发生变化的时候（因为回流是根据视口的大小来计算元素的位置和大小的）
5. 内容发生变化的时候（比如图片被不同图片的尺寸代替）
6. 删除或者添加可见的DOM元素（因为又重新更新了DOM tree，所以必然触发回流）
```

**三、怎么减少回流和重绘**

**1. 将多次DOM的修改合并成一次**

合并前：
```
const el = document.getElementById('test');
el.style.padding = '5px';
el.style.borderLeft = '1px';
el.style.borderRight = '2px';
```
合并后:
```
const el = document.getElementById('test');
el.style.cssText += 'border-left: 1px; border-right: 2px; padding: 5px;';
```
合并前，三个样式的修改都会引起回流，合并后样式后再统一修改DOM

**2. 脱离文档流 =》修改=》放回文档流**

```
function appendDataToElement(appendToElement, data) {
    let li;
    for (let i = 0; i < data.length; i++) {
    	li = document.createElement('li');
        li.textContent = 'text';
        appendToElement.appendChild(li);
    }
}
const ul = document.getElementById('list');
ul.style.display = 'none';	// 脱离文档流
appendDataToElement(ul, data);	// 修改
ul.style.display = 'block';	// 放回文档流
```

**3. 避免多次强制刷新队列**

这里的队列是什么？因为如果每次DOM的修改都触发回流和重绘，消耗资源是比较大的，所以浏览器把修改放到队列里，等队列达到一个阈值，才会清空队列，统一重排，以下几种情况会强制刷新队列：
- offsetTop、offsetLeft、offsetWidth、offsetHeight
- scrollTop、scrollLeft、scrollWidth、scrollHeight
- clientTop、clientLeft、clientWidth、clientHeight
- getComputedStyle()
- getBoundingClientRect

比如这个案例

优化前：
```
function initP() {
    for (let i = 0; i < paragraphs.length; i++) {
        paragraphs[i].style.width = box.offsetWidth + 'px';
    }
}
```
优化后：
```
const width = box.offsetWidth;
function initP() {
    for (let i = 0; i < paragraphs.length; i++) {
        paragraphs[i].style.width = width + 'px';
    }
}
```

优化前每次循环都会强制刷新队列，会有很大的性能问题，优化后，只强制刷新了一次，可以提高性能。

**4. CSS3硬件加速（GPU加速）**

- 1. 使用css3硬件加速，可以让transform、opacity、filters这些动画不会引起回流重绘 。
- 2. 对于动画的其它属性，比如background-color这些，还是会引起回流重绘的，不过它还是可以提升这些动画的性能。

### 26.输入URL到展示页面的过程
1. 用户输入域名
2. 浏览器先检查自身缓存中有没有被解析过的这个域名对应的ip地址,如果有，执行第4步，如果没有，执行第3步
3. 域名解析成IP（DNS解析）
4. 根据IP建立TCP连接（三次握手）
5. HTTP发起请求
6. 服务器处理请求，浏览器接受HTTP响应
7. 浏览器接收响应后，拿到HTML、CSS、JS文件
8. 浏览器引擎解析HTML结构生成DOM tree
9. 浏览器引擎解析CSS结构生成CSS rules
10. 浏览器引擎把DOM tree和CSS rules合并成Render tree
11. Layout（回流）：渲染引擎渲染Render tree，得到节点的几何信息（位置和大小）
12. Painting（重绘）：渲染引擎根据Render tree和得到的几何信息，得到节点的绝对像素
13. 最后一步Display：把像素发送给GPU，展示在页面上

根据上面的步骤可以延伸出许许多多的面试题

### 27. 三次握手的过程
TCP的三次握手目的就是为了保证客户端和服务端建立可靠的链接
- 第一次：客户端发消息给服务端，请求建立链接（老弟，吃饭了嘛？）
- 第二次：服务端确认客户端的消息没问题，反向给客户端发送需要确认的消息（我吃了，你呢？）
- 第三次：客户端确认服务端消息没问题，并告诉服务端确认无误，可以连接（我也吃了）

TCP和UDP的区别
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/34b57652a6664f7dba9c2aa5b051bd62~tplv-k3u1fbpfcp-watermark.image)

- 使用TCP的应用：Web浏览器；电子邮件、文件传输程序。
- 使用UDP的应用：域名系统 (DNS)；视频流；IP语音(VoIP)。

### 28.HTTP的知识点
参考文章：三元大神的[HTTP灵魂之问，巩固你的 HTTP 知识体系](https://juejin.im/post/6844904100035821575)

**1.HTTP的报文结构是怎样的？**

共有4部分：起始行+头部+空行+实体

**起始行**

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3351ec23aada4d3f9c5ddaa8e0524d83~tplv-k3u1fbpfcp-watermark.image)

**2. http的请求方法？**

**2.1 请求方法有哪些？**

- GET: 通常用来获取资源
- HEAD: 获取资源的元信息
- POST: 提交数据，即上传数据
- PUT: 修改数据
- DELETE: 删除资源(几乎用不到)
- CONNECT: 建立连接隧道，用于代理服务器
- OPTIONS: 列出可对资源实行的请求方法，用来跨域请求（Cors跨域请求的复杂请求）
- TRACE: 追踪请求-响应的传输路径

**2.2 get和post有什么区别？**

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/997f00f75236452791352838c6f60a51~tplv-k3u1fbpfcp-watermark.image)

**3. HTTP状态码**

- 1xx: 表示目前是协议处理的中间状态，还需要后续操作。
- 2xx: 表示成功状态。
- 3xx: 重定向状态，资源位置发生变动，需要重新请求。
- 4xx: 请求报文有误。
- 5xx: 服务器端发生错误。

标黄的这几个可以重点记忆一下

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/bf23001b7e65493b83a358e6af07c810~tplv-k3u1fbpfcp-watermark.image)

**4. HTTP的特点？HTTP的缺点？**

特点：
```
1. 传输多样性：可以传文字、图片、视频等
2. 可靠传输：基于TCP/IP,这是TCP的特性
3. 请求-应答：一发一收，有来有回。
4. 无状态：每次请求都是独立的
```
缺点：
```
1. 无状态：在需要长连接的场景中，需要保存大量的上下文信息，以免传输大量重复的信息，那么这时候无状态就是 http 的缺点了。
2. 明文传输：协议里的报文(主要指的是头部)不使用二进制数据，而是文本形式
3. 队头阻塞：当 http 开启长连接时，共用一个 TCP 连接，同一时刻只能处理一个请求，那么当前请求耗时过长的情况下，其它的请求只能处于阻塞状态
```

**5. Accept 系列字段？**

一张图总结
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/266a48d19c914b7da6c40eb1f8754ef4~tplv-k3u1fbpfcp-watermark.image)

**6. 定长和不定长的数据怎么传输？**

定长：
```
发送端设置
res.setHeader('Content-Length', 8);
```
不定长：
```
res.setHeader('Content-Length', 10);
res.setHeader('Transfer-Encoding', 'chunked');
```
- Content-Length 字段会被忽略
- 基于长连接持续推送动态内容

**7. HTTP如何处理表单数据的提交**

Content-Type可以取两种值代表表单数据
- application/x-www-form-urlencoded
- multipart/form-data

**8. HTTP1.1 如何解决 HTTP 的队头阻塞问题？**

1.并发连接：每个域名可以并发多个长连接（Chrome的上线是6个）
2.域名分片：一个域名下再分出几个二级域名，每个二级域名又可以并发6个长连接

**9. cookie了解一下？**

**9.1 为什么需要cookie？**


因为http是无状态协议，每次请求都是独立的，但有时候我们需要保留一些状态，就需要用到cookie。

**9.2 cookie是什么？**

我们在Chrome的开发工具可以看到cookie长这样
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/42d679dfec6b43679a6da665f97005a5~tplv-k3u1fbpfcp-watermark.image)

每个值的释义如下：
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a23684e5d39f4e5e820e3a986f138aee~tplv-k3u1fbpfcp-watermark.image)

**9.3 cookie的缺点是什么？**

1. 容量缺陷：只能存储少量信息，体积上限是4KB
2. 性能缺陷：不管域名下的某个地址是否需要cookie，请求都会带上cookie，请求次数增多，就会造成资源浪费
3. 安全缺陷：cookie的在浏览器和服务器之间的传输时纯文本的，容易被非法用户进行获取和篡改

**10. http和https的区别**

[http和https的 11 个区别](https://www.ihuandu.com/help/zsk/46.html)

### 29.json对象转数组有哪些方法？
**1. Array.from()** 

用于数组的浅拷贝。就是将一个类数组对象或者可遍历对象转换成一个真正的数组。

```js
let obj = {
        0: 'nihao',
        1: 'haha',
        2: 'gansha',
        'length': 3
    } 
let arr = Array.from(obj)
console.log(arr);   
```
输出结果：

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f8822b3e721240fa80c4603f6e9f8192~tplv-k3u1fbpfcp-watermark.image)

**2.Object.values(object)**

与第一种不同的是不需要length属性，返回一个对象所有可枚举属性值。简单来说，就是把所有value取出来放到一个数组里。
```js
let obj = {
        0: 'nihao',
        1: 'haha',
        2: 'gansha'
    } 
let arr = Object.values(obj)
console.log(arr); 
```
输出结果：

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1c38271704e54fcd9c61344e020856f3~tplv-k3u1fbpfcp-watermark.image)

**3. Object.keys(object)**

把所有的key取出来，放到数组里
```js
let obj = {
        0: 'nihao',
        1: 'haha',
        2: 'gansha'
    } 
let arr = Object.keys(obj)
console.log(arr); 
```
输出结果：

![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0efa79f42ffa4053a2007869077af5a8~tplv-k3u1fbpfcp-watermark.image)

**4. Object.entries(object)**

同时取出key和value，放到数组里，数组的成员key和value也是数组
```
let obj = {
        0: 'nihao',
        1: 'haha',
        2: 'gansha'
    } 
let arr = Object.entries(obj)
console.log(arr); 
```
输出结果：

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d3dfd0b8eb1647f5a6e92f6f6447982e~tplv-k3u1fbpfcp-watermark.image)

**5.for  in 循环**
```
let obj = {
        0: 'nihao',
        1: 'haha',
        2: 'gansha'
    } 
let arr = []
for(key in obj){
    arr.push(obj[key])
}
console.log(arr);
```

输出结果：

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/695c62948b5c48489037b2b377f22261~tplv-k3u1fbpfcp-watermark.image)

### 30.讲一下promise？

**为什么我们会用到promise？**

promise是一种异步执行的机制，因为JS是单线程的，默认多个任务是排队进行处理的，如果其中一个任务耗时很长，就会造成任务队列的阻塞，所以我们需要用到异步执行。异步执行的方法有5种：
- 1.回调函数
- 2.Promise对象
- 3.Async函数
- 4.事件监听
- 5.发布订阅
其中promise函数是当回调函数出现回调地狱时，提出的解决方案。

**promise的处理过程？**

promise函数有

三个状态：Pending（进行中），Fulfilled（已成功），Rejected（已失败）,一个promise对象只能从一个状态变成另一个状态所以，当对象改变后，就不会再变了

有两个参数：resolve和reject，

一个回调函数then()

整体的使用情况是这样的
```js
let p = new Promise((resolve, reject) => {
	if(Math.random() > 0.5){
    	settimeout(resolve, 100)
    } else {
    	settimeout(reject, 100)
    }
})

p.then(() => {console.log('fullfilled')}, () => {console.log('reject')})
```

我们直接看一个怎么使用promise的例子：红灯3秒亮1次，绿灯2秒亮1次，黄灯1秒亮1次，怎么让这三个灯交替循环亮。

```js
// 红绿黄三个灯亮，对应3个函数
function red(){
    console.log('red')
}

function green(){
    console.log('green')
}

function yellow(){
    console.log('yellow')
}

// 这三个灯都是隔几秒亮一次，所以需要异步操作，用到promise
function action(callback, timer){
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            callback();
            resolve()
        }, timer)
    })
}

// 无限循环这3个异步函数
function start() {
    Promise.resolve().then(() => {
        return action(red, 3000)
    }).then(() => {
        return action(green, 2000)
    }).then(() => {
        return action(yellow, 1000)
    }).then(() => {
        start()
    })
}

start()
```

### 31.JS的事件循环机制

我们都知道JS是单线程的，JS的任务队列分为同步任务和异步任务，同步任务和异步任务是进入不同的执行环境，同步任务进入的是主线程，即主执行栈，异步任务进入的是任务队列（Event Queue）。执行的顺序是先把主线程里的任务执行完了，把任务队列里的任务放到主线程执行，整个循环过程就是我们所说的事件循环机制。异步和同步任务主要的分类如下：

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/45ad2247e50747ab8f5f043418aa058d~tplv-k3u1fbpfcp-watermark.image)

同步异步任务里又细分了宏任务和微任务，主要的分类如下：
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e4cd2f2dc95f4ac3b7cbf8618b091aaa~tplv-k3u1fbpfcp-watermark.image)

优先级顺序：

同步 --> 异步 --> 异步微任务 --> 异步宏任务

案例如下：写出下列代码的执行结果

```js
console.log('1');	// 同步
setTimeout(function() {		// 异步（宏任务）
    console.log('2');
    process.nextTick(function() {
        console.log('3');
    })
    new Promise(function(resolve) {
        console.log('4');
        resolve();
    }).then(function() {
        console.log('5')
    })
});
process.nextTick(function() {		// 异步（微任务）
    console.log('6');
})
new Promise(function(resolve) {		// 同步
    console.log('7');
    resolve();
}).then(function() {		//异步（微任务）
    console.log('8');
})
setTimeout(function() {			// 异步 （宏任务）
    console.log('9');
    process.nextTick(function() {
        console.log('10');
    });
    new Promise(function(resolve) {
        console.log('11');
        resolve();
    }).then(function() {
        console.log('12');
    });
});

```

答案：1 7 6 8 2 4 3 5 9 11 10 12


```js
async function async1() {
    console.log("async1 start");   2 同步
    await async2();  异步
    console.log("async1 end");   6 同步但是需要当awit执行完

}
async function async2() {
    console.log('async2');   3 异步里的同步
}
console.log("script start");   1 同步
setTimeout(function () {
    console.log("settimeout");  8 异步（宏任务）
}, 0);
async1();
new Promise(function (resolve) { 
    console.log("promise1");  4 同步
    resolve();
}).then(function () {
    console.log("promise2");  7 异步（微任务）
});
console.log('script end');  5 同步
```

### 32.箭头函数与普通函数的区别
- **（1）箭头函数不初始化this**
比如我们知道settimeout的回调函数是普通函数，在settimeout里普通函数里的this是指向windows中
```js
function f(){
    setTimeout(function(){
        console.log(this.id);	//undefined
    }, 1000);
}
f.call({id:5});		
```
但是当settimeout的回调函数如果是箭头函数，箭头函数的this会往父级找
```js
// ES6
function f(){
    setTimeout(() => {console.log(this.id)}, 1000); 	//1
}

let obj = {id: 1}
f.call(obj);
```
**- （2）不能够使用arguments对象**

普通函数是可以在函数内获取arguments对象的
```js
// ES5
var f1 = function(){
    console.log(arguments);		// []
}

f1(1, 2, 3, 4);

```
但是如果用箭头函数，会报undefined
```js
var f1 = () => {
    console.log(arguments);		// []
}
f1(1, 2, 3, 4);
```
但是箭头函数可以用rest参数代替arguments
```js
// ES6
let f2 = (...args) => {
    console.log(args);
}
f2(1, 2, 3, 4);
```

- （3）不能用作构造函数
正式因为箭头函数不初始化this，所以不能用作构造函数

### 33.如何把多维数组转化成一维数组
**方法1：字符串转化法**

join(): 把数组转换成字符串

split(): 把字符串转换成数组
```js
let tempArr = [1,[2,3],[4,5,[6,7]]];
let result_str1 = tempArr.join(',').split(',');
console.log(result_str1); //  ["1", "2", "3", "4", "5", "6", "7"]
let result = result_str1.map((item) => {
	return Number(item)
})
console.log(result);	// [1, 2, 3, 4, 5, 6, 7]
```

**方法二：递归**
```js
let tempArr = [1,[2,3],[4,5,[6,7]]];
let resultArr = [];
function action(tempArr){
    tempArr.forEach((item) => {
        console.log('1',typeof(item))
        if(item instanceof Array){
            action(item)
        }else{
            resultArr.push(item); 
        }
    })
}
action(tempArr)
console.log('result', resultArr)
```

### 34.讲下原型、原型链、原型链继承
**1. 原型**

关于原型，有三句话，请一定大声朗读且理解背诵，注意，理解了这三句话，你就能把原型搞懂了。
```js
1. 每个对象都有一个_proto_属性，且_proto_属性指向prototype原型对象
2. 每个构造函数都有一个prototype原型对象
3. 每个prototype原型对象里constructor属性指向构造函数
```
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/365f3f5516b949369d76be1cbee62e52~tplv-k3u1fbpfcp-watermark.image)

再看下代码，我们就非常清晰了
```js
function Person(nick, age){
    this.nick = nick;
    this.age = age;
}
Person.prototype.sayName = function(){
    console.log(this.nick);
}

var p1 = new Person('Byron', 20);

var p2 = new Person('Casper', 25);

p1.sayName()  // Byron

p2.sayName()  // Casper

p1.__proto__ === Person.prototype       //true

p2.__proto__ === Person.prototype   //true

p1.__proto__ === p2.__proto__           //true

Person.prototype.constructor === Person  //true全部这里。
```

**原型链**

我们看一个内置的方法：valueOf(),看一下这个方法是挂在哪里的
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/7cca4abcf7894a44888fa2c4a628192a~tplv-k3u1fbpfcp-watermark.image)

通过上图我们可以看到，valueOf是挂在Object对象的prototype原型对象上的一个方法。但是我们看下面的代码：
```js
let arr = [1, 2, 3]
console.log(arr.valueOf())		// [1, 2, 3]
```
上面的代码是正常输出的，为什么Array数组对象里并没有valueOf()这个方法，但是却没有报错呢，原因就是用到了原型链的查找。

整个查找过程是这样的：

- 1. 先在arr._proto_里（就是Array.prototype里）查找有没有valueOf()
- 2. 结果是没有找到，就会去Array._proto_里(就是Object.prototype里)查找有没有valueOf()
- 3. 开心，结果是找到了

所以传说中的原型链是这样的
arr ---> Array.prototype ---> Object.prototype

这就是传说中的原型链，层层向上查找，最后如果到终点Object.prototype._proto_还是没有就返回undefined

### 35.如果对象不想被更改怎么做？

正常的对象:是可以被：增删改
```js
let obj = { a: '1', b: '2'}
obj.a = '11';
obj.c = '33';
delete obj.b;
console.log(obj);
```

**方式一：防止扩展preventExtensions**

可以：改删，不可以：增
```js
let obj = { a: '1', b: '2'}
Object.preventExtensions(obj)
obj.a = '11';
obj.c = '33';
delete obj.b;
console.log(obj);
```

**方式二：密封seal()**

可以：改，不可以：删增
```js
let obj = { a: '1', b: '2'}
Object.seal(obj)
obj.a = '11';
obj.c = '33';
delete obj.b;
console.log(obj);
```

**方式三：冻结freeze()**

 不可以：增删改
```js
let obj = { a: '1', b: '2'}
Object.freeze(obj)
obj.a = '11';
obj.c = '33';
delete obj.b;
console.log(obj);
```

**注意**：对于同一个对象，防止扩展-->密封-->冻结这种操作是不可逆的。一旦该对象被冻结，是无法恢复到防止扩展或密封状态的。一旦该对象被密封，是无法恢复到防止扩展状态的。一旦对象被锁定，它将无法解锁。

```js
let obj = { a: '1', b: '2'}
Object.freeze(obj);
Object.seal(obj);
obj.a = '11';
console.log(obj);
```

### 36.什么是防抖和节流？有什么区别？如何实现？
浏览器的 resize、scroll、keypress、mousemove 等事件在触发时，会不断地调用绑定在事件上的回调函数，极大地浪费资源，降低前端性能。为了优化体验，需要对这类事件进行调用次数的限制。

正常情况下：每按一次事件就会触发一次函数
```js
window.addEventListener('keypress', ()=>{
    console.log('keypress')
})
```

**防抖：短时间内出发同一个函数，只执行一次（第一次或者最后一次）**

案例：触发最后一次，回车事件，延迟两秒触发
过程：按回车 --> 触发计时器 --> 如果2S内没有再按回车 --> 2秒后触发回车事件--> 如果2S内再次按了回车 --> 上一个没有结束的定时器会被清除 --> 重新计时，2S后触发回车事件
```js
function debounce(fn, delay) {
    let timer = null;

    return function () {
        clearTimeout(timer);
        timer = setTimeout(function(){
            fn.call();
        }, delay)
    }
}

function foo() {
    console.log('我按下了keypress');
}
window.addEventListener('keypress', debounce(foo, 2000));
```

存在的问题：如果我每次按回车的间隔都不超过2S，那就永远触发不了回车事件了，所以我们把代码改成执行第一次
```js
function debounce(fn, delay) {

    var timer = null;
    console.log('timer', timer);

    return function () {
        if (timer) {
            clearTimeout(timer);
            timer = setTimeout(function () {
                timer = null;
            }, delay)
        } else {
            fn();
            timer = setTimeout(function(){
                timer = null;
            }, delay)
        }
    }
}

function foo() {
    console.log('我按下了keypress');
}

window.addEventListener('keypress', debounce(foo, 2000));
```

**节流：在固定时间内只执行一次**

上面的案例还回有新的问题，虽然我第一按回车触发了事件，但是我接着继续按了好几十次，而且每次间隔都不超过2S，就会发现下一次回车事件就永远触发不了，所以引出了新的节流问题，其实代码更简单
```js
function debounce(fn, delay) {
    var timer = null;

    return function () {
        if (timer) {
            clearTimeout(timer);
            timer = setTimeout(() => {
                fn();
            }, delay)
        } else {
            fn();
            timer = setTimeout(function () {
                timer = null;
            }, delay)
        }

    }
}

function foo() {
    console.log('我按下了keypress');
}
window.addEventListener('keypress', debounce(foo, 2000));
```

### 37.介绍下Set、Map、WeakSet、WeakMap的区别？

详细介绍的文章[【ES6】Set、Map数据结构](https://juejin.cn/post/6873100151880155149#heading-12)

从几个方面掌握

- 怎么构造？
- 怎么遍历？
- 有什么属性和方法？
- 与数组之间怎么转换？

### 38.介绍下模块化的发展历程？
模块化是为了抽离公共代码，隔离作用域，避免变量冲突而衍生的。

**1. IIFE：**

最原始的立即执行函数就是模块化的一种方式
```js
(function(){
	return 1;
})()
```

**2. AMD: 使用requireJS来编写模块化**

特点：依赖必须提前声明好
```js
define('./index.js', function(){
	// index.js 返回的内容在这里
})
```

**3. CMD: 使用seaJS来编写模块化**
```js
define(function(require, exports, module){
	var indexCode = require('./index.js');
})
```

**4. CommonJS: node中自带的模块化**

node中自带的模块化

```js
var index = require('./index.js')
```

**5. ES Modules ES6引入的模块化**

这个是目前用的比较多的
```js
import index from './index.js'
```

### 38.讲一下同源策略？
参考了一篇讲得很好的文章[同源策略与JS跨域（JSONP , CORS）
](https://segmentfault.com/a/1190000009624849)

**同源**：指的是协议、域名、端口、路径相等的两个URL。

为什么会有同源策略：限制不同源的脚本对当前页面的信息进行读取和修改某些属性。目的是为了保护信息安全，防止恶意的网站窃取数据。

如果不同源，下面三种行为会受到限制
- Cookie、LocalStorage 和 IndexDB 无法读取。
- DOM无法获取
- Ajax在浏览器端有跨域限制

那不同源的客户端和服务端怎么进行数据的交互呢？所以引出了跨域。

**跨域：**
解决Ajax跨域请求的限制方法有两种：JSONP和CORS

**解决方案1：JSONP**

支持范围：
- 1.支持两个不同的域之前完成请求
- 2.支持get请求
- 3.老式浏览器也支持
- 4.需要服务端的支持

原理：html里script标签的src属性没有收到同源策略的限制

用法：
```js
a.html
...
<script>
    function localFunction(data) {
        console.log(data.url)
    }
</script>
<script src='http://www.XXX.com:3000/b.js?callback=localFunction'></script>
...

b.js
callback({url: 'http://www.rccoder.net'})
```

**解决方案2：CORS**

支持的范围：
- 1.支持两个不同的域之前完成请求
- 2.支持所有的http请求
- 3.部分老式浏览器也支持
- 4.需要服务端的支持

对于前端开发者来说，跨域的CORS通信与同源的AJAX通信没有差别，代码完全一样。因此，实现CORS通信的关键是服务器。只要服务器实现了CORS接口，就可以跨域通信。

浏览器将CORS请求分成两类：简单请求（simple request）和非简单请求（not-so-simple request）。


同时满足下列两种情况，就是简单请求：
```
（1) 请求方法是以下三种方法之一：
HEAD
GET
POST
（2）HTTP的头信息不超出以下几种字段：
Accept
Accept-Language
Content-Language
Last-Event-ID
Content-Type：只限于三个值application/x-www-form-urlencoded、multipart/form-data、text/plain
```

**简单请求的跨域：**

前端发送请求 --> 浏览器判断是否为简单请求 --> 如果是简单请求，浏览器会在请求头加一个origin字段 --> 服务器收到请求，如果origin字段的内容在允许范围内，在返回资源，同时在响应头上介绍Access-Control-Allow-Origin字段，值与origin的值相同

```js
请求头
GET /cors HTTP/1.1
Origin: http://api.bob.com
Host: api.alice.com
Accept-Language: en-US
Connection: keep-alive
User-Agent: Mozilla/5.0...
```

```js
响应头
Access-Control-Allow-Origin: http://api.bob.com
Access-Control-Allow-Credentials: true
Access-Control-Expose-Headers: FooBar
```

**非简单请求的跨域**

非简单请求比简单请求多了一次预检请求，预检的作用是向服务器确认当前网页的域名是否在服务器允许的名单中，以及允许的http方法和请求信息，只有得到服务器肯定的答复，才会继续发送XMLHttpRequest请求。

前端AJAX请求代码
```js
var url = 'http://api.alice.com/cors';
var xhr = new XMLHttpRequest();
xhr.open('PUT', url, true);
xhr.setRequestHeader('X-Custom-Header', 'value');
xhr.send();
```

浏览器判断为非简单请求，于是发送预检请求
```js
OPTIONS /cors HTTP/1.1
Origin: http://api.bob.com
Access-Control-Request-Method: PUT
Access-Control-Request-Headers: X-Custom-Header
Host: api.alice.com
Accept-Language: en-US
Connection: keep-alive
User-Agent: Mozilla/5.0...
```

服务器允许
```
HTTP/1.1 200 OK
Date: Mon, 01 Dec 2008 01:15:39 GMT
Server: Apache/2.0.61 (Unix)
Access-Control-Allow-Origin: http://api.bob.com
Access-Control-Allow-Methods: GET, POST, PUT
Access-Control-Allow-Headers: X-Custom-Header
Content-Type: text/html; charset=utf-8
Content-Encoding: gzip
Content-Length: 0
Keep-Alive: timeout=2, max=100
Connection: Keep-Alive
Content-Type: text/plain
Access-Control-Allow-Credentials: true
Access-Control-Max-Age: 1728000

```

服务器不允许
```
服务器会返回一个正常的HTTP回应。但是头信息中没有包含Access-Control-Allow-Origin字段，就知道出错了，从而抛出一个错误，被XMLHttpRequest的onerror回调函数捕获
```

### 39.var、let、const的区别
**1. var声明的变量可以挂在window上，但是let和const不会**
```js
var a = 1;
console.log(window.a);      //1

let b = 2;
console.log(window.b);      //undefined
console.log(b);     // 2

const c = 3;
console.log(window.c);      // undefined
console.log(c);     //3
c = 4;
console.log(c);     //3
```

**2. 不存在变量提升**
```js
console.log(a); // undefined  ===>  a已声明还没赋值，默认得到undefined值
var a = 100;

console.log(b); // 报错：b is not defined  ===> 找不到b这个变量
let b = 10;

console.log(c); // 报错：c is not defined  ===> 找不到c这个变量
const c = 10;
```

**3. let和const声明形成块作用域**
```js
if(1){
    var a = 100;
    let b = 10;
}

console.log(a); // 100
console.log(b)  // 报错：b is not defined  ===> 找不到b这个变量
```

**4. 同一作用域下let和const不能声明同名变量，而var可以**
```js
var a = 100;
console.log(a); // 100

var a = 10;
console.log(a); // 10

let a = 100;
let a = 10;

//  控制台报错：Identifier 'a' has already been declared  ===> 标识符a已经被声明了。
```

**5. 暂时性死区**
```js
var a = 100;

if(1){
    a = 10;
    //在当前块作用域中存在a使用let/const声明的情况下，给a赋值10时，只会在当前作用域找变量a，
    // 而这时，还未到声明时候，所以控制台Error:a is not defined
    let a = 1;
}
```

**6. const**
- 一旦声明，必须复制，不能用null代替
- 如果是基本数据类型，是不可以被修改的
- 如果是对象可以修改里面的属性

### 40. rem 的实现原理

rem的全称是font size of the root element, 相对于html根元素font-size的大小。比如一版设计稿的信息如下：
```
设备宽度：400px
html根元素font-size：16px
html里的div元素width为32px时：可以用2rem表示
```
但是移动端每个设备的宽度是不一样的，比如另一个设备的宽度扩大至2倍变成800px，则希望font-size可以自动扩大2倍至32px，div元素的width值还是2rem，但是div的宽度实际上也扩大2倍至64px。

其中的关键就是算出新的font-size的px值，新的值=（800/400）*16=32px,改变font-size的值，div也会自动变大了。

根据设备宽度，算出新的font-size的px值我们有对应的插件，整体的实现过程如下：
- 1. 当设备宽度变化时：  window.addEventListener("resize", function(){})，监听窗口变化
- 2. 获取新的窗口宽度：  document.documentElement.getBoundingClientRect().width: 获取整个设备的宽度
- 3. 算出新的font-size值：（新设备宽度/原设备宽度）*原font-size大小
```js
整体代码

//designWidth:设计稿的实际宽度值，需要根据实际设置
//maxWidth:制作稿的最大宽度值，需要根据实际设置
//这段js的最后面有两个参数记得要设置，一个为设计稿实际宽度，一个为制作稿最大宽度，例如设计稿为750，最大宽度为750，则为(750,750)
(function(designWidth, maxWidth) {
    var doc = document,
        win = window,
        docEl = doc.documentElement,
        remStyle = document.createElement("style"),
        tid;
    //浏览器竖屏与横屏转换的BUG。
    function refreshRem() {
        var width = docEl.getBoundingClientRect().width;
        console.log('width', width)
        maxWidth = maxWidth || 540;
        width>maxWidth && (width=maxWidth);
        var rem = width * 100 / designWidth;
        remStyle.innerHTML = 'html{font-size:' + rem + 'px;}';
    }

    if (docEl.firstElementChild) {
        console.log('docEl.firstElementChild')
        docEl.firstElementChild.appendChild(remStyle);
    } else {
        var wrap = doc.createElement("div");
        wrap.appendChild(remStyle);
        doc.write(wrap.innerHTML);
        wrap = null;
    }
    //要等 wiewport 设置好后才能执行 refreshRem，不然 refreshRem 会执行2次；
    refreshRem();

    // 监听窗口变化
    win.addEventListener("resize", function() {
        clearTimeout(tid); //防止执行两次
        tid = setTimeout(refreshRem, 300);
    }, false);

    // 点击返回是强制刷新页面
    win.addEventListener("pageshow", function(e) {
        if (e.persisted) { // 浏览器后退的时候重新计算
            clearTimeout(tid);
            tid = setTimeout(refreshRem, 300);
        }
    }, false);

    if (doc.readyState === "complete") {
        doc.body.style.fontSize = "16px";
    } else {
        doc.addEventListener("DOMContentLoaded", function(e) {
            doc.body.style.fontSize = "16px";
        }, false);
    }
})(750, 1024);
```

涉及JS里的几个方法和事件
```
1. document.createElement(): 创建一个元素

2. document.documentElement.getBoundingClientRect().width: 获取整个设备的宽度

3. document.readyState 属性返回当前文档的状态（载入中……）。

该属性返回以下值:

uninitialized - 还未开始载入
loading - 载入中
interactive - 已加载，文档与用户可以开始交互
complete - 载入完成

4. window.addEventListener("resize", function(){})
监听窗口变化

5. window.addEventListener("pageshow", function(){})
点击返回是强制刷新页面
```



面试高频上
https://juejin.cn/post/6882395803126595592/


本篇目录如下
- 41.数组去重的方法?
- 42.数组扁平化的方法?
- 43. 求斐波那契数列第n项的方法？
- 44.怎样实现一个私有变量？
### 41.数组去重的方法
**方法一：建新的数组，用indexOf()判断是否在新的数组内**
```js
function action(arrinit){
    let result = [];
    arrinit.forEach(item => {
        if(result.indexOf(item) < 0){
            result.push(item)
        }
    });
    return result;
}
```
**方法二：双重for循环原数组，用splice方法删除数据**
```js
function action(arrinit){
    for(let i = 0; i < arrinit.length; i ++){
        for(let j = i + 1; j < arrinit.length; j ++){
            if(arrinit[i] == arrinit[j]){
                arrinit.splice(i, 1);
                i --;
            }
        }
    }
    return arrinit;
}
```
**方法三：借助set**
```js
function action(arrinit){
    let m = new Set(arrinit);
    // let result = [...m];     // 方式1
    let result = Array.from(m);     // 方式2
    return result;
}
```
**方法四：借助ES6的Map数据结构也可以去重**

```js
function action(arrinit){
    let result = []
    let m = new Map();
    arrinit.forEach(element => {
        if(!m.has(element)){
            m.set(element, true);
            result.push(element);
        }
    });
    return result;
}
```

**方法五：借助数组的includes方法**
```
function action(arrinit){
    let result = [];
    for(let i = 0; i < arrinit.length; i ++){
        if(!result.includes(arrinit[i])){
            result.push(arrinit[i]);
        }
    }
    return result;
}
```
**方法六：借助数组的filter方法**
```js
function action(arrinit){
    return arrinit.filter((item, index) => {
        return arrinit.indexOf(item) === index;
    })
}
```
**方法七：先sort，再比较两个相邻的元素**
```js
function action(arrinit) {
    arrinit.sort();
    for (let i = 0; i < arrinit.length - 1; i++) {
        if (arrinit[i] == arrinit[i + 1]){
            arrinit.splice(i, 1);
            i --;
        }
    }
    return arrinit;
}
```
**方法八：利用对象的属性不能相同去重**
```js
function action(arrinit){
    let resultarr = [];
    let resultabj = {};
    arrinit.forEach(item => {
        if(!resultabj[item]){
            resultabj[item] = 1;
            resultarr.push(item)
        }
    });
    return resultarr;
}
```

### 42.数组扁平化的方法
方法1：ES6的flat方法
```js
function action(arrinit){
    let result = arrinit.flat()
    return result;
}
```

方法2：ES6的扩展运算符(但是这个只能把二维变一维)
```js
function action(arrinit){
    let result = [...arrinit];
    return result;
}
```

方法3：数组.join() ==> 字符串 ==> 字符串.split()
```js
function action(arrinit){
    let result = arrinit.join().split();
    return result;
}
```

方法4：数组.toString() ==> 字符串
```js
function action(arrinit){
    let result = arrinit.toString().split();
    return result;
}
```

方法5：递归
```js
let result = [];
function action(arrinit){
    arrinit.forEach(element => {
        if(typeof(element) !== 'object'){
            result.push(element);
        } else {
            action(element);
        }
    });
}
```

方法6：借助reduce()和concat()【注意不能用push，因为return arr.push() 后的是元素，不是数组arr】
```js
function action(arrinit){
    return arrinit.reduce((prev, cur) => {
        console.log(prev, cur);
        // console.log((typeof(cur) === 'object') ? action(cur) : cur)
        let result = prev.push(((typeof(cur) === 'object') ? action(cur) : cur));
        console.log(result)
        return result
    }, [])
}
```

### 43. 求斐波那契数列第n项的方法？
方法1：循环
```js
function action(n){
    let res1 = 1;
    let res2 = 1;
    let sum;
    for(let i = 1; i < n - 1; i ++){
        sum = res1 + res2;
        res1 = res2;
        res2 = sum;
    }
    return sum;
}
```
方法2：数组
```js
function action(n){
    let result = [];
    for(let i = 0; i < n; i ++){
        if(i - 2 < 0) {
            result.push(1)
        }else {
            result.push(result[i - 1] + result[i - 2]);
        }
    }

    return result[result.length - 1];
}
```

方法3-1：递归（从小到大）
```js
function action(num1, num2, i){
    if(i < n){
        return action(num2, num1 + num2, ++ i)
    }else {
        return (num1 + num2);
    }
}
action(1, 1, 3)
```

方法3-2： 更加简明的递归写法（从大到小）
```js
function action(n){
    if(n <= 1){return 1};
    return action(n-2) + action(n-1);
}
```

### 44.怎样实现一个私有变量？
通过闭包实现
```js
function A (){
    var name = 'Tom';
    this.getName = function(){
        return name
    }
}

let a = new A();
console.log(a.name);	// undefined
console.log(a.getName());		// Tom
```





