server{
	listen 8080;
	server_name tuiguang.youa.com;
	
	rewrite ^[/]?$ /content/services/index.html last;	                        
	location ~ ^/(content|picture) {
		root /home/work/htdocs/tuiguang;
		index index.html index.htm default.htm;
		limit_conn ip_zone 500;
		limit_req zone=req_zone burst=2000;
	}

	location / {
		root /home/mall/mall-php/lib/index;
		rewrite ^/(.*)$ /index.php?route=$1 break;
		include        fastcgi_php.conf;
		fastcgi_pass   youaserver;
	}       

	include baidusafe.conf;
}

