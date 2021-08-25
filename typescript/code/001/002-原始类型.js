// 类型：原始类型和引用类型
// ES5：原始类型：字符串，数字，布尔，null，undefined （变量和函数返回值）
// ES6：原始类型：Symbol
// 1. 字符串 
var str = '隔壁王校长';
str = 'abc';
// str = 5;
// str = new String('aaa');
// 2. 数字
var n1 = 5;
var n2 = 0xffff; //十六进制 ES5
var n3 = 10; //二进制 ES6
var n4 = 511; //八进制 ES6
var n5 = NaN;
var n6 = Infinity;
// let n7: number = new Number(1);
// 3. 布尔
var isDone = false;
// isDone = 1;
// 4. 空值: void类型的变量既可以赋值为 undefined，也可以赋值为null
var u = undefined;
u = null;
// u = 1;
// 5. undefined类型, null类型
var u2 = undefined;
var u3 = null;
// undefined和null是所有类型的子类
// A是个集合，B是个集合，如果任何A中的任意实例，都是B中的实例，A是B的子类
var n8 = undefined;
var str3 = undefined;
var b3 = undefined;
var n9 = null;
var str4 = null;
var b4 = null;
n8 = u;
