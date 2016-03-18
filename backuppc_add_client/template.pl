{% if hostinfo.has_key('RsyncShareName') %}
$Conf{RsyncShareName} = [ {% for savedir in hostinfo['RsyncShareName'] %}
  '{{ savedir }}', {% endfor %}
];
{% endif %}
{% if hostinfo.has_key('BackupFilesExclude') %} 
$Conf{BackupFilesExclude} = [ {% for excldir in hostinfo['BackupFilesExclude'] %}
  '{{ excldir }}', {% endfor %}
];
{% endif %}
{% if hostinfo.has_key('user') %}
$Conf{RsyncClientCmd} = '$sshPath -q -x -l {{ hostinfo['user'] }} $host $rsyncPath $argList+';
$Conf{RsyncClientRestoreCmd} = '$sshPath -q -x -l {{ hostinfo['user'] }} $host $rsyncPath $argList+';
{% endif %}
