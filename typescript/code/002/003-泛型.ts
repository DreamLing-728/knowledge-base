// 泛型 类：数据类型确定，但是数据值不确定，通过赋值，得到实例
// 泛型 是让类\函数\接口可以配置类型

// 函数的泛型。
// 返回一个具有默认值的数组 createArray(5, 'abc');
// function createArray(length: number, value: any): any[]{
//     let result: any[] = [];
//     for(let i = 0; i < length; i++){
//         result[i] = value;
//     }
//     return result;
// }

// let a: any[] = createArray(3, 'abc');
// console.log(a);

// function createArray<MyType>(length: number, value: MyType): MyType[]{
//     let result: MyType[] = [];
//     for(let i = 0; i < length; i++){
//         result[i] = value;
//     }
//     return result;
// }

// let a: string[] = createArray<string>(3, 'abc');
// console.log(a);

// 多个类型的泛型
// function swap<T, U>(tuple: [T, U]): [U, T]{
//     return [tuple[1], tuple[0]];
// }

// console.log(swap<number, string>([5, 'abc']));

// 类使用泛型：
// class A<T>{
//     a: T;
//     b: T;
//     constructor(a: T, b: T){
//         this.a = a;
//         this.b = b;
//     }
// }

// let a: A<string> = new A<string>('abc', 'def');
// console.log(a);

// let b: A<number> = new A<number>(1, 2);
// console.log(b);

// class B{
//     x: number;
//     constructor(x){
//         this.x = x;
//     }
// }

// let c: A<B> = new A<B>(new B(1), new B(2));
// console.log(c);

// 接口的泛型
// interface A<T>{
//     a: T;
//     b: T;
// }

// let x: A<number> = {
//     a: 1,
//     b: 2
// };

// console.log(x);

// 泛型约束

// interface IWithLength{
//     length: number;
// }

// function f<T extends IWithLength>(x: T): void{
//     console.log(x.length);
// }

// f<string>('abc');
// f<number>(1);

// 用接口来定义函数
// interface If{
//     (x: number): void;
//     y: number;
//     f2(): void;
// }

// let f: If = <If>function(x: number):void{
//     console.log(x);
// }
// f.y = 5;
// f.f2 = function(){};

// f(3);

// console.log(f);

// 用带泛型的接口来定义函数
interface createArrayFunc{
    <MyType>(length: number, value: MyType): MyType[];
}

let createArray: createArrayFunc;
// 泛型可以设定缺省值
createArray = function<MyType = string>(length: number, value: MyType): MyType[]{
    let result: MyType[] = [];
    for(let i = 0; i < length; i++){
        result[i] = value;
    }
    return result;
}

createArray(3, 'abc');