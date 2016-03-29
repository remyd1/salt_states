This formula checks services/daemon from a pillar [pillar:machines/hosts.sls].


Usage:

```bash
salt '*' state.sls check_services
```

Actually, I am using it with json output. Then I read the results with a specific php file every moring (cron).
