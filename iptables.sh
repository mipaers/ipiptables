#!/bin/bash
echo "此脚本的作用是实现端口转发后重启失效的问题。"
echo "请输入需要转发的端口："
read original_port
echo "请输入转发到哪个端口："
read replacement_port
iptables_command="iptables -t nat -A PREROUTING -p tcp --dport $original_port -j REDIRECT --to-port $replacement_port"
touch /root/iptables_rules
iptables-save > /root/iptables_rules
echo "pre-up iptables-restore < /root/iptables_rules" | tee -a /etc/network/interfaces
echo "iptables规则已保存并添加到网络接口配置文件。"
# 结束脚本
exit 0

