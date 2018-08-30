## TCP 及 ICMP 监测
###[Github项目地址](https://github.com/ouhaohan8023/tcp_icmp_check.git)
###[个人博客，不过估计打不开](https://www.ohh.ink)
### 目前国外ip被屏蔽的情况有如下两种：
### 1. Ping 不通
### 2. TCP 阻断

```angular2html
前者是最普遍的阻断方式，IP直接连接超时，后者是前段时间刚出的阻断方式，IP可以Ping通，但是端口不通，最直接的表现就是可以Ping通，无法SSH登陆。基于目前IP被封（不可用）的两种情况，本工具包括普通的Ping检测（ICMP检测）和指定端口检测（TCP检测）
```

### 本项目原理
```angular2html
1. 从后台数据库获取节点列表 ss_node.sql
2. ping ip ，检查是否可以ping通
3. 通过sockets检查ip对应端口（默认10001）是否通
4. 将ping的结果，以及sockets结果，回传给数据库ss_node_tcp_icmp.sql

```

### 使用方法(部署在国内节点)
```angular2html
0. yum install MySQL-python -y
1. git clone https://github.com/ouhaohan8023/tcp_icmp_check.git
2. cd tcp_icmp_check 
3. sed 's/\r//' install.sh > ainstall.sh
4. sh ainstall.sh
5. 输入后台数据库配置信息
6. python p.py
7. 脚本已加入定时任务，在使用SSRPanel的情况下，每3分钟回传一次数据

```

## 附
### 将dos环境下编写的shell脚本转化为linux环境下可运行的脚本
```angular2html
// 出现报错
install.sh: line 50: $'\r': command not found
install.sh: line 51: $'\r': command not found
install.sh: line 52: $'\r': command not found
install.sh: line 54: syntax error near unexpected token `$'{\r''
'nstall.sh: line 54: `Set_host(){
```
```
//解决方法
sed 's/\r//' install.sh > ainstall.sh
```
