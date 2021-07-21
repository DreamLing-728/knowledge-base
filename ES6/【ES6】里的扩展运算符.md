### 1.用法
**对象中的扩展运算符(...)用于取出参数对象中的所有可遍历属性，拷贝到当前对象之中**

例如：
```js
let xxm = { a: 1, b: 2 };
let xxm1= { ...xxm}; // { a: 1, b: 2 }
console.log(xxm1)
```
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9fbc8ea02d7a433488060f38133f4a1f~tplv-k3u1fbpfcp-zoom-1.image)

那有个疑问哦，为啥要用...，直接赋值不行嘛，我们来看下是否可行
```js
let xxm = { a: 1, b: 2 };
let xxm1 = xxm
console.log(xxm1)
```
![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e346b03ebf7246559cfdaa2f71e2f9eb~tplv-k3u1fbpfcp-watermark.image)

咦，好像也是可以的呢，但是，我们试着修改xxm，看看xxm1会不会变

### 2.扩展运算符和普通赋值区别

**先看扩展运算符...**
```
let xxm = { a: 1, b: 2 };
let xxm1= { ...xxm}; // { a: 1, b: 2 }
console.log(xxm1)
xxm['a'] = 2
console.log(xxm)
console.log(xxm1)
```
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f934f7d539a54419b2e4d46067561893~tplv-k3u1fbpfcp-watermark.image)

**接着看普通的赋值**
```
let xxm = { a: 1, b: 2 };
let xxm1= xxm; // { a: 1, b: 2 }
console.log(xxm1)
xxm['a'] = 2
console.log(xxm)
console.log(xxm1)
```
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/103959af7d954fe9a28cb27b45e8501d~tplv-k3u1fbpfcp-watermark.image)

我们可以看到，采用赋值方法进行对象的拷贝，前一个对象的改变时，后面的对象会跟着改变，但是采用扩展运算符不会出现这种情况，这是因为扩展运算符采用的是深拷贝的方式，而普通的赋值其实是浅拷贝。

