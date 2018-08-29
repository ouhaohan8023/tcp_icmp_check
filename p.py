#!/usr/bin/python
# -*- coding: UTF-8 -*-
# 文件名：p.py
# 安装MySQLdb
# yum install MySQL-python -y

import socket      # 导入 socket 模块
import MySQLdb
import json
from io import open
import time
import re
import subprocess

def check_alive(ip, count=1, timeout=1):
    '''
    ping网络测试,通过调用ping命令,发送一个icmp包，从结果中通过正则匹配是否有100%关键字，有则表示丢包，无则表示正常
    '''
    cmd = 'ping -c %d -w %d %s' % (count, timeout, ip)

    p = subprocess.Popen(cmd,
                         stdin=subprocess.PIPE,
                         stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE,
                         shell=True
                         )

    result = p.stdout.read()
    regex = re.findall('100% packet loss', result)
    if len(regex) == 0:
        # print "\033[31m%s UP\033[0m" % (ip)
        return 1
    else:
        # print "\033[32m%s DOWN\033[0m" % (ip)
        return 0
# check_alive('8.8.8.8')

def add(t_tcp_status,icmp_status,name,ip):
    '''
   新增节点数据
    '''
    created_at = time.time()
    updated_at = time.time()
    if t_tcp_status == 1:
        addSql = "INSERT INTO ss_node_tcp_icmp(t_s_id,t_icmp_status,t_tcp_status,created_at,updated_at) VALUES (%d,%d,%d,%d,%d)" % (
            row[0], icmp_status, t_tcp_status, created_at, updated_at)
        print "\033[32m%s %s ok\033[0m" % (ip,name)
    else:
        end_at = time.time()
        addSql = "INSERT INTO ss_node_tcp_icmp(t_s_id,t_icmp_status,t_tcp_status,created_at,updated_at,end_at) VALUES (%d,%d,%d,%d,%d,%d)" % (
            row[0], icmp_status, t_tcp_status, created_at, updated_at, end_at)
        print "\033[31m%s %s error\033[0m" % (ip,name)
    try:
        cursor.execute(addSql)
        db.commit()
    except:
        db.rollback()
        print "\033[31m 数据库更新异常addSql \033[0m"

def update(t_tcp_status,icmp_status,name,ip):
    '''
    更新节点信息
    :param t_tcp_status:
    :return:
    '''
    if t_tcp_status == 1:
        updated_at = time.time()
        updateSql = "UPDATE ss_node_tcp_icmp SET t_icmp_status = %d,t_tcp_status = %d,updated_at = %d WHERE (t_s_id = %d)" % (
            icmp_status, t_tcp_status, updated_at, row[0])

        print "\033[32m%s %s ok\033[0m" % (ip,name)
    else:
        updated_at = time.time()
        end_at = time.time()
        updateSql = "UPDATE ss_node_tcp_icmp SET t_icmp_status = %d,t_tcp_status = %d,updated_at = %d,end_at = %d WHERE (t_s_id = %d)" % (
            icmp_status, t_tcp_status, updated_at,end_at, row[0])
        print "\033[31m%s %s error\033[0m" % (ip,name)
    try:
        cursor.execute(updateSql)
        db.commit()
    except:
        db.rollback()
        print "\033[31m 数据库更新异常updateSql\033[0m"

with open('./usermysql.json', encoding='utf-8') as f:
    line = f.read()
    d = json.loads(line)
    f.close()

db = MySQLdb.connect(d['host'], d['user'], d['password'], d['db'], charset='utf8' )

 # 使用cursor()方法获取操作游标
cursor = db.cursor()

sql = "SELECT id,ip,name FROM ss_node WHERE status = 1"
try:
    # 执行SQL语句
    cursor.execute(sql)
    # 获取所有记录列表
    results = cursor.fetchall()
    for row in results:
       ip = row[1]
       icmp = check_alive(ip)
       # 打印结果
       print "ip:"+ip
       s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)         # 创建 socket 对象
       host = ip
       port = 10001              # 设置端口号

       status = s.connect_ex((host, port))
       s.close()

       sql2 = "SELECT * FROM ss_node_tcp_icmp WHERE t_s_id = %d" %(row[0])
       cursor.execute(sql2)
       exist = cursor.fetchone()
       if exist == None :
         if status == 0:
             add(1,icmp,row[2],row[1])
         else:
             add(0,icmp,row[2],row[1])
       else:
         if status == 0:
             update(1,icmp,row[2],row[1])
         else:
             update(0,icmp,row[2],row[1])
except:
    print "数据库链接失败"

# 关闭数据库连接
db.close()

