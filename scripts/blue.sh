#!/usr/bin/env bash
sudo apt-get update -y
sudo apt-get install -y nginx

cat <<EOM > /var/www/html/index.nginx-debian.html
<html>
<head>
<title>Welcome to BLUE</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
        background-color:blue;
    }
</style>
</head>
<body>
<h1>Welcome to BLUE</h1>
</body>
</html>
EOM

sudo service nginx restart
