// 数组
// 1. 类型+方括号
let array: number[] = [0, 1, 2, 3];
let arrayAny: any[] = [0, 'agc', true];

// array.push('abc');

// 2. 泛型
let array2: Array<number> = [0, 1, 2, 3];

// 3. 接口
interface INumberArray {
    [index: number]: number;
}

let array3: INumberArray = [0, 1, 2, 3];

// 4. 类数组： 内置对象：IArguments, NodeList, HTMLCollection
function f() {
    let args: IArguments = arguments;
    console.log(args);
}