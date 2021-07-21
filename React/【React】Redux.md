### 1. 单纯的redux使用
```js
// redux的使用过程

// 1. 引入
import {createStore} from 'redux';

// 2. 创建reducer对象
// state: 代表上一个数据，  action：代表下一个数据
function reducer(state, action) {
    console.log('state+action');
    console.log(state, action);
    // console.log(...state);
    let init = {name: "小小梦", age: 22}

    switch (action.type) {
        // 修改state中的数据
        case 'change-name':
            // 写法1
            state.name = action.value;
            state.age = action.age;
            return state;

            // 写法2
            // return {
            //     ...state,
            //     name: action.value
            // };

        default:
            return init;
    }
}

// 3. 创建store
let store = createStore(reducer);

// 4. 读取store中的state，通过getState
let state = store.getState()
console.log(state);     // {name: "小小梦", age: 22}

// 5. 用dispatch修改store中的state
store.dispatch({
    type: 'change-name',
    value: '大大梦',
    age: 25
});

state = store.getState()
console.log(state);
```

### 2.订阅
把上面的代码改一下，console.log 3 处输出什么？
```js
// 1. 引入
import {createStore} from 'redux';

// 2. 创建reducer对象
// state: 代表上一个数据，  action：代表下一个数据
function reducer(state, action) {
    console.log('state+action');
    console.log(state, action);
    // console.log(...state);
    let init = {name: "小小梦", age: 22}

    switch (action.type) {
        // 修改state中的数据
        case 'change-name':
            // 写法1
            state.name = action.value;
            return state;

            // 写法2
            // return {
            //     ...state,
            //     name: action.value
            // };
        case 'add-age':
            return{
                ...state,
                age: state.age + action.value
            }
        default:
            return init;
    }
}

// 3. 创建store
let store = createStore(reducer);

// 4. 读取store中的state，通过getState
let state = store.getState()
console.log(1)
console.log(state);     // {name: "小小梦", age: 22}

// 5. 用dispatch修改store中的state
store.dispatch({
    type: 'change-name',
    value: '大大梦'
});
console.log(2)
console.log(state);

// 猜这里输出什么？
state = store.getState()
console.log(3)
console.log(state);

store.dispatch({
    type: 'add-age',
    value: 5
})

```
答：输出的是，{name: "大大梦", age: 22}

可以再console.log 3 处改定订阅模式，其实这个的订阅就相当于是一个异步执行，等state全部修改完成了再轮到它执行，代码如下：
```js
// 1. 引入
import {createStore} from 'redux';

// 2. 创建reducer对象
// state: 代表上一个数据，  action：代表下一个数据
function reducer(state, action) {
    console.log('state+action');
    console.log(state, action);
    // console.log(...state);
    let init = {name: "小小梦", age: 22}

    switch (action.type) {
        // 修改state中的数据
        case 'change-name':
            // 写法1
            state.name = action.value;
            return state;

            // 写法2
            // return {
            //     ...state,
            //     name: action.value
            // };
        case 'add-age':
            return{
                ...state,
                age: state.age + action.value
            }
        default:
            return init;
    }
}

// 3. 创建store
let store = createStore(reducer);

// 4. 读取store中的state，通过getState
let state = store.getState()
console.log(1)
console.log(state);     // {name: "小小梦", age: 22}

// 5. 用dispatch修改store中的state
store.dispatch({
    type: 'change-name',
    value: '大大梦'
});
console.log(2)
console.log(state);


// state = store.getState()
// console.log(3)
// console.log(state);

// 修改成
store.subscribe(() => {
    console.log('subscription is trigger');
    console.log(store.getState());		// age 是 27
    }
)

store.dispatch({
    type: 'add-age',
    value: 5
})
```
### 3. 在react中使用redux
