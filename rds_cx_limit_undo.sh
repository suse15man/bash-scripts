#!/bin/bash

# undo rds_cx_limit script 

iptables -D INPUT -p tcp --dport 8081 --syn -j rds_cx_limit
iptables -D INPUT -p tcp --dport 8083 --syn -j rds_cx_limit
iptables -D INPUT -p tcp --dport 8448 --syn -j rds_cx_limit
iptables -D INPUT -p tcp --dport 8888 --syn -j rds_cx_limit

iptables -D rds_cx_limit -j DROP
iptables -D rds_cx_limit -m limit --limit 10/s --limit-burst 20 -j RETURN
iptables -X rds_cx_limit
