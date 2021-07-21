### 1. 属性的简洁表达方式
当属性名和变量名一样的时候，可以省略，只写一个
```
let a = 1;
let b = 2;

// ES5
var obj = {
    a: a,
    b: b
};

// ES6
let obj = {
    a,
    b
};
```
### 2. 成员函数的简洁表达方式
```
var obj = {
	
    // ES5
    f: function(){
        console.log('hello World!');
    }
     
    // ES6
    f(){
        console.log('hello World!');
    }
}
```
用途：JS的模块化
```
a.js
let a = 5;
function f1(){
}
function f2(){
}

let module = {};

// ES5
module.exports = {
    a: a,
    f1: f1,
    f2: f2
}

// ES6
module.exports = {a, f1, f2};
```

### 3. 属性名表达式
ES5里定义对象的属性有两种方法
```
// 方法一：
obj.foo = true;
// 方法二：
obj['a' + 'bc'] = 123;

// 如果放在{}里，只能这样
var obj = {
	foo: true;
    abc: 123;
}
```
ES6里可以使用表达式定义属性名
```
var obj = {
	foo: true;
    abc: 123;
    ['a' + 'bc'] : 123;		//也可以这样写
}

```
### 4. Object.is() 唯一一个提供了两个值是否相等的函数
```
// 这两种结果不是我们想要的
console.log(+0 === -0);		// true
console.log(NaN === NaN);	// false

// Object.is()可以得到我们想要的结果
console.log(Object.is(+0, -0));		// false
console.log(Object.is(NaN, NaN));	// true
console.log(Object.is({}, {}));		// false (对象是比较地址，这两个地址不一样，所以false)
```
### 5. Object.assign() 对象的拷贝

```
let target = {a: 1};
let source1 = {
    abc: 25,
    cde: 27
};

let source2 = {
    abc: 27,
    x: 17,
    y: 'abc'
};

source1.__proto__.b = 5;
console.log(source1.b);		// 5
// 5.1 只会拷贝本身的，不会拷贝prototype上的属性
// 5.2 如果属性名相同，后面的会覆盖前面的
console.log(Object.assign(target, source1, source2));	//	{a: 1, abc: 27, cde: 27, x: 17, y: 'abc'}	
console.log(target);	//	{a: 1, abc: 27, cde: 27, x: 17, y: 'abc'}

// 5.3 target如果不是对象，是string，number或者boolean，会先转化为包装类
console.log(Object.assign(2, source1, source2));	//{[Number:2], abc: 27, cde: 27, x: 17, y: 'abc'}

// 5.4 如果target是undefined,null，无法转化为包装类，那么报错
console.log(Object.assign(null, source1, source2));		// 报错

// 5.5 如果source不是对象，只有是string，可以计算，否则没有影响。
console.log(Object.assign({}, 'abc', 123, true));	//{0: "a", 1: "b", 2: "c"}

// 5.6 如果target，source1，source2都是数组，则合并后以source2的值为准

```
5.6 Object.assign的拷贝是浅拷贝，不是深拷贝
```
let target = {
    a: 1,
    b: {
        x: 5,
        y: 7
    }
};

let source = {
    b: {
        z: 9,
        h: 51
    }
}

console.log(Object.assign(target, source));
```
因为是浅拷贝，只对修改了对象的指向地址，所以结果如下
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a8f6af83a3b4400281da3d575eafd5eb~tplv-k3u1fbpfcp-zoom-1.image)
如果想要达到叠加的效果，需要这样
```
console.log(Object.assign(target.b, source.b));
```
### Object.assign的应用
应用1：用于构造函数
```
class Point{
    constructor(x, y){
        // this.x = x;
        // this.y = y;
        Object.assign(this, {x, y});
    }
}

console.log(new Point(1, 2));
```
应用2：在原型上添加函数
```
Point.prototype.f = function(){
    console.log('I am f!');
}
Object.assign(Point.prototype,
    {f(){
        console.log('I am f!');
    }
});

let p = new Point(1, 22);
p.f();		//  I am f
```
应用3：为属性指定默认值

当函数参数的默认值，不能用对象解构赋值的时候（比如对象的原型链上挂了很多东西的时候）
```
const PARAMS_DEFAULT = {
    x: 0,
    y: 0,
    z: 0
}

function f(params){
    params = Object.assign({}, PARAMS_DEFAULT, params);
    console.log(params);
}

let obj = {
    x: 5,
    y: 3
}

f(obj);
```
### 6.Object.entries(), Object.keys(), Object.values()
```
var obj = {
    a: 1,
    b: 2,
    c: 3
}

for(let key of Object.keys(obj)){
    console.log(key);
}

for(let value of Object.values(obj)){
    console.log(value);
}

for(let [key, value] of Object.entries(obj)){
    console.log(key, value);
}
```
### 7.对象的扩展运算符
```
// 方法1
let {a, ...args} = {a: 1, b: 2, c: 3, d: 4};
console.log(args);

let z = {a: 1, b: 2};
let n = {c: 3, ...z};
console.log(n);

// 方法2
console.log(Object.assign({c: 3}, z));
```
第5部分assin()拷贝对象可以简化成如下
```
let target = {a: 1};
let source1 = {
    abc: 25,
    cde: 27
};

let source2 = {
    abc: 27,
    x: 17,
    y: 'abc'
};

// assignd 用法
console.log(Object.assign(target, source1, source2)); 

// 扩展运算符...的用法
target = {...target, ...source1, ...source2};		// 很地道
console.log(target)
```
