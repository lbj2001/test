set -e # 任何错误就退出

DATE=$(date +%Y%m%d%H%M)
# 基础路径
BASE_PATH=/opt/project/work/back
# 服务名称。
SERVER_NAME=wh-admin
# 环境
PROFILES_ACTIVE=test
#JVM 参数
JAVA_OPS="-Xms1024m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$BASE_PATH/heapError"

# 1 备份
function backup(){
	# 如果不存在，则无需备份
    if [ ! -f "$BASE_PATH/$SERVER_NAME.jar" ]; then
        echo "[backup] $BASE_PATH/$SERVER_NAME.jar 不存在，跳过备份"
    # 如果存在，则备份到 backup 目录下，使用时间作为后缀
    else
        echo "[backup] 开始备份 $SERVER_NAME ..."
        cp $BASE_PATH/$SERVER_NAME.jar $BASE_PATH/backup/$SERVER_NAME-$DATE.jar
        echo "[backup] 备份 $SERVER_NAME 完成"
    fi
}

# 2 停止服务
function stop(){
	echo "[stop] 开始停止 $BASE_PATH/$SERVER_NAME"
    PID=$(ps -ef | grep $BASE_PATH/$SERVER_NAME | grep -v "grep" | awk '{print $2}')
    # 如果 Java 服务启动中，则进行关闭
    if [ -n "$PID" ]; then
        # 正常关闭
        echo "[stop] $BASE_PATH/$SERVER_NAME 运行中，开始 kill [$PID]"
        kill -9 $PID
    # 如果 Java 服务未启动，则无需关闭
    else
        echo "[stop] $BASE_PATH/$SERVER_NAME 未启动，无需停止"
    fi
}

# 3 最新构建代码移动到项目环境
function move(){
	echo "[move] 开始转移 $SERVER_NAME.jar"

    # 删除原 jar 包
    if [ ! -f "$BASE_PATH/$SERVER_NAME.jar" ]; then
        echo "[move] $BASE_PATH/$SERVER_NAME.jar 不存在，跳过删除"
    else
        rm $BASE_PATH/$SERVER_NAME.jar
        echo "[move] 删除 $BASE_PATH/$SERVER_NAME.jar 完成"
    fi

    # 复制新 jar 包
    echo "[move] 从 $BASE_PATH/build 中获取 $SERVER_NAME.jar 并迁移至 $BASE_PATH ...."
    cp $BASE_PATH/build/$SERVER_NAME.jar $BASE_PATH

    echo "[move] 转移 $SERVER_NAME.jar 完成"
}

# 4 启动服务
function start(){
	 # 开启启动前，打印启动参数
    echo "[start] 开始启动 $BASE_PATH/$SERVER_NAME"
    echo "[start] JAVA_OPS: $JAVA_OPS"
    echo "[start] PROFILES: $PROFILES_ACTIVE"
    
    # 开始启动 
    BUILD_ID=DONTKILLME 
    nohup java -server $JAVA_OPS -jar $BASE_PATH/$SERVER_NAME.jar --spring.profiles.active=$PROFILES_ACTIVE > nohup.out & 
    echo "[start] 启动 $BASE_PATH/$SERVER_NAME 完成"
}

# 部署
function deploy(){
	cd $BASE_PATH
	backup
	stop
	move
	start
}

deploy