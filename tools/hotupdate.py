#-*-encoding:utf8-*-
import mysqlutil
import os
import hashlib
import uuid
import datetime
import yaml
import zipfile

'''
热更工具类
'''
class hotupdate:
    '''
    构造函数
    '''
    def __init__(self, config):
        self.game = config['game']
        self.configPath = config['config_path']
        self.resZipPath = config['res_zip_path']
        self.gameVersion = config['game_version']
        self.updateGroup = config['update_group']
        self.fileMap = {}

        self.log("game:%s", self.game)
        self.log("resZipPath:%s", self.resZipPath)
        self.log("configPath:%s", self.configPath)

        self.loadConfig()

        # 连接数据库
        self.dbutil = mysqlutil.MySQLUtil(host=self.dbConf['host'], user=self.dbConf['user'], passwd=self.dbConf['password'], db=self.dbConf['database'])
    
    '''
    载入配置
    '''
    def loadConfig(self):
        filepath = os.path.join(self.configPath, self.game + ".yaml")
        f = open(filepath, 'rb')
        self.conf = yaml.load(f.read())
        f.close()
        
        self.hotupdateDir = os.path.join(self.conf['tetris']['hotupdate_dir'], self.updateGroup)
        self.dbConf = self.conf['db']

    '''
    进行打包
    '''
    def doHotUpdate(self):
        # 1. 检查工作空间
        self.doEnvCheck()

        # 2. 解压资源
        self.unzipResZip()

        # 3. 生成动更
        self.genHotUpdate()

        # 4. 更新频道数据
        updateGroupSql = self.doSQL(self.dbConf['updateGroupSql'])
        self.dbutil.execute(updateGroupSql%(self.gameVersion, self.game, self.updateGroup))

        self.log("handle hotupdate succ")
    
    '''
    环境检查
    '''
    def doEnvCheck(self):
        if not os.path.exists(self.hotupdateDir):
            self.log("第一次生成该频道动更，创建目录:%s", self.hotupdateDir)
            os.makedirs(self.hotupdateDir)
    
    '''
    解压资源zip
    '''
    def unzipResZip(self):
        if not os.path.exists(self.resZipPath):
            self.log("资源文件不存在, path:%s", self.resZipPath)
            os.exit(1)
            return
        
        # 解压文件
        self.newVersionDir = os.path.join(self.hotupdateDir, self.gameVersion)
        self.execCmd("unzip -o %s -d %s", self.resZipPath, self.newVersionDir)

        # 读取res.txt
        self.fileMap = self.loadResTxt(os.path.join(self.newVersionDir, 'res.txt'))

        # 插入数据库
        selectVersionSql = self.doSQL(self.dbConf['selectVersionSql'])
        result = self.dbutil.querymap(selectVersionSql%(self.game, self.updateGroup, self.gameVersion))
        if result != None and len(result) > 0:
            # 已经存在了
            id = result[0]['id']
            updateVersionSql = self.doSQL(self.dbConf['updateVersionSql'])
            self.dbutil.execute(updateVersionSql%("有新的资源版本，请更新！", str(id)))
        else:
            # 插入
            insertVersionSql = self.doSQL(self.dbConf['insertVersionSql'])
            self.dbutil.execute(insertVersionSql%(self.game, self.updateGroup, self.gameVersion, "有新的资源版本，请更新！"))

    '''
    生成动更
    '''
    def genHotUpdate(self):
        for parent, dirnames, filenames in os.walk(self.hotupdateDir):
            for dirname in dirnames:
                self.log("正在处理版本号:%s", dirname)
                self.genHotUpdateByDir(dirname, os.path.join(parent, dirname))

    
    '''
    处理指定目录动更
    '''
    def genHotUpdateByDir(self, dirname, dirpath):
        if dirname == self.gameVersion:
            self.log("与当前版本号相同，跳过")
            return
        
        fileMap = self.loadResTxt(os.path.join(dirpath, "res.txt"))
        fileList = []
        for key, value in self.fileMap.iteritems():
            if fileMap.has_key(key) and fileMap[key] == value:
                continue
            
            fileList.append(key)
        
        zipFilePath = os.path.join(dirpath, self.gameVersion)
        self.createZipFile(zipFilePath, fileList)

        filename = "%s/%s"%(dirname, self.gameVersion)
        filemd5 = self.md5file(zipFilePath)
        filesize = os.path.getsize(zipFilePath)

        # 插入数据库
        selectUpdateSql = self.doSQL(self.dbConf['selectUpdateSql'])
        result = self.dbutil.querymap(selectUpdateSql%(self.game, self.updateGroup, dirname, self.gameVersion))
        if result != None and len(result) > 0:
            # 已经存在了
            id = result[0]['id']
            updateUpdateSql = self.doSQL(self.dbConf['updateUpdateSql'])
            self.dbutil.execute(updateUpdateSql%(filename, filemd5, filesize, id))
        else:
            # 插入
            insertUpdateSql = self.doSQL(self.dbConf['insertUpdateSql'])
            self.dbutil.execute(insertUpdateSql%(self.game, self.updateGroup, dirname, self.gameVersion, filename, filemd5, filesize))
    
    '''
    创建zipfile
    '''
    def createZipFile(self, zipFilePath, fileList):
        self.log("生成差异包:%s", zipFilePath)
        zFile = zipfile.ZipFile(zipFilePath, 'w')

        for filename in fileList:
            filepath = os.path.join(self.newVersionDir, filename)
            zFile.write(filepath, filename)
        
        zFile.close()

    '''
    载入res.txt
    '''
    def loadResTxt(self, filepath):
        # 打开res.txt
        fileMap = {}
        resFile = open(filepath, 'rb')
        for line in resFile.readlines():
            if line == None or line.strip() == "":
                continue
            
            values = line.split("=")
            fileMap[values[0]] = values[1].split(",")[0]
        
        return fileMap

    '''
    拷贝文件
    '''
    def copyFile(self, filepath, filename):
        topath = os.path.join(self.out_dir, filename)
        self.execCmd("cp %s %s", filepath, topath)

    '''
    计算字符串md5
    '''
    def md5(self, content):
        m = hashlib.md5()
        m.update(content)

        return m.hexdigest()
    
    '''
    计算文件md5
    '''
    def md5file(self, filepath):
        m = hashlib.md5()
        md5file = open(filepath, 'rb')
        m.update(md5file.read())
        md5file.close()

        return m.hexdigest()

    '''
    执行系统命令
    '''
    def execCmd(self, cmd, *args):
        print(args)
        if args != None and len(args) > 0:
            cmd = cmd%args

        p = os.popen(cmd)
        self.log("exec cmd: %s end. rtn:%s", cmd, p.read())
    
    '''
    打印日志
    '''
    def log(self, fmt, *args):
        if args == None and len(args) == 0:
            return
        
        print(fmt%args)
    
    '''
    获取值
    '''
    def doSQL(self, sql):
        return sql.replace('%s', '\'' + '%s' + '\'')

if __name__ == '__main__':
    config = {
        "game" : "tetris",
        "config_path" : "/Workspace/Java/wgp/tools/",
        "res_zip_path" : "/Workspace/packer/output/20170625170955.zip",
        "game_version" : "2.0.0.0",
        "update_group" : "android"
    }
    
    p = hotupdate(config)
    p.doHotUpdate()