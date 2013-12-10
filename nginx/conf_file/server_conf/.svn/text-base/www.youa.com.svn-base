        server {

		listen       8080;
		server_name  www.youa.com;

		rewrite ^/(shop|item|order)(.*) http://youa.baidu.com/$1$2 redirect;
		rewrite ^/$  http://s.leho.com/ redirect;
		rewrite ^/\?(.*) /content/service/index.html?$1 last;
		rewrite ^/jipiao$ /content/flight/promo/kuxun/index.html last;
		rewrite ^/jipiao\?(.*) /content/flight/promo/kuxun/index.html?$1 last;
		rewrite ^/jipiao/farp.htm$ /static/com/frame_auto_resize_proxy.htm last;

                rewrite ^/mylife/(.*) http://s.leho.com/mylife/$1 redirect;
                rewrite ^/myshop/(.*) http://s.leho.com/myshop/$1 redirect;	     
                rewrite ^/youhui(.*) http://s.leho.com/youhui$1 redirect;
                rewrite ^/chainbrand(.*) http://s.leho.com/chainbrand$1 redirect;

                rewrite ^/(.*)/(bbs|item|shopcomment|msg)/(.*)$ /$1 last;
                
                include youa_static.conf;

		location /suggest {
			proxy_pass http://suggestserver;
		}

		location / {
			root /home/mall/youa-php/runroot;
                   
                        rewrite '^/([\d]{3,10}.*?)$' http://s.leho.com/$1  redirect;    
                        rewrite /biz/(.*)$ http://s.leho.com/biz/$1 redirect;                 
			rewrite ^/(.*)$ /index.php?route=$1 break;
                        include fastcgi_php.conf;
                 	fastcgi_pass   youaserver;
		}

                include baidusafe.conf;
	}


