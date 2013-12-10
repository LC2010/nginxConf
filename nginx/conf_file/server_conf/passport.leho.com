
	server {

		listen       8080;
		server_name  passport.leho.com;
		error_page 400 403 404 405 406 500 501 502 503 504 505 http://i.leho.com/error;

                include leho_static.conf;
		
		#rewrite ^/$ /sns/home last;
                rewrite ^/$ /psp/login last;

		location / {
			
			root /home/mall/youa-php/runroot;

                        if ($uri !~ "^/(vcode|data|sns|_private)"){
				rewrite ^/(.*)$ /sns/$1 last;
			}
			rewrite ^/(.*)$ /index.php?route=$1 break;

                        include fastcgi_php.conf;

                        fastcgi_pass   youaserver;
		}

                include baidusafe.conf;
 
	}

