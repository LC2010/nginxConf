	server {
		listen 8080;
		server_name c.leho.com pad.c.leho.com;
		error_page 400 403 404 405 406 500 501 502 503 504 505 http://i.leho.com/error;
		
                rewrite ^/static/(.*) /static/$1 break;
                include leho_static.conf;
                
                rewrite ^/sns/mcard/(.*) /$1 redirect;
                rewrite ^/(.*)$ /sns/mcard/$1 last;

		location / {
			root /home/mall/youa-php/runroot;
			rewrite ^/(.*)$ /index.php?route=$1 break;
                        include fastcgi_php.conf;
                        fastcgi_pass   youaserver;
		}
                include baidusafe.conf;
	}

