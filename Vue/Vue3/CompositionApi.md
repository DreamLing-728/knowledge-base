### 1. 函数
#### （1）ref
ref 可以生成 值类型（即基本数据类型） 的响应式数据。
```js
const count = ref(0)
console.log(count.value) // 0

count.value++
console.log(count.value) // 1
```

#### （2）reactive
对于一个普通对象来说，如果这个普通对象要实现响应式，就用 reactive。
```js
//普通对象
const person = {
	age: 20,
	name: 'leyo'
}
//响应式对象
const person = reactive({
    age: 20,
    name: 'leyo'
})
```
举个例子,在setup函数里，普通对象是不会响应式变化的
```js
<template>
    <p>age: {{ person.age }}, name: {{ person.name }}</p>
</template>

<script>
// import { reactive } from 'vue'

export default {
  name: 'reactive',
  setup () {
    const person = {
      age: 20,
      name: 'leyo'
    }

    setTimeout(() => {
      person.age = 25
    }, 1500)

    return {
      person
    }
  }
}
</script>
```
结果如下：
![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d2dc3591410949a7a9c36727f216e06f~tplv-k3u1fbpfcp-watermark.image)

如果用reactive函数封装成响应式对象，则会动态变化
```js
<template>
    <p>age: {{ person.age }}, name: {{ person.name }}</p>
</template>

<script>
import { reactive } from 'vue'

export default {
  name: 'reactive',
  setup () {
    const person = reactive({
      age: 20,
      name: 'leyo'
    })

    setTimeout(() => {
      person.age = 25
    }, 1500)

    return {
      person
    }
  }
}
</script>

```

#### (3) toRef
在一个响应式对象里面，如果其中有一个属性要拿出来单独做响应式的话，就用 toRef。
```js
<template>
    <p>toRef demo - {{ageRef}} - {{state.name}} {{state.age}}</p>
</template>

<script>
import { toRef, reactive } from 'vue'

export default {
  name: 'ToRef',
  setup () {
    const state = reactive({
      age: 18,
      name: 'monday'
    })

    // // toRef 如果用于普通对象（非响应式对象），产出的结果不具备响应式
    // const state = {
    //     age: 18,
    //     name: 'monday'
    // }

    // 实现某一个属性的数据响应式
    const ageRef = toRef(state, 'age')

    setTimeout(() => {
      state.age = 20
    }, 1500)

    setTimeout(() => {
      ageRef.value = 25 // .value 修改值
    }, 3000)

    return {
      state,
      ageRef
    }
  }
}
</script>
```

#### （4）toRefs
与 toRef 不一样的是， toRefs 是针对整个对象的所有属性，目标在于将响应式对象（ reactive 封装）转换为普通对象，且保持响应性。
当我们把一个对象解构时，解构出来的对象会丢失响应性。
```js
<template>
    <p>age:{{age}}, name:{{name}}</p>
</template>

<script>
import { reactive } from 'vue'

export default {
  name: 'ToRefs',
  setup () {
    const state = reactive({
      age: 20,
      name: 'leyo'
    })

    setTimeout(() => {
      state.age = 25
    }, 1500)

    return {
      ...state
    }
  }
}
</script>
```
所以当需要解构响应对象，且希望解构后的对象也保持响应性是，可以使用toRefs。
```js
<template>
    <p>age:{{age}}, name:{{name}}</p>
</template>

<script>
import { reactive, toRefs } from 'vue'

export default {
  name: 'ToRefs',
  setup () {
    const state = reactive({
      age: 20,
      name: 'leyo'
    })

    const stateRefs = toRefs(state)

    setTimeout(() => {
      state.age = 25
    }, 1500)

    return {
      ...stateRefs
    }
  }
}
</script>
```
