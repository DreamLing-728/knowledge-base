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
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var AbstractJob = /** @class */ (function () {
    function AbstractJob() {
    }
    Object.defineProperty(AbstractJob.prototype, "result", {
        get: function () {
            return this._result;
        },
        enumerable: true,
        configurable: true
    });
    return AbstractJob;
}());
var CalculatingJob = /** @class */ (function (_super) {
    __extends(CalculatingJob, _super);
    function CalculatingJob(data) {
        var _this = _super.call(this) || this;
        _this.data = data;
        return _this;
    }
    Object.defineProperty(CalculatingJob.prototype, "data", {
        get: function () {
            return this._data;
        },
        set: function (data) {
            this._data = data;
        },
        enumerable: true,
        configurable: true
    });
    return CalculatingJob;
}(AbstractJob));
var CalculatingNumberArrayJob = /** @class */ (function (_super) {
    __extends(CalculatingNumberArrayJob, _super);
    function CalculatingNumberArrayJob(data) {
        return _super.call(this, data) || this;
    }
    CalculatingNumberArrayJob.prototype.run = function () {
        // 假装在计算
        console.log('假装在计算...', this.data);
        this._result = [0, 1, 2, 3];
        return true;
    };
    return CalculatingNumberArrayJob;
}(CalculatingJob));
var CalculatingStringsArrayJob = /** @class */ (function (_super) {
    __extends(CalculatingStringsArrayJob, _super);
    function CalculatingStringsArrayJob(data) {
        return _super.call(this, data) || this;
    }
    CalculatingStringsArrayJob.prototype.run = function () {
        // 假装在计算
        console.log('假装在计算', this.data);
        this._result = [0, 1, 2, 3];
        return true;
    };
    return CalculatingStringsArrayJob;
}(CalculatingJob));
var ServerJob = /** @class */ (function (_super) {
    __extends(ServerJob, _super);
    function ServerJob(serverConfig) {
        var _this = _super.call(this) || this;
        _this.serverConfig = serverConfig;
        return _this;
    }
    Object.defineProperty(ServerJob.prototype, "serverConfig", {
        get: function () {
            return this._serverConfig;
        },
        set: function (serverConfig) {
            this._serverConfig = serverConfig;
        },
        enumerable: true,
        configurable: true
    });
    ServerJob.prototype.ping = function (timeout) {
        // 假装在ping 服务器，用到服务器的IP和port
        var s = this.serverConfig;
        console.log("faking pinging server " + s.IP + ":" + s.port + " in " + timeout + "ms");
        return true;
    };
    ServerJob.prototype.connect = function () {
        // 假装在连接
        var s = this.serverConfig;
        console.log("faking connecting server " + s.IP + ":" + s.port + "...");
        return true;
    };
    return ServerJob;
}(AbstractJob));
var SQLJob = /** @class */ (function (_super) {
    __extends(SQLJob, _super);
    function SQLJob(serverConfig, sql) {
        var _this = _super.call(this, serverConfig) || this;
        _this.sql = sql;
        return _this;
    }
    Object.defineProperty(SQLJob.prototype, "sql", {
        get: function () {
            return this._sql;
        },
        set: function (sql) {
            this._sql = sql;
        },
        enumerable: true,
        configurable: true
    });
    SQLJob.prototype.run = function () {
        // 假装在访问数据库
        console.log('假装在访问数据库', this.serverConfig, this.sql);
        this._result = '{假装的数据库数据放入JSON}';
        return true;
    };
    return SQLJob;
}(ServerJob));
var RemoteFileJob = /** @class */ (function (_super) {
    __extends(RemoteFileJob, _super);
    function RemoteFileJob(serverConfig, filePaths) {
        var _this = _super.call(this, serverConfig) || this;
        _this.filePaths = filePaths;
        return _this;
    }
    Object.defineProperty(RemoteFileJob.prototype, "filePaths", {
        get: function () {
            return this._filePaths;
        },
        set: function (filePaths) {
            this._filePaths = filePaths;
        },
        enumerable: true,
        configurable: true
    });
    RemoteFileJob.prototype.run = function () {
        // 假装在访问文件服务器
        console.log('假装在访问文件服务器', this.serverConfig, this.filePaths);
        this._result = '{假装的文件内容放入JSON}';
        return true;
    };
    return RemoteFileJob;
}(ServerJob));
var j1 = new CalculatingNumberArrayJob([0, 1]);
// j1.run();
// console.log(j1.result);
var j2 = new CalculatingStringsArrayJob(['abc', 'def']);
// j2.run();
// console.log(j2.result);
var j3 = new SQLJob({ IP: '127.0.0.1', port: 80, connectionString: 'connectinString' }, 'sql lines');
// j3.run();
// console.log(j3.result);
var j4 = new RemoteFileJob({ IP: '127.0.0.2', port: 90, connectionString: 'connectioNString' }, ['./abc.txt', './def.txt']);
// j4.run();
// console.log(j4.result);
var jobs = [j1, j2, j3, j4];
for (var i = 0; i < jobs.length; i++) {
    jobs[i].run();
    console.log(jobs[i].result);
}
