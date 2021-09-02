### compositionApi和optionApi区别
Vue2: optionApi

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9690a034f10343cd92225af454eb44fb~tplv-k3u1fbpfcp-watermark.image)

Vue3: compositionApi

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/5b4f7af4102942d5af33ffb522029b11~tplv-k3u1fbpfcp-watermark.image)

## 1.setup函数
### 1.1 生命周期
+ 1. 执行顺序在 beforeCreate 和 created这两个钩子函数之前，是最早执行的，在程序运行中，setup函数只执行一次，创建的是data和method
+ 2. 在 setup中没有this
+ 3. ```变化的：```
  + beforeDestory/ destoryed 改名 beforeUnmount / unmounted
  + setup替代了beforeCreate/ created
  + beforeCreate/ created/ beforeMount/ mounted / beforeUpdate / updated 写在setup()里，并且加前缀on

+ 4. ```注意：```beforeCreate/ created/ beforeMount/ mounted / beforeUpdate / updated继续使用也不会报错，但是不能继续使用beforeDestory/ destoryed

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/af4fd2078a1d48cda9ec04487506c9d9~tplv-k3u1fbpfcp-watermark.image)

### 1.2 setup的参数：```props、context```
#### （1）props
props是响应式的，当传入新的 prop 时，它将被更新。因为 props 是响应式的，不能使用 ES6 解构，它会消除 prop 的响应性。如果需要解构 prop，可以在 setup 函数中使用 toRefs 函数。

父组件
```typescript
<template>
    <el-input v-model="name"/>
    <Son :name="name"/>
</template>

<script>
import { ref } from 'vue'
import Son from './son.vue'

export default {
  name: 'props',
  components: { Son },
  setup () {
    const name = ref('leyo')
    return {
      name
    }
  }
}

</script>
```

子组件
```typescript
<template>
    <p>name: {{nameRef}}</p>

</template>

<script>
import { ref, toRefs, watch } from 'vue'

export default {
  name: 'ToRefSon',
  props: {
    name: {
      type: String,
      default: ''
    }
  },
  setup (props) {
    // const { name } = props.name // 报错： will cause the value to lose reactivity
    const { name } = toRefs(props)
    const nameRef = ref('')
    watch(
      name,
      (name) => {
        nameRef.value = name + 'new'
      },
      {
        immediate: true
      }
    )
    return {
      nameRef
    }
  }
}

</script>
```

结果

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/66a55c71ab4c4915805e38e67e07a7ee~tplv-k3u1fbpfcp-watermark.image)


#### （2）context
传递给 setup 函数的第二个参数是 context。context 是一个普通的 JavaScript 对象，有三个property
```typescript
export default {
  setup(props, context) {
    // Attribute (非响应式对象)
    console.log(context.attrs)

    // 插槽 (非响应式对象)
    console.log(context.slots)

    // 触发事件 (方法)
    console.log(context.emit)
  }
}
```
context是普通对象，不是响应式的，可以在传参的时候直接解构。
```typescript
export default {
  setup(props, { attrs, slots, emit }) {
    ...
  }
}
```
 1. attrs: 接收在父组件传递过来的，并且没有在props中声明的参数。

 2. emit：子组件对父组件发送事件，在vue2中，子对父发送事件采用this.$emit对父组件发送事件，在vue3中子组件对父组件发送事件采用context.emit发送事件。

 3. slots：和vue2中的插槽使用类似

 举个例子：
 ```typescript
// 父组件
<template>
    <el-input v-model="name"/>
    <Son :name="name" :age="age" @pMsg="getMsg"/>
</template>

<script>
import { ref } from 'vue'
import Son from './son.vue'

export default {
  name: 'props',
  components: { Son },
  setup () {
    const name = ref('leyo')
    const age = ref(18)
    const getMsg = (value) => {
      console.log('接收子组件信息', value)
    }
    return {
      name,
      age,
      getMsg
    }
  }
}

</script>
 ```

 ```typescript
// 子组件
<template>
    <p>name: {{name}}, age: {{age}}</p>
    <el-button @click="postMsg">子组件发送事件</el-button>
</template>

<script>
import { ref, toRefs } from 'vue'

export default {
  name: 'ToRefSon',
  emits: ['pMsg'], // 处理控制台报错
  props: {
    name: {
      type: String,
      default: ''
    }
  },
  setup (props, { attrs, emit, slot }) {
    const { name } = toRefs(props)
    const age = ref(attrs.age)
    console.log('name, age', name, age)
    console.log('attrs,emit,slot', attrs, emit, slot)
    const postMsg = () => {
      emit('pMsg', '发送事件')
    }
    return {
      age,
      postMsg
    }
  }
}

</script>
 ```


## 2. setup里的函数
#### （1）ref
ref 可以生成 值类型（即基本数据类型） 的响应式数据。
```typescript
// 普通基本数据类型
const count = 0

// 响应式基本数据类型
const count = ref(0)
console.log(count) // {value: 0}
```

举个例子,在setup函数里，普通基本数据类型是不会响应式变化的
```typescript
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
```typescript
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
// count: 0  deep.count: 0
// count: 1  deep.count: 1
</script>
```

```Ref解包```
上面例子的count，ref在setup函数里被访问时，需要加.value，但是在setup()中返回后，它将自动浅层次解包内部值，在模板里使用时可以直接访问。但如果是深层次的，还是需要加.value。


#### （2）reactive
对于一个普通对象来说，如果这个普通对象要实现响应式，就用 reactive。
```typescript
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
```typescript
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
```typescript
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
#### （3）toRefs
与 toRef 不一样的是， toRefs 是针对整个对象的所有属性，目标在于将响应式对象（ reactive 封装）转换为普通对象，且保持响应性。

当我们把一个对象解构时，解构出来的对象会丢失响应性。
```typescript
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
// 结果
// age:20, name:leyo
</script>
```
所以当需要解构响应对象，且希望解构后的对象也保持响应性是，可以使用toRefs。
```typescript
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

#### （4）toRef
在一个响应式对象里面，如果其中有一个属性要拿出来单独做响应式的话，就用 toRef。

注意：
```1. 用于响应式对象，产出的结果具备响应式，且修改响应式数据是会影响到原始数据。```
```2. 如果用于普通对象（非响应式对象），产出的结果不具备响应式。```
```3. 和ref的区别：ref本质是拷贝，修改响应式数据不会影响原始数据；toRef的本质是引用关系，修改响应式数据会影响原始数据。```

```typescript
<template>
    <p>state.name:{{state.name}} state.age:{{state.age}} age:{{ageRef}}</p>
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
    // const ageRef = ref(state.age) // 拷贝
    const ageRef = toRef(state, 'age')  // 引用

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

另一种使用场景（官方文档）：如果 title 是可选的 prop，则传入的 props 中可能没有 title 。在这种情况下，toRefs 将不会为 title 创建一个 ref 。你需要使用 toRef 替代它：

举个例子，但不是很理解
```typescript
// 父组件
<template>
    <Son :name="name"/>
</template>

<script>
import { ref } from 'vue'
import Son from './props-son.vue'

export default {
  name: 'ToRefFather',
  components: { Son },
  setup () {
    const name = ref('leyo')
    const age = ref(18)
    return {
      name,
      age
    }
  }
}
</script>
```

```typescript
// 子组件
<template>
    <p>name: {{name}}, age: {{age}}</p>

</template>

<script>
import { toRefs } from 'vue'

export default {
  name: 'ToRefSon',
  props: {
    name: {
      type: String,
      default: ''
    },
    age: {
      type: Number,
      default: 0
    }
  },
  setup (props) {
    const propsRef = toRefs(props)
    return {
      ...propsRef
    }
  }
}
</script>
// 结果
// name: leyo, age: 0
```

#### （5）watch

三个参数：

1. 一个想要侦听的响应式引用或 getter 函数

2. 一个回调

3. 可选的配置选项

```typescript
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
      () => count.value + 1,
      (newValue) => {
        console.log('newValue', newValue)
        countWatch.value = newValue
      },
      {
        immediate: true
      }
    )

    // watch(
    //   // 一个想要侦听的响应式引用
    //   count,
    //   (newValue) => {
    //     countWatch.value = ++newValue
    //   },
    //   {
    //     immediate: true
    //   }
    // )
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
```

#### （6）watchEffect
```
1. 立即执行，没有惰性，页面的首次加载就会执行
2. 不需要传递要侦听的内容 会自动感知代码依赖，不需要传递很多参数，只要传递一个回调函数
3. 不能获取之前数据的值 只能获取当前值
```

```typescript
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
```typescript
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
    setTimeout(() => {
      countWatch.value = 20 // 报错：computed value is readonly
    })
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

如果希望对象是可写的，则需要用 get 和 set 函数创建
```typescript
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
```typescript
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
    // setTimeout(() => {
    //   countReadonly.value = 30 // 报错Set operation on key "value" failed: target is readonly
    // }, 2000)
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

#### （9）provider和inject
provide和inject可以实现嵌套组件之间进行传递数据。
这两个函数都是在setup函数中使用的。
父级组件使用provide向下进行传递数据。
子级组件使用inject来获取上级组件传递过来的数据。

举个例子
```typescript
// 父组件
<template>
  <Son/>
</template>

<script>
import { provide, reactive } from 'vue'
import Son from './Son.vue'

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

```typescript
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

```typescript
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

参考文档：

[官方文档](https://v3.cn.vuejs.org/guide/introduction.html)

[做了一夜动画，就为让大家更好的理解Vue3的Composition Api](https://juejin.cn/post/6890545920883032071)

[敲黑板！vue3重点！一文了解Composition API新特性：ref、toRef、toRefs](https://juejin.cn/post/6976679225239535629)

[vue3 toRef函数和toRefs函数](https://www.jianshu.com/p/0c6ad50a9055)



