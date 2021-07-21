// 类
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
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
var Base = /** @class */ (function () {
    function Base(a, b) {
        this.a = a;
        this.b = b;
    }
    Base.prototype.f = function () {
        // protected属性可以访问
        // private属性可以访问
        console.log(this.a, this.b);
    };
    return Base;
}());
// 抽象类不可以实例化
// let b: Base = new Base(1, 'abc');
var DerivedClass = /** @class */ (function (_super) {
    __extends(DerivedClass, _super);
    function DerivedClass(c) {
        var args = [];
        for (var _i = 1; _i < arguments.length; _i++) {
            args[_i - 1] = arguments[_i];
        }
        var _this = _super.apply(this, args) || this;
        _this.c = c;
        return _this;
    }
    DerivedClass.prototype.f2 = function () {
        console.log(this.a);
    };
    DerivedClass.prototype.f3 = function () {
        console.log('hello');
    };
    return DerivedClass;
}(Base));
var b = new DerivedClass(1, 2, 'cde');
b.f3();
// 类，抽象类，接口 -》怎么用？
