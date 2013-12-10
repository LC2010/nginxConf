
	server{
		listen       8080;
		server_name  kefu.youa.com ;

		rewrite ^/$ http://www.youa.com/?refer=kefu redirect;
                include youa_static.conf;    
		location /kefu {
			root /home/mall/youa-php/runroot;
   			rewrite ^/(.*)$ /index.php?route=$1 break;
                        include fastcgi_php.conf; 
                        fastcgi_pass   youaserver; 		
		}

		location / {
			rewrite ^/(.*)$ /kefu?alias=$1 last;
		}

                include baidusafe.conf;  
	}


