### 1. 函数
#### （1）ref
ref 可以生成 值类型（即基本数据类型） 的响应式数据。
```js
// 普通基本数据类型
const count = 0

// 响应式基本数据类型
const count = ref(0)
console.log(count) // {value: 0}
```

举个例子,在setup函数里，普通基本数据类型是不会响应式变化的
```js
<template>
    <p>age: {{ count }}</p>
</template>

<script>
export default {
  name: 'ref',
  setup () {
    let count = 0
    setTimeout(() => {
      count++
    }, 1500)
    return {
      count
    }
  }
}

// 结果：
// age: 0
</script>
```
如果用ref函数封装成响应式对象，则会动态变化
```js
<template>
    <p>count: {{ count }}</p>
    <p>deep.count: {{ deep.count.value }}</p>
</template>

<script>
import { ref } from 'vue'
export default {
  name: 'ref',
  setup () {
    const count = ref(0)
    setTimeout(() => {
      count.value++
    }, 1500)
    return {
      count,
      deep: {
        count
      }
    }
  }
}
// 结果：
// age: 0
// age：1
</script>
```

```Ref解包```
上面例子的count，ref在setup函数里被访问时，需要加.value，但是在setup()中返回后，它将自动浅层次解包内部值，在模板里使用时可以直接访问。但如果是深层次的，还是需要加.value。




#### （2）reactive
对于一个普通对象来说，如果这个普通对象要实现响应式，就用 reactive。
```js
// 普通对象
const person = {
	age: 20,
	name: 'leyo'
}
// 响应式对象
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
// 结果
// age: 20, name: leyo
</script>
```

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
// 结果
// age: 20, name: leyo
// age: 25, name: leyo
</script>

```

#### （3）toRef
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
结果：

![20210826_111317.gif](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8ac807e5db9a4fa3b265ca22abeb02cd~tplv-k3u1fbpfcp-watermark.image)

官方文档：如果 title 是可选的 prop，则传入的 props 中可能没有 title 。在这种情况下，toRefs 将不会为 title 创建一个 ref 。你需要使用 toRef 替代它：

举个例子，也没能理解
```js
<template>
    <p>name: {{age}}, age: {{name}}</p>

</template>

<script>
import { toRefs, reactive } from 'vue'

export default {
  name: 'ToRef',
  props: {
    age: {
      type: Number,
      default: 18,
      required: true
    },
    name: {
      type: String,
      default: 'leyo'
    }
  },
  setup (props) {
    const propsReactive = reactive(props)
    const propsRef = toRefs(propsReactive)
    return {
      ...propsRef
    }
  }
}
// 结果
// name: 18, age: leyo
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
// 结果
// age:20, name:leyo
// age:25, name:leyo
</script>
```

#### （5）watch

三个参数：

1. 一个想要侦听的响应式引用或 getter 函数

2. 一个回调

3. 可选的配置选项

```js
<template>
    <p>count: {{ count }}</p>
    <p>countWatch: {{ countWatch }}</p>
</template>

<script>
import { ref, watch } from 'vue'
export default {
  name: 'ref',
  setup () {
    const count = ref(0)
    const countWatch = ref(0)
    watch(
      // getter 函数
      () => ++count.value,
      (newValue) => {
        console.log('newValue', newValue)
        countWatch.value = newValue
      },
      {
        immediate: true
      }
    )
    return {
      count,
      countWatch
    }
  }
}
// 结果：
// count: 1  countWatch: 1
</script>
```

```js
<template>
    <p>count: {{ count }}</p>
    <p>countWatch: {{ countWatch }}</p>
</template>

<script>
import { ref, watch } from 'vue'
export default {
  name: 'ref',
  setup () {
    const count = ref(0)
    const countWatch = ref(0)
    watch(
      // 一个想要侦听的响应式引用
      count,
      (newValue) => {
        countWatch.value = ++newValue
      },
      {
        immediate: true
      }
    )
    return {
      count,
      countWatch
    }
  }
}
// 结果：
// count: 0  countWatch: 1
</script>
```
```
特点：
1. 具有一定的惰性lazy,第一次页面展示的时候不会执行，只有数据变化的时候才会执行
2. 参数可以拿到当前值和原始值
3. 可以侦听多个数据的变化，用一个侦听起承载
```

#### （6）watchEffect
```
1. 立即执行，没有惰性，页面的首次加载就会执行
2. 不需要传递要侦听的内容 会自动感知代码依赖，不需要传递很多参数，只要传递一个回调函数
3. 不能获取之前数据的值 只能获取当前值
```

```js
<template>
    <p>count: {{ count }}</p>
    <p>countWatch: {{ countWatch }}</p>
</template>

<script>
import { ref, watchEffect } from 'vue'
export default {
  name: 'ref',
  setup () {
    const count = ref(0)
    const countWatch = ref(0)
    watchEffect(
      () => {
        countWatch.value = ++count.value
      }
    )
    return {
      count,
      countWatch
    }
  }
}
// 结果：
// count: 1  countWatch: 1
</script>
```

#### （7）computed
返回一个不可变的响应式 ref 对象。
```js
<template>
    <p>count: {{ count }}</p>
    <p>countWatch: {{ countWatch }}</p>
</template>

<script>
import { computed, ref } from 'vue'
export default {
  name: 'computed',
  setup () {
    const count = ref(0)
    const countWatch = computed(
      () => count.value + 1
    )
    return {
      count,
      countWatch
    }
  }
}
// 结果：
// count: 1  countWatch: 1
</script>
```

如果希望对象是可写的，则需要用 get 和 set 函数创建
```js
<template>
    <p>count: {{ count }}</p>
    <p>countWatch: {{ countWatch }}</p>
</template>

<script>
import { computed, ref } from 'vue'
export default {
  name: 'computed',
  setup () {
    const count = ref(0)
    const countWatch = computed({
      get: () => count.value + 1,
      set: (val) => {
        count.value = val - 1
      }
    })
    setTimeout(() => {
      countWatch.value = 20
    }, 2000)
    return {
      count,
      countWatch
    }
  }
}
// 结果：
// count: 0  countWatch: 1
// count: 19  countWatch: 20
</script>
```

#### （8）readonly
接受一个对象 (响应式或纯对象) 或 ref 并返回原始对象的只读代理。只读代理是深层的：任何被访问的嵌套 property 也是只读的。
```js
<template>
    <p>count: {{ count }}</p>
    <p>countReadonly: {{ countReadonly }}</p>
</template>

<script>
import { readonly, ref } from 'vue'
export default {
  name: 'readonly',
  setup () {
    const count = ref(0)
    const countReadonly = readonly(count)
    setTimeout(() => {
      count.value = 20
    }, 2000)
    return {
      count,
      countReadonly
    }
  }
}
// 结果：
// count: 0  countWatch: 0
// count: 20  countWatch: 20
</script>
```

```js
<template>
    <p>count: {{ count }}</p>
    <p>countReadonly: {{ countReadonly }}</p>
</template>

<script>
import { readonly, ref } from 'vue'
export default {
  name: 'readonly',
  setup () {
    const count = ref(0)
    const countReadonly = readonly(count)
    setTimeout(() => {
      countReadonly.value = 30 // 报错Set operation on key "value" failed: target is readonly
    }, 2000)
    return {
      count,
      countReadonly
    }
  }
}
// 结果：
// count: 0  countWatch: 0
</script>
```

#### （9）provider和inject
provide和inject可以实现嵌套组件之间进行传递数据。
这两个函数都是在setup函数中使用的。
父级组件使用provide向下进行传递数据。
子级组件使用inject来获取上级组件传递过来的数据。

举个例子
```js
// 父组件
<template>
  <Son/>
</template>

<script>
import { provide, reactive } from 'vue'
import Son from './composables/provide-inject/Son.vue'

export default {
  name: 'provide/inject',
  components: { Son },
  setup () {
    const leyoData = reactive({
      name: 'leyo',
      age: 18
    })
    setTimeout(() => {
      leyoData.age = 20
    }, 1500)
    provide('leyoData', leyoData)
  }
}
</script>

```

```js
// 子组件
<template>
    <p>儿子: {{ leyoData }}</p>
    <GrandSon/>
</template>

<script>
import { inject } from 'vue'
import GrandSon from './GrandSon.vue'
export default {
  name: 'provide/inject',
  components: { GrandSon },
  setup () {
    const leyoData = inject('leyoData')
    return {
      leyoData
    }
  }
}
</script>

```

```js
// 孙子组件
<template>
    <p>孙子: {{ leyoData }}</p>
</template>

<script>
import { inject } from 'vue'
export default {
  name: 'provide/inject',
  setup () {
    const leyoData = inject('leyoData')
    return {
      leyoData
    }
  }
}
</script>

```
结果：
![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/fbe3f166a2a34287babf36b78ee8381e~tplv-k3u1fbpfcp-watermark.image)

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1dc3f4df124049a6b09c998694711ffb~tplv-k3u1fbpfcp-watermark.image)



demo链接：http://remote.ysbang.cn:9099/chengmengling/composition-api-demo
