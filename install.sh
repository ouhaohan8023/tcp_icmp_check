#!/usr/bin/env bash
#=================================================
#	System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+
#	Description: Install tcp_check
#	Version: 1.0.0
#	Author: Oscar
#	Blog: https://www.ohh.ink
#=================================================
sh_ver="2.0.38"
filepath=$(cd "$(dirname "$0")"; pwd)
file=$(echo -e "${filepath}"|awk -F "$0" '{print $1}')
config_user_file="${file}/usermysql.json"
run_file="${file}/p.py"
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
Separator_1="——————————————————————————————"

# 设置 数据库信息
Set_host(){
    echo -e "请输入数据库ip"
	stty erase '^H' && read -p "(默认: 127.0.0.1):" host
	[[ -z "$host" ]] && host="127.0.0.1"
	if [[ "$host" ]]; then
        echo && echo ${Separator_1} && echo -e "	数据库ip : ${Green_font_prefix}${host}${Font_color_suffix}" && echo ${Separator_1} && echo
        break
	else
		echo -e "${Error} 请输入数据库ip"
		exit 1
	fi
}
Set_user(){
    echo -e "请输入数据库用户名"
	stty erase '^H' && read -p "(默认: root):" user
	[[ -z "$user" ]] && user="root"
	if [[ "$user" ]]; then
        echo && echo ${Separator_1} && echo -e "	数据库用户名 : ${Green_font_prefix}${user}${Font_color_suffix}" && echo ${Separator_1} && echo
        break
	else
		echo -e "${Error} 请输入数据库用户名"
		exit 1
	fi
}
Set_pwd(){
    echo -e "请输入数据库密码"
	stty erase '^H' && read -p ":" pwd
	if [[ "$pwd" ]]; then
        echo && echo ${Separator_1} && echo -e "	数据库密码 : ${Green_font_prefix}${pwd}${Font_color_suffix}" && echo ${Separator_1} && echo
        break
	else
		echo -e "${Error} 请输入数据库密码"
		exit 1
	fi
}
Set_database(){
    echo -e "请输入数据库名称"
	stty erase '^H' && read -p ":" database
	if [[ "$database" ]]; then
        echo && echo ${Separator_1} && echo -e "	数据库名称 : ${Green_font_prefix}${database}${Font_color_suffix}" && echo ${Separator_1} && echo
        break
	else
		echo -e "${Error} 请输入数据库名称"
		exit 1
	fi
}
Set_config_port(){
    echo -e "请输入端口"
	stty erase '^H' && read -p "(默认: 3306):" port
	[[ -z "$port" ]] && port="3306"
	expr ${port} + 0 &>/dev/null
	if [[ $? == 0 ]]; then
		if [[ ${port} -ge 1 ]] && [[ ${port} -le 65535 ]]; then
			echo && echo ${Separator_1} && echo -e "	端口 : ${Green_font_prefix}${port}${Font_color_suffix}" && echo ${Separator_1} && echo
			break
		else
			echo -e "${Error} 请输入正确的数字(1-65535)"
			exit 1
		fi
	else
		echo -e "${Error} 请输入正确的数字(1-65535)"
		exit 1
	fi
}
# 写入 配置信息
Write_configuration(){
	cat > ${config_user_file}<<-EOF
{
   "host":"${host}",
   "port":${port},
   "user":"${user}",
   "password":"${pwd}",
   "db":"${database}"
}
EOF
}
#  写入定时任务
Write_crontab(){
    echo "* * * * *  /usr/bin/python2.7 ${run_file}" >> /var/spool/cron/root
}
#echo "${file}"
Set_host
Set_user
Set_pwd
Set_database
Set_config_port
Write_configuration
Write_crontab