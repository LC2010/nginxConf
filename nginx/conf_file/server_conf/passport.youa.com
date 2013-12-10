      	server {
		listen       8080;  
		server_name  passport.youa.com;
		rewrite ^/(.*) https://passport.youa.com/$1 permanent;
	}
	server {
		listen       8443 ssl;
		server_name  passport.youa.com;

                rewrite ^/$ /passport/login last;
		rewrite ^/(shop|item|order)(.*) http://youa.baidu.com/$1$2 redirect;
		#rewrite ^/$ /content/service/index.html last;
		rewrite ^/\?(.*) /content/service/index.html?$1 last;
		rewrite ^/jipiao$ /content/flight/promo/kuxun/index.html last;
		rewrite ^/jipiao\?(.*) /content/flight/promo/kuxun/index.html?$1 last;
		rewrite ^/jipiao/farp.htm$ /static/com/frame_auto_resize_proxy.htm last;

		rewrite ^/content/(.*) /content/service/$1 last;
		rewrite ^/resource/(.*) /resource/services/$1 last;

                include youa_static.conf;

		location / {
			root /home/mall/youa-php/runroot;
			rewrite '^/([\d]{3,10}.*?)$' /biz/c$1 last;       
			rewrite ^/(.*)$ /index.php?route=$1 break;

                        include fastcgi_php.conf;
 	                fastcgi_pass   youaserver;
        	}
		
               
                include baidusafe.conf;
	}


