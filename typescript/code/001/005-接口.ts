// 接口：变量赋值
interface IPerson {
    name: string;
    age: number;
}

// 一个变量，在赋值时，如果被声明为是某一种接口的实例，那么它必须有这个接口要求的所有的属性。
// 里氏代换原则
// 一个变量，在赋值时，如果被声明为是某一个接口的实例，俺么它也不应该有多余这个接口所要求的属性。
let p1: IPerson = {
    name: '隔壁王校长',
    age: 25
};

let p2: IPerson = {
    name: 'abc',
    age: 25
    // a: 3
}

// 1. 可选属性：
interface IPerson2{
    name: string;
    age?: number;
}

let p3: IPerson2 = {
    name: 'abc',
    age: 25
}

// 2. 任意属性：
// 如果设定了任意属性，那么所有的确定属性或者可选属性必须是任意属性的子集。
interface IPerson3{
    name: string;
    married?: boolean;
    [propName: string]: number | string | boolean;
}

// 3. 只读属性
// readonly，指的是如果不在每次对象赋值情况下，是不能修改值的。
interface IPerson4{
    readonly name: string;
    age: number
}

let p4: IPerson4 = {
    name: '',
    age: 15
}

p4 = {
    name: 'cdde',
    age: 13
};

// p4.name = 'cde';
p4.age = 14;