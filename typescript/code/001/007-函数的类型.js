// ES5 函数的声明；函数表达式
// function f1(x, y){
//     return x + y;
// }
function add(a, b) {
    var ret = {
        x: 0,
        i: 0
    };
    if (typeof a === 'number' && typeof b === 'number') {
        return a + b;
    }
    else {
        if (typeof a !== 'number') {
            if (typeof b === 'number') {
                ret.x = a.x + b;
                ret.i = a.i;
                return ret;
            }
            else {
                ret.x = a.x + b.x;
                ret.i = a.i + b.i;
                return ret;
            }
        }
        else {
            ret.x = a + b.x;
            ret.i = b.i;
            return ret;
        }
    }
}
var v1 = {
    x: 3,
    i: 5
};
var v2 = {
    x: 7,
    i: 4
};
console.log(add(1, 2));
console.log(add(v1, 2));
console.log(add(2, v2));
console.log(add(v1, v2));
