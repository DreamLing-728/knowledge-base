## 1.let、const和块级作用域
1.1 var 和 let用法一致，都是用来定义变量，但是var定义的是全局的，let定义的只对块作用域有效
```
{
  let a = 10;
  var b = 1;
}

a // ReferenceError: a is not defined.
b // 1
```

1.2 for循环中let 和 var的区别
```
var a = [];
for (var i = 0; i < 10; i++) {
  console.log('1-'+i)		//0-9
  a[i] = function () {
    console.log('3'+i); //10
  };
}
console.log('2'+i);		//10
a[6](); // 10
```
上述代码中，var定义的i是全局，只有一个i，i的值不断被更新，在调用```a[6]()```时，此时i的值已经被更新为10了

```
var a = [];
for (let i = 0; i < 10; i++) {
  console.log('1-'+i)		//0-9
  a[i] = function () {
    console.log('3'+i); //10
  };
}
console.log('2'+i);		//Uncaught ReferenceError: i is not defined
a[6](); // 10
```
上述代码中，（）里作为一个父级作用域，{}作为一个子级作用域，每一轮循环都是一个新的i，所以```a[6]()```可以取到i为6的值。

1.3 for循环有一个特别之处，设置循环变量的部分是一个父作用域，循环体内部是一个单独的子作用域
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/20807f6ae16f44c8b7f07eb35398a153~tplv-k3u1fbpfcp-zoom-1.image)
情况1：会输出3次3
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c3cf78f5e76c4e48a53eddce10cf8f20~tplv-k3u1fbpfcp-zoom-1.image)
情况2：只输出1次3，因为var定义的是全局的变量i，进入到块级{}的作用域时，i从0变成3，随后输出，且不会进入到下一个循环，所以只输出一次3
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f6bf2fcb30524d709b70802c36f4774e~tplv-k3u1fbpfcp-zoom-1.image)
情况3：会报语法错误，因为父作用域已经let一个i了，如果此时var一个全局的i，就会报语法错误
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/105692dd31554823a876daa26c95950c~tplv-k3u1fbpfcp-zoom-1.image)
情况4：输出3个3，因为子作用域用的是let，不影响父作用域的var，所以和情况1一样，会输出3个3

## 3.ES6声明变量的6种方法？
var、function（ES5中的两种）

let、const、import、class（ES6新增）


