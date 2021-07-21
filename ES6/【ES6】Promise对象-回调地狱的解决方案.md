## 一、回调地狱
在引出promise对象之前，我们先看另一个东西：回调地狱。回调地狱指的是函数作为参数层层嵌套，从而一个函数作为参数需要依赖另一个函数执行调用，比如：
```
function riskyMethod1(succeedHandler, failedHandler){
    let r = Math.random();

    if(r < 0.7){
        setTimeout(succeedHandler, 30);
    }else{
        setTimeout(failedHandler, 30);
    }
}

function riskyMethod2(succeedHandler, failedHandler){
    let r = Math.random();

    if(r < 0.7){
        setTimeout(succeedHandler, 30);
    }else{
        setTimeout(failedHandler, 30);
    }
}

function riskyMethod3(succeedHandler, failedHandler){
    let r = Math.random();

    if(r < 0.7){
        setTimeout(succeedHandler, 30);
    }else{
        setTimeout(failedHandler, 30);
    }
}

// 2/3的执行需要依赖1的回调，函数1的参数一层层嵌套，看起来很庞大，代码的可读性差
riskyMethod1(() => {
    console.log('Succeed at 1');
    riskyMethod2(() => {
        console.log('Succeed at 2');
        riskyMethod3(() => {
            console.log('Succeed at 3');
        }, () => {
            console.log('Faile at 3');
        });
    }, () => {
        console.log('Failed at 2');
    });
}, () => {
    console.log('Failed at 1');
});
```
解决回调地狱的其中一种方法就是promise对象。
## 二、Promise对象
### 1.Promise对象对回调地狱的优化演示

```
// resolve、reject参数是固定的，不能改成其他名字
let riskyMethod = (resolve, reject) => {
    let r = Math.random();
    if(r < 0.7){
        resolve();
    }else{
        reject();
    }
}

let p = new Promise(riskyMethod);

// resolve对应then的第一个参数、reject对应then里的第二个参数
p.then(() => {
    console.log('Succeed at 1');
    return new Promise(riskyMethod);
}, () => {
    throw new Error('Faile at 1');
}).then(() => {
    console.log('Succeed at 2');
    return new Promise(riskyMethod);
}, () => {
    throw new Error('Failed at 2');
}).then(() => {
    console.log('Succeed at 3');
}, () => {
    throw new Error('Failed at 3');
}).catch(err => console.log(err));
```
调用promise的对象之后，参数就不会层层嵌套了，代码的可读性也好很多。
### 2.Promise的基本用法
Promise对象是一个构造函数，它的参数是一个函数，函数需要有两个参数resolve和reject，这两个参数其实也是函数，所以名字不能更改
```
let p = new Promise((resolve, reject) => {
    let r = Math.random();
    if(r < 0.5){
        setTimeout(resolve, 30);
    }else{
        setTimeout(reject, 30);
    }
});
```
Promise对象代表一个一步操作，有3中状态，Pending（进行中），Fulfilled（已成功），Rejected（已失败），一旦状态改变就不会再变。

       如果调用resolve函数，状态将由pending变为Fulfilled
       如果调用reject函数，状态将由pending变为Rejected

上面的p实例生成之后，可以调用then方法，then的作用是为promise设定回调函数,onFulfilled, onRejected
```
p.then(() => console.log('fulfilled!'), () => console.log('rejected!'));
```
### 3.resolve/reject详细介绍
resolve/reject既可以是同步的也，也可以是异步的，（阻塞的还是非阻塞的）
同步/异步：是在当前执行，还是稍后执行；阻塞/非阻塞：是否等执行的结果出来以后再执行下一句
#### 3.1 同步/异步下的resolve/reject
**同步阻塞**
```
let p = new Promise((resolve, reject) => {
    let r = Math.random();
    if(r < 0.5){
        console.log(1.1);
        resolve();
    }else{
        console.log(1.2)
        reject();
    }
});
console.log(2);
p.then(() => console.log('fulfilled!'), () => console.log('rejected!'));
```
输出：1.1 =》 2 =》 fulfilled（或 1.2 =》 2 =》 rejected）

**异步非阻塞**
```
let p = new Promise((resolve, reject) => {
    let r = Math.random();
    if(r < 0.5){
        setTimeout(() => {
            console.log(1.1);
            resolve();
        }, 1000);
    }else{
        setTimeout(() => {
            console.log(1.2)
            reject();
        }, 1000);
    }
});
console.log(2);
p.then(() => console.log('fulfilled!'), () => console.log('rejected!'));
```
输出：2 =》 1.1 =》 fulfilled （或 2 =》 1.2 =》 rejected）
#### 3.2 resolve/reject可以向onFulfilled, onRejected 发送参数
```
let p = new Promise((resolve, reject) => {
    let r = Math.random();
    if(r < 0.5){
        setTimeout(() => {
            console.log(1.1);
            resolve('String for resolve!');		// 发送的参数
            console.log(p);
        }, 1000);
    }else{
        setTimeout(() => {
            console.log(1.2)
            reject('String for reject!');		// 发送的参数
            console.log(p);
        }, 1000);
    }
});
console.log(2,p);

p.then((value) => {
    console.log('fulfilled!', value);
}, (reason) => {
    console.log('rejected!', reason);
});
```
输出结果：
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8ca1c330063a427084bc1a8b3a04a732~tplv-k3u1fbpfcp-zoom-1.image)
### 3.3 resolve 不同的参数
1. 如果调用resolve给入的参数是原始类型或者是非Promise的对象，Promise对象的状态同步阻塞的就变成fulFilled
2. 如果调用resolve给入的参数是Promise的对象，那么，当前的Promise对象会一直保持pending状态，直到给入的参数Promise对象状态发生变化，此时原Promise对象状态发生同样的变化，并且拿到参数Promise对象的数据（与参数Promise对象的状态一致）

```
var p0 = new Promise((resolve, reject) => {
    setTimeout(() => {
        console.log('p0: 1');		//4:	p0: 1
        // resolve('String for resolve in p0!');
        reject('Season for reject in p0!')
        console.log('p0:', p0);		//5:	p0: p0（reject: Season for reject in p0!）
        console.log('p1:', p1);		//6:	p1: p1（pending）
    }, 3000);
});

var p1 = new Promise((resolve, reject) => {
    setTimeout(() => {
        console.log('p1: 1');		//2: 	p1: 1
        resolve(p0);
        console.log(p1);			//3: 	p1（pending）
    }, 1000);
});

console.log(2, p0, p1);		// 1: 	2 p0（pending） p1（pending）
p1.then((value) => {
    console.log('fulfilled!', value, p0, p1, p0 === p);
}, (reason) => {
    console.log('rejected!', reason, p0, p1, p0 === p);			//7:	此时p1才变成reject
});
```
输出
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/191f7c6b61a7404fa725eefccf3ea807~tplv-k3u1fbpfcp-zoom-1.image)
输出的第6步的时候p1的状态仍然是pending，到第7步才随着p0的改变而改变。
### 4. then()的返回值问题

then的返回值其实是一个Promise对象，和resolve参数中的Promise，或者onFulFilled，onRejected返回的Promise对象不一样，我们暂且叫做“then返回的Promise对象”。
#### 4.1 情况1：
onFulFilled被调用，返回了非Promise对象（有可能有返回值，也可能没有返回值），then返回Promise对象: 状态变为fulFilled，onFulFilled返回值会传递给then返回Promise对象。

**onFulFilled被调用没有返回值的情况**
```
var p = new Promise((resolve, reject) => {
    setTimeout(() => {
        console.log('p:1');			// 2:
        resolve('string for resolve in p');
        console.log('p:', p);		// 3:	p(fulfilled)
    }, 1000);
});

var p3 = p.then((value) => {
    console.log('fulfilled!', value, p, p3);	// 4:	p(fulfilled) p3(pending)
    // 注意这里：没有返回值
});
console.log('p3: 1', p3);		// 1: 	p3(pending)

setTimeout(() => {
	// 注意这里的输出
    console.log('p3: 2', p3);		// 5:	p3(fulfilled:undefined)
}, 3000);
```
**onFulFilled被调用有返回值的情况**

主要是第五步的输出不一样
```
var p = new Promise((resolve, reject) => {
    setTimeout(() => {
        console.log('p:1');			// 2:
        resolve('string for resolve in p');
        console.log('p:', p);		// 3:	p(fulfilled)
    }, 1000);
});

var p3 = p.then((value) => {
    console.log('fulfilled!', value, p, p3);	// 4:	p(fulfilled) p3(pending)
    // 注意这里，有返回值
    return '小梦玲真美！';
});
console.log('p3: 1', p3);		// 1: 	p3(pending)

setTimeout(() => {
	// 注意这里的输出
    console.log('p3: 2', p3);		// 5:	p3(fulfilled: “小梦玲真美！”)
}, 3000);
```

#### 4.2 情况2

onFulFilled被调用，返回了onFulFilled Promise对象，then返回Promise对象: 状态变为fulFilled，会传递onFulFilled Promise对象中的数据给then返回Promise对象。
```
var p = new Promise((resolve, reject) => {
    setTimeout(() => {
        console.log('p:1');			// 2:
        resolve('string for resolve in p');
        console.log('p:', p);		// 3:	p(fulfilled)
    }, 1000);
});

var p3 = p.then((value) => {
    console.log('fulfilled!', value, p, p3);	// 4:	p(fulfilled) p3(pending)
    // 注意这里，返回值是Promise对象
    return p;
});
console.log('p3: 1', p3);		// 1: 	p3(pending)

setTimeout(() => {
	// 注意这里的输出： p里的数据直接给到了p3
    console.log('p3: 2', p3);		// 5:	p3(fulfilled: ‘string for resolve in p’)
}, 3000);
```
#### 4.3 情况3
没设定onFulFilled，then返回Promise对象: 状态和p的状态保持一致，会传递p的数据给then返回Promise对象。
```
var p = new Promise((resolve, reject) => {
    setTimeout(() => {
        console.log('p:1');		// 2:
        // resolve('string for resolve in p');
        reject('string for reject in p');
        console.log('p:', p);		// 3:
    }, 1000);
});

// 注意这里：then没有参数
var p3 = p.then();
console.log('p3: 1', p3);		// 1:

setTimeout(() => {
    console.log('p3: 2', p3);		// 4: p3(rejected: 'string for reject in p')
}, 3000);
```
### 5. then() 的链式调用
```
let riskyMethod = (resolve, reject) => {
    let r = Math.random();
    if(r < 0.7){
        resolve();
    }else{
        reject('Failed');
    }
}

let p = new Promise(riskyMethod); // 1

// 1.fulfilled: p3得到2的状态
// 1.rejected: p3得到1状态的reject
var p3 = p.then(() => {
    console.log('Succeed at 1');
    return new Promise(riskyMethod); // 2
});

// 2.fulfilled: p4得到3的状态
// 2.rejected: p4得到2状态的reject
// 1.rejected: p4得到1状态的reject
var p4 = p3.then(() => {
    console.log('Succeed at 2');
    return new Promise(riskyMethod); // 3
});

// 3.fulfilled: p5得到3的resolve
// 3.rejected: p5得到3状态的reject
// 2.rejected: p5得到2状态的reject
// 1.rejected: p5得到1状态的reject
var p5 = p4.then(() => {
    console.log('Succeed at 3');
});

p5.catch(err => console.log(err));
```
上面then()里的第二个参数可以省略，最后链式调用的代码可以整合如下：
```
let riskyMethod = (resolve, reject) => {
    let r = Math.random();
    if(r < 0.7){
        resolve();
    }else{
        reject('Failed');
    }
}

let p = new Promise(riskyMethod); 

p.then(() => {
	console.log('Succeed at 1');
    return new Promise(riskyMethod);
}).then(() => {
	console.log('Succeed at 2');
    return new Promise(riskyMethod);
}).then(() => {
	console.log('Succeed at 3');
    return new Promise(riskyMethod);
}).then(() => {
	console.log('Succeed at 4');
    return new Promise(riskyMethod);
}).then(() => {
	console.log('Succeed at 5');
    return new Promise(riskyMethod);
}).catch(err => console.log(err));
```
### 6. reject的三种方法：
catch(onRejected) 等价于 then(null, onRejected)

best practice：then只设定onFulFilled，在最后catch onRejected
#### 6.1 方法1
```
let riskyMethod = (resolve, reject) => {
    reject('Failed');
}
var p = new Promise(riskyMethod);
p.catch(err => {
    console.log(err);
    return err;
});
```
#### 6.2 方法2
```
let riskyMethod = (resolve, reject) => {
    try {
        throw new Error('Failed');
    }catch(e){
        reject(e);
    }
}
var p = new Promise(riskyMethod);
p.catch(err => {
    console.log(err);
    return err;
});
```
#### 6.3 方法3
```
let riskyMethod = (resolve, reject) => {
    reject(new Error('Failed'));
}
var p = new Promise(riskyMethod);
p.catch(err => {
    console.log(err);
    return err;
});
```


### 7. Promise.all([p1, p2, p3 ...])
-    返回值是一个新的promise对象
-    情况1， 没有任何一个px是Rejected状态，有px是pending状态：pending
-    情况2， 所有的px都已经FulFilled： FulFilled
-    情况3， 存在状态是Reject的px: Rejected
```js
function  doActionWithPromise(i) {
    return new Promise((resolve, reject) => {
        if(Math.random() < 0.7){
            resolve(`${i}:成功`);
        }else{
            reject(`${i}:失败`);
        }

    })
}

let p1 = doActionWithPromise(1);
let p2 = doActionWithPromise(2);

let p = Promise.all([p1, p2]);
p.then(() =>{
    console.log('All Fulfilled');
}).catch(() => {
    console.log('reject');
})
```
### 8.promise.race([p1, p2])
-    返回值是一个新的Promise对象
-    第一返回的px的状态，并且可以获得这个px的数据。
```
    function  doActionWithPromise(i) {
        return new Promise((resolve, reject) => {
            if(Math.random() < 0.7){
                resolve(`${i}:成功`);
            }else{
                reject(`${i}:失败`);
            }

        })
    }

    let p1 = doActionWithPromise(1);
    let p2 = doActionWithPromise(2);

    console.log(p1);
    console.log(p2);

    let p = Promise.race([p2, p1]);
    p.then(data =>{
        console.log(data);     
    }).catch(reason => {
        console.log(reason);
    })
```

![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/76b257b23afd4667b957945cefc76322~tplv-k3u1fbpfcp-zoom-1.image)

### 9.Promise.resolve()
#### 9.1 Promise.resolve(原始类型)
返回值，一个新的Promise对象，fulFilled, 原始类型作为data返回
```js
let p = Promise.resolve('hello');
p.then(data => console.log(data));		// hello

// 等价于下面这种写法
let p1 = new Promise(resolve => {
    resolve('hello');
});
p1.then(data => console.log(data));		// hello
```
#### 9.2 Promise.resolve(promise对象)
返回值：就是传入的Promise对象
```js
let p = new Promise(resolve => {
    resolve('hello');
});

let p1 = Promise.resolve(p);
console.log(p1 === p);		// true
```
#### 9.3 Promise.resolve(thenable对象)
-  thenable 对象，有一个then函数，其实是executor
-  返回值：使用then函数作为executor，初始化一个新的Promise对象
-  data是then初始化时候的值
```js
let thenable = {
    then(resolve, reject){
        reject('hello');
    }
}

let p = Promise.resolve(thenable);
p.then(data => console.log(data), reason => console.log(reason));
```
输出：data的值是undefined，reason的值是hello
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c58a03595fa14c24bdf15459acefbef9~tplv-k3u1fbpfcp-zoom-1.image)
#### 9.4 Promise.resolve(非thenable对象)
返回值，一个新的Promise对象，fulFilled, 非thenable对象作为data返回
```js
let notThenable = {
    notThen(resolve, reject){
        resolve('hello');
    }
}

let p = Promise.resolve(notThenable);
p.then(data => console.log(data));
```
输出的是对象
![](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/714dc30e17a144668d8ebba1c9fbda70~tplv-k3u1fbpfcp-zoom-1.image)
    
### 10.Promise.reject()
返回值，一个新的Promise对象，rejected, 数据返回
```js
let p = Promise.reject('hello');
p.catch(reason => {
    console.log(reason, p);
});
```


## 三、async和wait
**async 修饰函数定义：**
-     1. 函数会天然返回一个Promise对象，如果不是，用Promise.resolve加工
-     2. 一旦一个函数用async，那么调用它的方式是异步的。
-     3. 返回的Promise对象，在函数执行完是fulFilled，如果任意一个await reject，那么整个函数reject。

**await 在函数调用前**
-     1. 被调用函数应当返回一个Promise对象
-     2. 在函数内部，await会阻塞函数的执行，直到Promise状态发生变化



