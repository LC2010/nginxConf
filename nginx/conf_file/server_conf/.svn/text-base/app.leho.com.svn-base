	server {
		listen 8080;
		server_name app.leho.com;
		error_page 400 403 404 405 406 500 501 502 503 504 505 http://i.leho.com/error;
		
                include leho_static.conf;
                rewrite ^/$ /sns/app/ last;
                rewrite ^/apps/(.*)$ /content/tpl_inc/sns/app/apps/$1 last;
                rewrite ^/detail/(.*)$ /sns/app/detail?name=$1 last;
                rewrite ^(.*)\.txt$ /content/tpl_inc/sns/app/apps/txt/$1.txt last;
		rewrite ^(.*)$ /sns/app/$1 last;

		location / {
			root /home/mall/youa-php/runroot;
			rewrite ^/(.*)$ /index.php?route=$1 break;
                        include fastcgi_php.conf;
                        fastcgi_pass   youaserver;
		}
                include baidusafe.conf;
	}
