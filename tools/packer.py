#-*-encoding:utf8-*-
# import mysqlutil
import os
import hashlib
import uuid
import datetime

'''
打包工具类
'''
class packer:
    '''
    构造函数
    '''
    def __init__(self, config):
        self.git_url = config['git_url']
        self.workcopy_dir = config['workcopy_dir']
        self.output_dir = config['output_dir']
        self.game = config['game']
        self.resVersion = config['res_version']
        self.clientVersion = config['client_version']
        self.buildNo = config['build_no']

        self.game_dir = os.path.join(self.workcopy_dir, self.game)
        self.out_dir = os.path.join(self.output_dir, str(uuid.uuid1()))
        self.fileMap = {}
        self.out_log = open(os.path.join(self.output_dir, "pack.log"), 'wb')

        self.log("game:%s", self.game)
        self.log("git url:%s", self.git_url)
        self.log("game dir:%s", self.game_dir)
        self.log("output dir:%s", self.output_dir)
        

    '''
    进行打包
    '''
    def pack(self):
        # 1. 检查工作空间
        self.doEnvCheck()

        # 2. 同步workingcopy
        self.syncWorkcopy()

        # 3. 处理文件
        self.doFile(os.path.join(self.game_dir, "res"))
        self.doFile(os.path.join(self.game_dir, "src"))

        # 4. 生成res.txt
        self.genResTxtFile()

        # 5. 生成version.lua
        self.genVersionTxt(1)

        # 6. 打包
        self.doZipPack()

        # 7. 清理
        self.clenup()

        self.log("pack success")
        self.out_log.close()
    
    '''
    环境检查
    '''
    def doEnvCheck(self):
        if not os.path.exists(self.game_dir):
            os.makedirs(self.game_dir)
            self.execCmd("cd %s && git clone %s %s", self.workcopy_dir, self.git_url, self.game)
        
        if not os.path.exists(self.out_dir):
            os.makedirs(self.out_dir)
    
    '''
    同步workcopy
    '''
    def syncWorkcopy(self):
        if os.path.exists(self.game_dir):
            self.execCmd("cd %s && git pull", self.game_dir)
        else:
            self.execCmd("cd %s && git clone %s %s", self.workcopy_dir, self.git_url, self.game)
    
    '''
    处理文件
    '''
    def doFile(self, rootPath):
        for parent, dirnames, filenames in os.walk(rootPath):
            for filename in filenames:
                filePath = os.path.join(parent, filename)
                relativePath = filePath[len(rootPath)+1:]
                if filename == "main.lua":
                    filenameMd5 = self.md5("src/main.lua")
                else:
                    filenameMd5 = self.md5(relativePath)
                fileMd5 = self.md5file(filePath)
                fileSize = os.path.getsize(filePath)

                self.fileMap[filenameMd5] = (fileMd5, fileSize, relativePath)
                self.copyFile(filePath, filenameMd5)
                self.log("do file: %s, name md5: %s, file md5: %s", relativePath, filenameMd5, fileMd5)
    
    '''
    生成res.lua
    '''
    def genResTxtFile(self):
        filepath = os.path.join(self.out_dir, "res.txt")
        resFile = open(filepath, 'wb')
        buff = []

        for key, value in self.fileMap.iteritems():
            buff.append("%s=%s,%s\n"%(key, value[0], value[1]))
        
        resFile.write(''.join(buff))
        resFile.close()

    '''
    生成version.txt
    '''
    def genVersionTxt(self, packType):
        '''
        local game = {}

        game.resVersion = "1.0.0.0"
        game.clientVersion = "1.0.0.0"
        game.buildNo = 0
        game.packType = 1

        return game
        '''
        filename = "version.txt"
        filepath = os.path.join(self.out_dir, filename)
        versionFile = open(filepath, 'wb')
        buff = []

        buff.append("local game = {}\n")
        buff.append("\n")
        buff.append("game.resVersion = %s\n"%(self.resVersion))
        buff.append("game.clientVersion = %s\n"%(self.clientVersion))
        buff.append("game.buildNo = %s\n"%(self.buildNo))
        buff.append("game.packType = %s\n"%(packType))
        buff.append("\n")

        buff.append("return game\n")
        
        versionFile.write(''.join(buff))
        versionFile.close()
    
    '''
    zip pack
    '''
    def doZipPack(self):
        zipFileName = datetime.datetime.now().strftime('%Y%m%d%H%M%S')
        zipFilePath = os.path.join(self.output_dir, zipFileName + ".zip")

        
        self.execCmd("cd %s && zip -r %s * ", self.out_dir, zipFilePath)
        self.log("outputName %s", zipFilePath)
    
    '''
    清理资源
    '''
    def clenup(self):
        self.execCmd("rm -rf %s", self.out_dir)

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
        m.update(content.lower())

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
        self.out_log.write(fmt%args + "\n")
        self.out_log.flush()

if __name__ == '__main__':
    config = {
        "game" : "tetris",
        "git_url" : "https://github.com/2660749774/cocosgame.git",
        "workcopy_dir" : "/Workspace/packer/",
        "output_dir" : "/Workspace/packer/output/",
        "res_version" : "1.0.0.0",
        "client_version" : "1.0.0.0",
        "build_no" : 1,
        "pack_type" : 1
    }
    
    p = packer(config)
    p.pack()