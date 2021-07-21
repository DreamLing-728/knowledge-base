// 类和接口
// 类是一个已经实现了所有细节的构造器
// 接口是对对象细节的描述
// 如果一个类声称实现了一个接口，那么这个类构造出来的实例一定符合这个接口
// 类实现了某个接口
// interface IA{
//     a: number;
//     b: string;
//     f(x: number):void;
// }
// interface IA2 {
//     c: number;
//     f2(x: number):void;
// }
// class A implements IA, IA2 {
//     a: number;
//     b: string;
//     c: number;
//     constructor(a: number, b: string, c: number){
//         this.a = a;
//         this.b = b;
//         this.c = c;
//     }
//     f(x: number):void {
//         console.log(this.a, this.b);
//     }
//     f2(x: number):void {
//         console.log(this.c);
//     }
// }
// let p: A = new A(1, 'abcv', 2);
// let a: IA = p;
// a.f(1); // 1 'abcv'
// let b: IA2 = p;
// b.f2(2);  // 2
// 接口继承接口
// interface IA {
//     a: number;
//     b: string;
//     f(x: number):void;
// }
// interface IA2 extends IA{
//     c: number;
//     f2(x: number):void;
// }
// class A implements IA2 {
//     a: number;
//     b: string;
//     c: number;
//     constructor(a: number, b: string, c: number){
//         this.a = a;
//         this.b = b;
//         this.c = c;
//     }
//     f(x: number):void {
//         console.log(this.a, this.b);
//     }
//     f2(x: number):void {
//         console.log(this.c);
//     }
// }
// let p: A = new A(1, 'abcv', 2);
// let ai: IA = p;
// ai.f(1); // 1 'abcv'
// let bi: IA2 = p;
// bi.f2(2);  // 2
// 接口继承类
var C1 = /** @class */ (function () {
    function C1() {
    }
    C1.prototype.f = function () {
        console.log('aaa');
    };
    return C1;
}());
var C2 = /** @class */ (function () {
    function C2(a, b, c) {
        this.a = a;
        this.b = b;
        this.c = c;
    }
    C2.prototype.f = function () {
        console.log(this.a, this.b);
    };
    return C2;
}());
var c = new C2(1, 'abcv', 2);
var i = c;
i.f(); // 1 'abcv'
