// 1. 数字的枚举
// enum Direction {
//   NORTH, // 默认0
//   SOUTH, // 默认1
//   EAST, // 默认2
//   WEST, // 默认3
// }


// let dir: Direction = Direction.EAST;
// console.log('dir', dir)

// enum Direction1 {
//   NORTH = -1,
//   SOUTH, // 变成0
//   EAST = 4,
//   WEST, // 变成5
// }

// 默认为0,1,2,3...，如果自定义数字，则后面的枚举在前一个枚举值上递增

// let web: void = undefined
// web = null
// let cml:any = 'string'
// cml = 123

// let cml:string | number
// cml = '123'
// cml = 123

// interface IPerson {
//   name: string,
//   age?: number
// }

// // 实例化
// let p1: IPerson = {
//   name: 'web',
// }

// interface IPerson {
//   readonly name: string,
//   age: number
// }

// let p1: IPerson = {
//   name: '123',
//   age: 18
// }

// let p2: IPerson = {
//   name: '456', // ok
//   age: 18
// }

// p1.name = '456' // 报错
// p1.age = 18

// interface INumberArray {
//   [Index: number]: number
// }

// let array1: INumberArray = [0, 1, 2, 3]


// function web(name: string, age: number) {
//   let args: IArguments = arguments;
//   console.log(args);  // { '0': 'web', '1': 1 }
// }
// web('web', 1)

// function cml(x: number, y: number): number {
//   return x + y
// }
// let cml = function(x: number, y: number): number {
//   return x + y
// }
// let cml: (x: number, y: number) => number = function(x: number, y: number): number {
//   return x + y
// }

// interface ICml {
//   (x: number, y: number): number
// }

// let cml: ICml = function(x: number, y: number) : number {
//   return x + y
// }
// console.log(cml(1, 2))

// function cml(x: number, y?: number): number {
//   y = y || 0
//   return x + y
// }
// console.log(cml(1, 2))  // 3
// console.log(cml(1))  // 1

// function cml(arguments) {
//   let sum = 0
//   for(let item of arguments) {
//     sum = sum + item
//   }
//   return sum
// }
// console.log(cml(1, 2, 3)) // 6

// function cml(...args: number[]) {
//   let sum: number = 0
//   for(let i: number = 0; i < args.length; i ++) {
//     sum = sum + args[i]
//   }
//   return sum
// }
// console.log(cml(1, 2, 3)) // 6
// console.log(cml(1, '2', 3)) // 6

function cml(a: number | string): void {
  console.log(a.length) // 报错
  console.log((<string>a).length) // OK
}
