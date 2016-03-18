Usage:

```bash
salt '*' state.sls ganglia_client
```

There are some templates (unicast if public IP, multicast otherwise for clusters).

This state needs an [additional module](https://github.com/remyd1/salt_modules/blob/master/customnetwork.py) to work

