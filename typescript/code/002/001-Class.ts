// 类

// 面向对象：封装，继承，多态

// ES5: 
//    构造函数
//    new关键字，生成对象
//    原型、原型链
//    多态性（ploymorphism）： 动态语言天生支持多态性

// ES6:
//    class关键字，class的声明属性和方法
//    extends关键字，类的继承
//    get, set关键字，存取器
//    static关键字，静态方法

// ES7:
//    实例属性
//    static关键字，静态属性

// TypeScript:
//    private，protected，public关键字，用于修饰属性或者方法，访问权限，封装
//    abstract关键字，抽象类，抽象方法


// public： 用于修饰类的属性以及方法，用public修饰的属性和方法在类内、外都可以调用。
// protected: 用于修饰类的属性以及方法，用protected修饰的属性和方法，只能由类或者子类的函数访问。
// private: 用于修饰类的属性以及方法，用protected修饰的属性和方法，只能由类函数访问
// class Base {
//     protected a: number;
//     private b: string;
//     public constructor(a: number, b: string){
//         this.a = a;
//         this.b = b;
//     }
//     public f(): void{
//         // protected属性可以访问
//         // private属性可以访问
//         console.log(this.a, this.b);
//     }
// }

// let b = new Base(1, 'abc');
// // protected变量无法访问
// // console.log(b.a);
// // private变量无法访问
// // console.log(b.b);
// b.f();

// class DerivedClass extends Base{
//     public c: number;
//     public constructor(c: number, ...args: any[]){
//         super(...<[number, string]>args);
//         this.c = c;
//     }
//     public f2(): void{
//         // 基类的protected属性，子类函数可以访问
//         console.log(this.a);
//         // 基类的private属性，子类函数不可以访问
//         // console.log(this.a);
//     }
// }

// let d = new DerivedClass(1, 2, 'cde');
// d.f2();

// 抽象类：不可实例化，不能直接new出实例来
//   当做基类来使用
// abstract class Base {
//     protected a: number;
//     private b: string;
//     public constructor(a: number, b: string){
//         this.a = a;
//         this.b = b;
//     }
//     public f(): void{
//         // protected属性可以访问
//         // private属性可以访问
//         console.log(this.a, this.b);
//     }
//     // 抽象方法
//     public abstract f3(): void;
// }

// // 抽象类不可以实例化
// // let b: Base = new Base(1, 'abc');

// class DerivedClass extends Base{
//     public c: number;
//     public constructor(c: number, ...args: any[]){
//         super(...<[number, string]>args);
//         this.c = c;
//     }
//     public f2(): void{
//         console.log(this.a);
//     }

//     public f3(): void {
//         console.log('hello');
//     }
// }

// let b: Base = new DerivedClass(1, 2, 'cde');
// b.f3();


// 父类
// abstract class Father {
//     // 需要先定义
//     public name: string
//     public age: number
//     public constructor (name, age) {
//       this.name = name
//       this.age = age
//     }
//     public abstract f1(): void
//   }
  
//   class Son extends Father{
//     public phone: string
//     constructor(phone, ...args: [string, number]) {
//       super(...args)
//       this.phone = phone
//     }
//     public f2(): void {
//       console.log('this.name', this.name)
//     }
     
//     // public f1(): void {
//     //   console.log('this.name', this.name)
//     // }
//   }
  
//   let fa: Father = new Son('17836762323', '父类', 36)
//   fa.f1() // this.name 父类


// let cml: {x: number, y: number} = {x: 1, y: 1}
// cml.x = 2
// console.log(cml)

// 类，抽象类，接口 -》怎么用？

