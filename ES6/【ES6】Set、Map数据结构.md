在ES5里数据结构其实就只有一种：数组，ES6里终于把Set和Map数据结构加上了
## 一、Set
Set可以和ES5里的Array有点像，可以把它理解成一个去重的数组。
### 1.Set成员的唯一性
```
let s = new Set();

s.add(1);
s.add(2);
s.add(2);
console.log(s);		//[1, 2]
```
**应用**
数组去重
```
let s = new Set();
let a = [1, 2, 3, 3, 4, 4];
a.forEach(x => s.add(x));
console.log(s);		// [1, 2, 3, 4]
```

### 2. 从Array -> Set (Set的初始化)
#### 2.1 从数组变成Set
```
let a = [1, 2, 3, 3, 4, 4];
let s = new Set(a)

console.log(s);		// [1, 2, 3, 4]
```
#### 2.2 从类数组变成Set (类数组 -> 数组 -> Set)
之前学过的类数组有：自定义的，NodeList，arguments
```
function f(){
    // return Array.from(arguments);	// 另一种写法
    return [...arguments];
}

let s = new Set(f(1, 2, 3, 3, 4, 4));
console.log(s);		// [1, 2, 3, 4]
```
### 3.从Set -> Array
3.1 扩展表达式
```
var set = new Set([1, 2, 3, 4]);
let a = [...set];
console.log(a);		// [1, 2, 3, 4]		(数组)
```
3.2 Array.from
```
var set = new Set([1, 2, 3, 4]);
let a2 = Array.from(set);
console.log(a2);	// [1, 2, 3, 4]		(数组)
```
**应用**：
数组去重

方法就是把数组变成Set，再变回数组
```
let a = [1, 2, 3, 3, 4, 4];
a = [...new Set(a)];
console.log(a);
```
**Set去重的原理**：
相当于 === （特例： NaN用的是Object.is）

```
let s = new Set();
s.add(-0).add(+0);		//	[0]			（判断相等）
s.add(NaN).add(NaN);	//	[NaN]		（判断相等）
s.add({}).add({});		// [{}, {}]		（对象的地址是不一样的）
let o = {};
s.add(o).add(o);		//[{}]			(判断相等，对象指向的地址是一样的)
console.log(s);
```
### 4. Set实例的属性和方法
add(value), 返回set实例

delete(value), 删除成功，返回true，不成功，返回false

has(value), 是否包含某个值

clear()，清楚所有成员

size: 一共有多少个成员,和数组里的length一样
```
const s = new Set([1, 2, 3]);
console.log(s.delete(3));	// true
console.log(s, s.size);		// [1, 2] 2
console.log(s.delete(4));	// false
console.log(s, s.size);		// [1, 2] 2

console.log(s.has(1));		// true
console.log(s.has(4));		// false

s.clear();
console.log(s, s.size);		// [] 0
```
### 5.Set的遍历：keys(), values(), entries()
Set不区分key和value
```
let s = new Set([1, 2, 3]);

for(let item of s.keys()){
    console.log(item);		// 1 2 3
}
```
values()
```
for(let item of s.values()){
    console.log(item);		// 1 2 3
}
// 可以简写成：
for(let item of s){
    console.log(item);		// 1 2 3
}
```
entries()
```
for(let item of s.entries()){
    console.log(item);		// [1, 1]  [2, 2]  [3, 3]
}
```
**应用：**

需要借助数组的3个方法：

  map(function): 把数组内的元素，全部拿出来给用于function运算，然后生成新的数，形成数组
  
  filter(function): 把数组内的元素，全部拿出来给用于function运算，返回true，该数据进入返回的数组，如果false，就不进。
  示例：
```
  let array = [1, 2, 4, 5];
  // filter的三个参数：element， key， array
  let array2 = array.filter((element, key, array) =>  element > 3);
  console.log(array2);
```
  
  Array.from(set, function, this)
  
**  应用1：** 把set中的数值 * 2

方法1：借助map
```
let s = new Set([1, 2, 3]);
let s2 = new Set([...s].map(x => x * 2));
console.log(s2);
```
方法2：借助Array.from
```
let s = new Set([1, 2, 3]);
let s1 = new Set(Array.from(s, x => x * 2));
console.log(s1);
```

**应用2：**  集合的运算

2.1 生成并集 Union

```
let s1 = new Set([1, 2, 3]);
let s2 = new Set([2, 3, 4]);
let su = new Set([...s1, ...s2]);
console.log(su);	// [1, 2, 3, 4]
```
2.2 生成交集
```
let si = new Set([...s1].filter(x => s2.has(x)));
console.log(si);	// [2, 3]
```
2.3 生成集差

s1的集差
```
let s1 = new Set([1, 2, 3]);
let s2 = new Set([2, 3, 4]);
let diff1_2 = new Set([...s1].filter(x => !s2.has(x)));
console.log(diff1_2);
```
## 二、 Map

ES6的Map和ES5的Object可以对应，都是以key-value 键值对组成
### 1. Map的定义
```
// ES5 的Object
let obj = {};
obj.a = 5;
obj.a = 4;
obj.b = 3;
console.log(obj);		// {a: 4, b: 3}

// ES6 的Map
let m = new Map();
m.set('a', 5);
m.set('a', 4);
m.set('b', 3);
m.set(obj, 7);

console.log(m, m.get('a'), m.get(obj));		// Map(2) {"a" => 4, "b" => 3}  7
```
Map和Object的区别: Object的键必须是字符串，Map中没有这个要求,比如
```
let obj = {};
obj.a = 5;
obj.b = 3;
let m = new Map();
m.set(obj, 7);
console.log(m, m.get(obj));
```
输出如下
![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4cde0603141440d9a2013b49f0e8ab2f~tplv-k3u1fbpfcp-zoom-1.image)

### 2. Map的构造
#### 2.1 嵌套的二维数组来构造Map
```
let array = [
    ['a', 4],
    ['b', 3]
];

let m = new Map(array);
console.log(m);		// Map(2) {"a" => 4, "b" => 3}
```
#### 2.2 嵌套数组的Set来构造Map
```
let array = [
    ['a', 4],
    ['b', 3]
];
let s = new Set(array);
let m2 = new Map(s);

console.log(m2);	// Map(2) {"a" => 4, "b" => 3}
```
### 2.3 key的碰撞（clash）
是基于 === 判断的，但是有三个特例

1：-0 === +0 true

2: NaN使用Object.is;

3: 引用类型要看地址
```
let m = new Map();
m.set(-0, 1);
m.set(+0, 2);
console.log(m);		// Map(1) {0 => 2}

m.set(NaN, 3);
m.set(NaN, 4);
console.log(m);		// Map(2) {0 => 2, NaN => 4}

m.set({}, 5);
m.set({}, 6);
console.log(m);		// Map(4) {0 => 2, NaN => 4, {…} => 5, {…} => 6}

let a = [];
m.set(a, 5);
m.set(a, 6);
console.log(m);		// Map(5) {0 => 2, NaN => 4, {…} => 5, {…} => 6, Array(0) => 6}
```

### 3. Map实例的属性和成员方法
#### 3.1 size
```
let m = new Map([['a', 4], ['b', 5]]);
console.log(m.size);		// 2
```
#### 3.2 set(key, value), get(key)
看前面例子
#### 3.3 has(key)
```
console.log(m.has('a'));	// true
console.log(m.has('c'));	// false
```
#### 3.4 delete(key)
```
let m = new Map([['a', 4], ['b', 5]]);
console.log(m.delete('a'));		// true
console.log(m);					// Map(1) {"b" => 5}
console.log(m.delete('c'));		// false
console.log(m);					// Map(1) {"b" => 5}
```
#### 3.5 clear()
```
m.clear();
console.log(m.size);			// 0
```
### 4. Map实例的遍历
和数组、set、对象一样都有这3个方法：keys(), values(), entries()

keys()
```
let m = new Map([['a', 4], ['b', 5]]);

// 方法1
for(let key of m.keys()){
    console.log(key);		// a b
}

// 方法2
[...m.keys()];		// a b

```
values()
```
let m = new Map([['a', 4], ['b', 5]]);
// 方法1
for(let value of m.values()){
    console.log(value);		// 4 5
}
// 方法2
[...m.values()];		// 4 5
```
entries()
```
let m = new Map([['a', 4], ['b', 5]]);
// 写法1
for(let entry of m.entries()){
    console.log(entry[0], entry[1]);		// a 4, b 5
}
// 写法2
for(let [key, value] of m.entries()){
    console.log(key, value);				// a 4, b 5	
}
// 写法3
for (let [key, value] of m){
    console.log(key, value);
}	
```
forEach()
```
forEach()
m.forEach((value, key, map) => {
    console.log(key, value);	// // a 4, b 5
});
```
### 5. Map 和 Array之间的互相转换
#### 5.1 Map 转化为 Array(嵌套的二维数组)
```
let m = new Map([['a', 4], ['b', 5]]);
let a = [...m.entries];
let a = [...m];		// 简写

console.log(a);			//[['a', 4], ['b', 5]]
```
#### 5.2 Array 转化为 Map
```
let a = [1, 2, 3, 3, 4, 4];
let s = new Set(a)

console.log(s);		// [1, 2, 3, 4]
```
### 6. Map转化为数组，然后遍历
主要用到这3个方法：map、filter、Array.from

map
```
let m = new Map([['a', 4], ['b', 5]]);
let a2 = [...m].map(([key, value]) => [key, value * value]);
let m2 = new Map(a2);
console.log(m2);		// Map(2) {"a" => 16, "b" => 25}
```
filter
```
let m = new Map([['a', 4], ['b', 5]]);
let a2 = [...m].filter(([key, value]) => value > 4);
let m2 = new Map(a2);
console.log(m2);		// Map(1) {"b" => 5}
```
Array.from
```
let m = new Map([['a', 4], ['b', 5]]);
let a2 = Array.from(m, ([key, value]) => [key, value * value]);
let m2 = new Map(a2);
console.log(m2);	// Map(2) {"a" => 16, "b" => 25}
```
### 7. 当Map的key都是字符串的时候，如何实现Object和Map之间的相互转化
#### 7.1 Map 转化为对象
```
let m = new Map([['a', 4], ['b', 5]]);
function map2Obj(map){
    let obj = {};
    for(let [key, value] of map){
        obj[key] = value;
    }
    return obj;
}
let obj = map2Obj(m);	
console.log(obj);		
```
#### 7.2 对象转化为Map
```
 function obj2Map(obj){
    let map = new Map();
    for(let key of Object.keys(obj)){
        map.set(key, obj[key]);
    }

    return map;
}
let m2 = obj2Map(obj);
console.log(m2);
```
## 三、WeakSet, WeakMap
Set,Map大部分的使用都一样
1. WeakSet所有的值必须是引用类型，WeakMap所有key必须是引用类型
2. WeakSet, WeakMap不会影响垃圾收集，所以这两个数据结构不可以遍历
   防止内存泄露
