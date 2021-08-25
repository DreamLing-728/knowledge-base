// 枚举
// enum Gender {Male, Female};
// console.log(Gender);
// 字符串 <-> 数值
// 缺省，从0开始排序，依次加1
// 可以给某个枚举值设定数值，其后的枚举值自动加1
// 注意，自加的枚举数值，不保证和已经设定的数值不重合
// 所设定的数值，可以是整数，也可以是小数，不影响加1
// 所设定的数值可以不是number，可以是字符串。
var Days;
(function (Days) {
    Days[Days["Sun"] = 1.5] = "Sun";
    Days[Days["Mon"] = 2.5] = "Mon";
    Days[Days["Tue"] = 3.5] = "Tue";
    Days[Days["Wed"] = 4.5] = "Wed";
    Days[Days["Thu"] = 5.5] = "Thu";
    Days[Days["Fri"] = 6.5] = "Fri";
    Days[Days["Sat"] = 7.5] = "Sat";
})(Days || (Days = {}));
;
console.log(Days);
;
// console.log(Gender);
console.log(0 /* Male */, 1 /* Female */);
var gender = [0 /* Male */, 1 /* Female */];
console.log(gender);
