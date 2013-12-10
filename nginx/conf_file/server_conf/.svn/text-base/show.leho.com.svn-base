server {
	listen 8080;
	server_name show.leho.com;
	error_page 400 403 404 405 406 500 501 502 503 504 505 http://show.leho.com/error;

	include leho_static.conf;

	rewrite ^/$ /sns/show/main last;
	rewrite ^/show/(.*)$ /sns/show/$1 last;

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
