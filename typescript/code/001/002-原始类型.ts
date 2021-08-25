// 类型：原始类型和引用类型
// ES5：原始类型：字符串，数字，布尔，null，undefined （变量和函数返回值）
// ES6：原始类型：Symbol

// 1. 字符串 
let str: string = '隔壁王校长';
str = 'abc';
// str = 5;
// str = new String('aaa');

// 2. 数字
let n1: number = 5;
let n2: number = 0xffff; //十六进制 ES5
let n3: number = 0b1010; //二进制 ES6
let n4: number = 0o777;  //八进制 ES6
let n5: number = NaN;
let n6: number = Infinity;

// let n7: number = new Number(1);

// 3. 布尔
let isDone: boolean = false;
// isDone = 1;

// 4. 空值: void类型的变量既可以赋值为 undefined，也可以赋值为null
let u: void = undefined;
u = null;
// u = 1;

// 5. undefined类型, null类型
let u2: undefined = undefined;
let u3: null = null;
// undefined和null是所有类型的子类
// A是个集合，B是个集合，如果任何A中的任意实例，都是B中的实例，A是B的子类

let n8: number = undefined;
let str3: string = undefined;
let b3: boolean = undefined;
let n9: number = null;
let str4: string = null;
let b4: boolean = null;
// n8 = u;

