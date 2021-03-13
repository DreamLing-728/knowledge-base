### 1. Vue的生命周期
**1.1 生命周期有哪些**
Vue生命周期总共可以分为8个阶段：创建前后, 载入前后,更新前后,销毁前销毁后，以及一些特殊场景的生命周期
![](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/8a384aed458f424b932aa6dff7903094~tplv-k3u1fbpfcp-watermark.image)

**1.2 生命周期整体流程**

![](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/280bc6ed9e0141f5a9a9b29d64763c5e~tplv-k3u1fbpfcp-watermark.image)

**1.3 数据请求在created和mouted的区别**
created是在组件实例一旦创建完成的时候立刻调用，这时候页面dom节点并未生成

mounted是在页面dom节点渲染完毕之后就立刻执行的

触发时机上created是比mounted要更早的

**两者相同点**：都能拿到实例对象的属性和方法

讨论这个问题本质就是触发的时机，放在mounted请求有可能导致页面闪动（页面dom结构已经生成），但如果在页面加载前完成则不会出现此情况

**建议**：放在create生命周期当中

### 2.Vue组件的通信方式
**2.1 props**
- 场景：父组件传递数据给子组件
- 使用方法：
**父组件**
```
<template>
  <div class="hello">
    <h1>{{title}}</h1>
    <h2>{{msg}}</h2>
    <!-- 2. 传值给子组件 -->
    <Son :stringValue="stringValue" :objValue="objValue"></Son>
  </div>
</template>

<script>
/* eslint-disable */
// 1. 引入子组件
import Son from '@/components/PropsSon'
export default {
  name: 'PropsFarther',
  components: {
    Son
  },
  data () {
    return {
      title: 'props: 适用于父组件给子组件传值！',
      msg: '我是父组件',
      stringValue: '小小梦',
      objValue: {a: '小小梦'}
    }
  }
}
</script>
``` 
**子组件**
```
props: {
    // 3. 接收父组件传的值
    stringValue: String,
    objValue: {
      type: Object,
      default: {},
      require: false,
    }
  }
```

**2.2 $emit**
- 场景：子组件传数据给父组件
- 使用方法：
**父组件**
```
<template>
  <div class="page">
    <h1>{{title}}</h1>
    <h2>{{attribute}}：接收到的值为：{{getEmitValue}}</h2>
    <!-- 3. 父组件里接收，注意：$event里是固定写法 -->
    <EmitSon @add="getEmit($event)"></EmitSon>
  </div>
</template>

<script>
/* eslint-disable */
// 1. 父组件里引入子组件
import EmitSon from '@/components/EmitSon'
export default {
  name: 'EmitFarther',
  data() {
      return {
          title: '$emit: 适用于子组件给父组件传值',
          attribute: '我是父组件',
          getEmitValue: ''
      }
  },
  components: {
      EmitSon
  },
  methods: {
      getEmit(value) {
          console.log('emit',value)
          this.getEmitValue = value
      }
  }
}
</script>
```
**子组件**
```
methods: {
    emitSend() {
      // 2. 子组件通过emit传值给父组件
      this.$emit('add', this.stringValue)
    }
  },
  created() {
    this.emitSend();
  }
```

**2.3 ref**

- **场景**：父组件在使用子组件的时候设置ref，父组件通过在子组件上设置ref来获取数据，获取到的是组件实例，可以使用组件的data数据和method对象里的方法
- **注意**：ref 需要在dom渲染完成后才会有，在使用的时候确保dom已经渲染完成。比如在生命周期 mounted(){} 钩子中调用，或者在 this.$nextTick(()=>{}) 中调用 "
- **使用方法**

**父组件**
```
<template>
  <div class="page">
    <h2>{{ title }}</h2>
    <h2>{{ attribute }}</h2>
    <!-- 2. 设置ref -->
    <RefSon ref="refson"></RefSon>
    <EmitSon ref="emitson"></EmitSon>
  </div>
</template>

<script>
/* eslint-disable */
// 1. 引入子组件
import RefSon from "@/components/RefSon";
import EmitSon from "@/components/EmitSon";
export default {
  name: "RefFarther",
  data() {
    return {
      title: "Ref: 父组件在使用子组件的时候设置ref",
      attribute: "我是父组件",
    };
  },
  components: {
    RefSon,
    EmitSon,
  },
  methods: {
    getRefSon() {
      // 3. 使用ref
      // 3.1 使用子组件里的方法
      this.$refs.refson.getrefs();
      // 3.2 使用子组件里的对象
      console.log("this.$refs.refson.refValue", this.$refs.refson.refValue);
    },
  },

  // 注意写法1：注意这里要放在mounted钩子函数里
  // mounted() {
  //   this.getRefSon();
  // },


  // 注意写法2：this.$nextTick(()=>{})
  created() {
    this.$nextTick(() => {
      this.getRefSon();
    })
  }
};
</script>
```
**子组件**
```
<script>
/* eslint-disable */
export default {
  name: 'RefSon',
  data() {
    return {
      refValue: '小小梦'
    }
  },
  methods: {
    getrefs() {
      console.log('我是子组件里的方法')
    }
  }
}
</script>
```

### 3. 脚手架构建Vue项目
https://www.cnblogs.com/chenwolong/p/vuecli.html