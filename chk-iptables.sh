#!/usr/bin/env bash

su root -c "/usr/sbin/iptables -L|grep rds_cx_limit"
