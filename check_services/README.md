This formula checks services/daemon from a pillar [pillar:machines/hosts.sls].

You can read how to write this file if you read the [REAME.md file from backuppc_add_client](../backuppc_add_client/README.md)


Usage:

```bash
salt '*' state.sls check_services
```

Actually, I am using it with json output. Then I read the results with a specific php file every morning (cron).
