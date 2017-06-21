Add required rules for backuppc on client side.

Usage:

```bash
salt '$minion' state.sls backuppc.backuppc_client
```

You need to define a pillar with the public key of your backuppc user on each of your backuppc server, with something like :

```
backuppc_keys:
  serv1_key: ssh-rsa .....................................
  serv2_key: ssh-rsa .....................................
```
