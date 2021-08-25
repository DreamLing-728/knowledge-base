// 类型别名
// type Name = string | number;
// type Name2 = () => string;
// type Name3 = Name | Name2;
// function f(n: Name3): void{
//     console.log(n);
// }

// f(1);

// 字符串字面量类型
type ClassName = 'A-Class' | 'B-Class' | 'C-Class';

function f(className: ClassName):void {
    console.log(className);
}

f('A-Class');
// f('隔壁王校长');