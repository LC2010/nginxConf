server {
	listen 8080;
	server_name m.leho.com;
	error_page 400 403 404 405 406 500 501 502 503 504 505 http://www.leho.com/error;

	include leho_static.conf;

	rewrite ^/(.*)$ /help/client$1;

        #rewrite ^/$ /sns/mobile last;
        #rewrite ^/mobile/(.*)$ /sns/mobile/$1 last;

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
