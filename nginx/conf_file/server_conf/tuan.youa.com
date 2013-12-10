#tuan 
	server {

		listen       8080;
		server_name  tuan.youa.com;
		  
		rewrite ^/static/(.*) /static/$1 last;
                include youa_static.conf;   
		rewrite ^/tuan/(.*) /tuan/$1 last;
		rewrite ^/data/(.*) /data/$1 last;
		rewrite ^/passport/(.*) /passport/$1 last;
		rewrite ^/sina_verified_check.txt /picture/sina_verified_check.txt last;
		rewrite ^/(.*) /tuan/$1 last;

		location / {
			root /home/mall/youa-php/runroot;
			rewrite '^/([\d]{3,10}.*?)$' /biz/c$1 last;
			rewrite ^/(.*)$ /index.php?route=$1 break;
		        include fastcgi_php.conf; 
                  	fastcgi_pass   youaserver;
                        
		}
                include baidusafe.conf;
	}


