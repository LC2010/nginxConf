server {

		listen       8080;
		server_name  .leho.com;
		error_page 400 403 404 405 406 500 501 502 503 504 505 http://i.leho.com/error;

		if ($host !~ "i\.leho\.com$|u\.leho\.com$|app\.leho\.com$")
		{       
			rewrite ^/(.*)$ http://i.leho.com/$1 redirect;
		}       

		if ($host = u.leho.com) {
			rewrite "^[/]?([0-9a-zA-Z]{6})$"   http://u.leho.com/slink?_sk=$1  last;
		}

                include leho_static.conf;

		rewrite ^/aboutus /help/other?type=aboutus last; 
		rewrite ^/contactus /help/other?type=contactus last;
		rewrite ^/policy /help/other?type=policy last;
		rewrite ^/privacy /help/other?type=privacy last;
                rewrite ^/mobile(.*)$ /help/client$1  last;
                rewrite ^/verify /sns/help/verify last;
		
                rewrite ^/$ /sns/home last;

		location /suggest {
			proxy_pass http://suggestserver;	
		}

		location / {
#rewrite "^/([^/]+)$" /sns/profile/$1 break; 
			rewrite "^/([^/]{24})$" /sns/home/$1 last; 
			if ($uri !~ "^/(vcode|data|sns|_private|slink)"){
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
