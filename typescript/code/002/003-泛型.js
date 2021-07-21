// 泛型 类：数据类型确定，但是数据值不确定，通过赋值，得到实例
// 泛型 是让类\函数\接口可以配置类型
var f = function (x) {
    console.log(x);
};
f.y = 5;
f.f2 = function () { };
f(3);
console.log(f);
