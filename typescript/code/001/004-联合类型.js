// 联合类型
function f() {
    return Math.random() > 0.5 ? 1 : 'abc';
}
var n12;
n12 = '隔壁王校长';
console.log(n12.length);
n12 = f();
console.log(n12.length);
