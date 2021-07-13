// 1. 数字的枚举
enum Direction {
  NORTH, // 默认0
  SOUTH, // 默认1
  EAST, // 默认2
  WEST, // 默认3
}


let dir: Direction = Direction.EAST;
console.log('dir', dir)

enum Direction1 {
  NORTH = -1,
  SOUTH, // 变成0
  EAST = 4,
  WEST, // 变成5
}

// 默认为0,1,2,3...，如果自定义数字，则