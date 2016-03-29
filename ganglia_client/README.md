Firstly, you need a ganglia server. This formula will not create it for you. It is just connecting the client to the server and installs the ganglia package if needed.

Usage:

```bash
salt '*' state.sls ganglia_client
```

There are some templates (unicast if public IP, multicast otherwise for clusters).

This state needs an [additional module](https://github.com/remyd1/salt_modules/blob/master/customnetwork.py) to work

