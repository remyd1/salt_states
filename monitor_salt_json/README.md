If you want to to basic monitoring with salt, it is possible with the [check_services](../check_services/README.md) salt states, and some modules already availables (disk.percent , test.ping).

### Warnings
 - This is not 'real' time monitoring just a report of the state of your minions (up/down), your minions services states, and to get an idea of minions disk usage.
 - Real time monitoring should be done using [salt mine](https://docs.saltstack.com/en/latest/topics/mine/). Then, add [salt reactor](https://docs.saltstack.com/en/latest/topics/reactor/), if you want alerts.
 - You may also consider [salt-monitor](https://github.com/thatch45/salt-monitor).
 - Finally, do not forget to add a true monitoring solution to complete this (see ganglia states for example).

Once this warnings said, you could use some files here to create json files regularly (see check_salt_json.cron.bash file) and the php code to display the results. This means that you need a web server on your salt master with php enabled.

The cron script creates daily json files in ``` /var/www/html/exports/YYYYMM/YYYYMMDD_type_of_export.json ``` .

If you want you could also add a mail alert manually by adding a daily cron which is just doing something like this :

```bash
## adding a [jsawk](https://github.com/micha/jsawk) script to parse the content of your json files 
## and grep the results...
## or directly grep the json files...
grep 'false' /var/www/html/exports/`date '+%Y%m'`/`date '+%Y%m%d'`_hosts_status.json
grep -B5 -A4 'false' /var/www/html/exports/`date '+%Y%m'`/`date '+%Y%m%d'`_services.json
```
