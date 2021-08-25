// ES5 函数的声明；函数表达式
// function f1(x, y){
//     return x + y;
// }

// let f2 = function(x, y){
//     return x + y;
// }

// 函数的类型：
// 1. 参数设定类型
// 2. 返回值设定类型
// 3. (函数表达式)：函数的类型
// function f1(x: number, y: number): number{
//     return x + y;
// }

// 函数调用，参数的个数不能多也不能少
// 参数的类型也不能错。

// let a1: number = f1(1, 2);
// let a2: number = f1(1, 'abc');

// 类型推定
// 函数的类型
// let f2: (x: number, y: number) => number = function(x: number, y: number): number{
//     return x + y;
// };

// f2 = function(x: number, y: number, z: number): number{
//     return x + y + z;
// }

// 接口形式的函数的类型
// interface If {
//     (x: number, y: number): number;
// }

// let f3: If = function(x: number, y: number): number{
//     return x * y;
// };

// 1. 可选参数
// 一个可选参数后面不能再有确定(必须)参数
// function f4(x: number, y?: number): number {
//     y = y || 0;
//     return x + y;
// }

// let a2: number = f4(1);
// a2 = f4(1, 2);


// 2. 参数的默认值, 一个末尾的参数如果是默认的，他就是可选的
//                 前面的默认参数，需要给undefined
// function f4(x: number = 0, y: number): number {
//     console.log(x, y);
//     return x + y;
// }

// let a2: number = f4(undefined, 1);
// a2 = f4(1, 2);

// 3. 剩余参数
// ES6
// function sum(...args){
//     let sum = 0;
//     for(let i = 0; i < args.length; i++){
//         sum += args[i];
//     }
//     return sum;
// }

// TypeScript
// function sum(...args: number[]): number{
//     let sum: number = 0;
//     for(let i:number = 0; i < args.length; i++){
//         sum += args[i];
//     }
//     return sum;
// }

// console.log(sum(1, 2, 3, 4));
// console.log(sum(1, 'a', 3, 4));

// 4. 函数的重载： 
//    C++里的函数重载：函数可以重名，但是参数个数需不同，或者参数个数相同但是参数类型不同，编译器通过参数的个数和类型来判断到底是调用了哪个参数。
//    TypeScript的函数重载，还是只有一个函数，但是可以对不同的参数组合进行静态类型检查

// 加法：
//  数字+数字
//  矢量+矢量 {x: number, i: number}
//  矢量+数字，数字+矢量， 把它加在x上
interface IVector{
    x: number;
    i: number;
}

function add(a: number, b: number): number;
function add(a: number, b: IVector): IVector;
function add(a: IVector, b: IVector|number): IVector;
function add(a: number|IVector, b: number|IVector): number|IVector{
    let ret: IVector = {
        x: 0,
        i: 0
    };

    if(typeof a === 'number' && typeof b === 'number'){
        return a + b;
    }else{
        if(typeof a !== 'number'){
            if(typeof b === 'number'){
                ret.x = a.x + b;
                ret.i = a.i;
                return ret;
            }else{
                ret.x = a.x + b.x;
                ret.i = a.i + b.i;
                return ret;
            }
        }else{
            ret.x = a + (<IVector>b).x;
            ret.i = (<IVector>b).i;
            return ret;
        }
    }
}

let v1: IVector = {
    x: 3,
    i: 5
}

let v2: IVector = {
    x: 7,
    i: 4
}

console.log(add(1, 2));
console.log(add(v1, 2));
console.log(add(2, v2));
console.log(add(v1, v2));

// 类型断言: 是针对混合类型，为变量指定一个类型
let a: number | string = 'abc';
console.log(a.length);

function f(a: number | string): void{
    console.log((<string>a).length);
}



