### SYN (synchronize): Packets that are used to initiate a connection.
### ACK (acknowledgment): Packets that are used to confirm that the data packets have been received, also used to confirm the initiation request and tear down requests
### RST (reset): Signify the connection is down or maybe the service is not accepting the requests
### FIN (finish): Indicate that the connection is being torn down. Both the sender and receiver send the FIN packets to gracefully terminate the connection
### PSH (push): Indicate that the incoming data should be passed on directly to the application instead of getting buffered
### URG (urgent): Indicate that the data that the packet is carrying should be processed immediately by the TCP stack

### SYN + SYN-ACK + ACK => Flags [S] + Flags [S.] + Flags [.]
### FIN-ACK + FIN-ACK + ACK => Flags [F.] + Flags [F.] + Flags [.]

nc -lk 12345 &
netstat -anp | grep 12345

telnet 127.0.0.1 12345
netstat -anp | grep 12345

sudo tcpdump -i lo -nnn port 12345
