        server {

		listen       8080;
		server_name  s.leho.com;
                error_page 400 403 404 405 406 500 501 502 503 504 505 http://www.leho.com/error;
		
                rewrite ^/$ /content/shangjie/beijing/index.html last;
		rewrite ^/\?(.*) /content/service/index.html?$1 last;
		rewrite ^/jipiao$ /content/flight/promo/kuxun/index.html last;
		rewrite ^/jipiao\?(.*) /content/flight/promo/kuxun/index.html?$1 last;
		rewrite ^/jipiao/farp.htm$ /static/com/frame_auto_resize_proxy.htm last;
                rewrite ^/biz/(.*)$ http://s.leho.com/shop/$1 redirect;
                rewrite ^/beijing/youhui(.*)$ /base/youhui$1 last;

                include leho_static.conf;

		location /suggest {
			proxy_pass http://suggestserver;
		}

		location / {
			root /home/mall/youa-php/runroot;
			
                        rewrite '^/([\d]{3,10}.*?)$' /base/shop/~$1 last;   
                        rewrite ^/shop/(.*)$ /base/shop/$1 last;
                        rewrite ^/youhui(.*)$ /base/youhui$1 last;
                        rewrite ^/search/(.*) /base/search/$1 last;
                        rewrite ^/list(.*)$ /base/search/list$1 last;
                        rewrite ^/pr-list/(.*)$ /base/search/pr-list/$1 last; 
			rewrite ^/(.*)$ /index.php?route=$1 break;
                        
                        include fastcgi_php.conf;
                 	fastcgi_pass   youaserver;
		}

                include baidusafe.conf;
	}


