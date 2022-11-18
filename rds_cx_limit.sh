#!/bin/bash

# Limit the number of incoming tcp connection attempts
iptables -N rds_cx_limit
iptables -A rds_cx_limit -m limit --limit 10/s --limit-burst 20 -j RETURN
iptables -A rds_cx_limit -j DROP

# Verge HTTP
iptables -A INPUT -p tcp --dport 8081 --syn -j rds_cx_limit

# Verge HTTPS
iptables -A INPUT -p tcp --dport 8083 --syn -j rds_cx_limit

# VVX off-net HTTPS
iptables -A INPUT -p tcp --dport 8448 --syn -j rds_cx_limit

# VVX HTTP
iptables -A INPUT -p tcp --dport 8888 --syn -j rds_cx_limit
 