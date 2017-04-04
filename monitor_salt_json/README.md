If you want to to basic monitoring with salt, it is possible with the [check_services](../check_services/README.md) salt states, and some modules already availables (disk.percent , test.ping).

The main advantage of this solution is to have a very brief information about the state of your servers pool (the minions) in a single web page with a system of green/red color:
 - disk usage (percentage, red if &gt;90% ),
 - server state,
 - service state.

### Warnings
 - This is not 'real' time monitoring just a reporting system !
 - Real time monitoring with salt should be done using [salt mine](https://docs.saltstack.com/en/latest/topics/mine/). Then, add [salt reactor](https://docs.saltstack.com/en/latest/topics/reactor/), if you want alerts.
 - You may also consider using [salt-monitor](https://github.com/thatch45/salt-monitor).
 - Finally, do not forget to add a true monitoring solution to complete this (e.g. see [ganglia states](../ganglia_client/README.md)).


Once these warnings said, you could use some files here to create json files regularly (see check_salt_json.cron.bash file) and the php code to display the results. This means that you need a web server on your salt master with php enabled.

![Image of disk usage](https://raw.githubusercontent.com/remyd1/salt_states/master/monitor_salt_json/disk_usage.png)


The cron script creates daily json files in ```/var/www/html/exports/YYYYMM/YYYYMMDD_type_of_export.json```

You could change this behaviour, by adding hours, minutes, seconds to the filename. However, you will have to change the way you retrieve data in the php file (add a panel to choose the time ([example](http://trentrichardson.com/examples/timepicker/))).

If you want you could also add a mail alert manually by adding a daily cron (or more frequently if you changed the periodicity). You could achieve this either with a [jsawk](https://github.com/micha/jsawk)[\*](#jsawk_comment) script combined with mail command or by parsing directly the content of your json files manually (also combined with mail command):

```bash
grep 'false' /var/www/html/exports/`date '+%Y%m'`/`date '+%Y%m%d'`_hosts_status.json
grep -B5 -A4 'false' /var/www/html/exports/`date '+%Y%m'`/`date '+%Y%m%d'`_services.json
```

(\*) <a><a id="#jsawk_comment"> e.g. : 

```bash
cat /var/www/html/exports/`date '+%Y%m'`/`date '+%Y%m%d'`_hosts_status.json |jsawk 'return this.myhost'
```
