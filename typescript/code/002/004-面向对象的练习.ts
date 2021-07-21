// 类，抽象类，接口 -》怎么用？
// 要求：万事皆对象，不使用全局变量和方法
//      使用类、抽象类、接口要达到的效果，就是为了减少代码复制-粘贴，实现优雅的重用
// 问题：一类Job
//    1. 计算任务：属性：data 数字的数组
//                      result 数字的数组
//                方法：run()
//    2. 计算任务2：属性：data 字符串的数组
//                      result 数字的数组
//                方法：run()
//       serverConfig数据结构：
//                属性：IP 字符串
//                      port 整数
//                      connectionString 连接字符串
//    3. SQL任务：  属性：serverConfig 数据结构
//                       sql 字符串
//                       result 字符串
//                  方法：run()
//                        ping(timeout 整数)
//                        connect()
//    4. 远程文件任务：属性：serverConfig 数据结构
//                         filePaths 字符串数组 文件名列表
//                         result 字符串
//                    方法：run()
//                          ping(timeout 整数)
//                          connect()

//   步骤：1. 不考虑继承和接口，列出所有的类的属性和方法列表。
//        2. 原则：（奥卡姆剃刀原则）如无需要，勿增实体（抽象类，接口），只有在能减少代码复制粘贴的情况下，才用。
//        3. 先忘记继承和接口，平面化的写类代码
//        4. 把逻辑相同的部分抽取出来，避免同一性质的改动在不同的代码段做重复的改动。（重构，refactory），使用抽象类和接口
//        5. 如果只有属性（类型相同）和方法的接口，用接口；如果同时有属性和方法的接口和内容相同，用抽象类

interface IJob<ResultType> {
    result: ResultType;
    run(): boolean;
}

abstract class AbstractJob<ResultType> implements IJob<ResultType>{
    protected _result: ResultType;
    constructor(){

    }
    get result(): ResultType{
        return this._result;
    }

    abstract run(): boolean;
}

abstract class CalculatingJob<DataType> extends AbstractJob<number[]>{
    protected _data: DataType;
    constructor(data: DataType){
        super();
        this.data = data;
    }

    get data(): DataType{
        return this._data;
    }

    set data(data: DataType) {
        this._data = data;
    }
}

class CalculatingNumberArrayJob extends CalculatingJob<number[]>{
    constructor(data: number[]){
        super(data);
    }

    run(): boolean{
        // 假装在计算
        console.log('假装在计算...', this.data);
        this._result = [0, 1, 2, 3];
        return true;
    }
}

class CalculatingStringsArrayJob extends CalculatingJob<string[]>{
    constructor(data: string[]){
        super(data);
    }

    run(): boolean {
        // 假装在计算
        console.log('假装在计算', this.data);
        this._result = [0, 1, 2, 3];
        return true;
    }
}

interface IServerConfig{
    IP: string;
    port: number;
    connectionString: string;
}

abstract class ServerJob extends AbstractJob<string>{
    protected _serverConfig: IServerConfig;
    constructor(serverConfig: IServerConfig){
        super();
        this.serverConfig = serverConfig;
    }

    get serverConfig(): IServerConfig{
        return this._serverConfig;
    }

    set serverConfig(serverConfig: IServerConfig){
        this._serverConfig = serverConfig;
    }

    ping(timeout: number): boolean{
        // 假装在ping 服务器，用到服务器的IP和port
        let s: IServerConfig = this.serverConfig;
        console.log(`faking pinging server ${s.IP}:${s.port} in ${timeout}ms`);
        return true;
    }

    connect(): boolean{
        // 假装在连接
        let s: IServerConfig = this.serverConfig;
        console.log(`faking connecting server ${s.IP}:${s.port}...`);
        return true;
    }
}

class SQLJob extends ServerJob{
    protected _sql: string;
    constructor(serverConfig: IServerConfig, sql: string){
        super(serverConfig);
        this.sql = sql;
    }

    get sql(): string{
        return this._sql;
    }

    set sql(sql: string){
        this._sql = sql;
    }

    run(): boolean{
        // 假装在访问数据库
        console.log('假装在访问数据库', this.serverConfig, this.sql);
        this._result = '{假装的数据库数据放入JSON}';
        return true;
    }
}

class RemoteFileJob extends ServerJob{
    protected _filePaths: string[];
    constructor(serverConfig: IServerConfig, filePaths: string[]){
        super(serverConfig);
        this.filePaths = filePaths;
    }

    get filePaths(): string[]{
        return this._filePaths;
    }

    set filePaths(filePaths: string[]){
        this._filePaths = filePaths;
    }

    run(): boolean{
        // 假装在访问文件服务器
        console.log('假装在访问文件服务器', this.serverConfig, this.filePaths);
        this._result = '{假装的文件内容放入JSON}';
        return true;
    }
}

let j1: IJob<number[]> = new CalculatingNumberArrayJob([0,1]);
// j1.run();
// console.log(j1.result);

let j2: IJob<number[]> = new CalculatingStringsArrayJob(['abc', 'def']);
// j2.run();
// console.log(j2.result);

let j3: IJob<string> = new SQLJob({IP: '127.0.0.1', port: 80, connectionString: 'connectinString'}, 'sql lines');
// j3.run();
// console.log(j3.result);

let j4: IJob<string> = new RemoteFileJob({IP: '127.0.0.2', port: 90, connectionString: 'connectioNString'}, ['./abc.txt', './def.txt']);
// j4.run();
// console.log(j4.result);

let jobs: IJob<any>[] = [j1, j2, j3, j4];

for(let i = 0; i < jobs.length; i++){
    jobs[i].run();
    console.log(jobs[i].result);
}
