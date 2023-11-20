#!/bin/bash

# 检查是否以 root 用户身份运行脚本
if [[ $EUID -ne 0 ]]; then
    echo "请使用 root 权限运行此脚本。"
    exit 1
fi

# 介绍脚本的作用
echo "此脚本的作用是实现端口转发后重启失效的问题。"

# 在 root 文件夹下创建 iptables_rules 文件
read -p "按 Enter 键继续..."
touch /root/iptables_rules

# 读取用户输入的原始端口号，进行输入验证
    read -p "请输入需要转发的端口号: " 
    read original_port
   

# 读取用户输入的替换端口号，进行输入验证

    read -p "请输入转发到哪个端口: " 
    read replacement_port
    

# 构建 iptables 命令，并替换端口号
iptables_command="iptables -t nat -A PREROUTING -p tcp --dport $original_port -j REDIRECT --to-port $replacement_port"

# 运行 iptables-save 命令并将规则保存到 iptables_rules 文件
read -p "按 Enter 键继续..."
iptables-save > /root/iptables_rules

# 编辑文件添加 pre-up iptables-restore 命令
read -p "按 Enter 键继续..."
echo "pre-up iptables-restore < /root/iptables_rules >/dev/null 2>&1" | sudo tee -a /etc/network/interfaces

# 提示用户操作完成
echo "iptables 规则已保存并添加到网络接口配置文件。"

# 结束脚本
exit 0
