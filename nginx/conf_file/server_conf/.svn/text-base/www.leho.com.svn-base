	server {

		listen 8080;
		server_name www.leho.com;
		error_page 400 403 404 405 406 500 501 502 503 504 505 http://i.leho.com/error;

                include leho_static.conf;

		rewrite ^/aboutus /help/other?type=aboutus last;
		rewrite ^/contactus /help/other?type=contactus last;
		rewrite ^/policy /help/other?type=policy last;
		rewrite ^/privacy /help/other?type=privacy last;
		rewrite ^/verify /sns/help/verify last;                

		rewrite ^/$ /sns/index/main last;

		location / {
#rewrite "^/([^/]+)$" /sns/profile/$1 break;
			rewrite "^/([^/]{24})$" /sns/home/$1 last;
			if ($uri !~ "^/(vcode|data|sns|_private)"){
				rewrite ^/(.*)$ /sns/$1 last;
			}
			root /home/mall/youa-php/runroot;
			rewrite '^/([\d]{3,10}.*?)$' /biz/c$1 last;
			rewrite ^/(.*)$ /index.php?route=$1 break;

                        include fastcgi_php.conf;
                        fastcgi_pass   youaserver;
		} 
                include baidusafe.conf;
	}


