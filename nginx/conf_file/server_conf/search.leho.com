
#search
	server {

		listen       8080;
		server_name  search.leho.com;
                error_page 400 403 404 405 406 500 501 502 503 504 505 http://www.leho.com/error;
                rewrite ^/static/(.*) /static/$1 last;   
                include leho_static.conf;   

		rewrite ^[/]?$ http://www.leho.com/ redirect;
                rewrite ^/list(.*)$ /base/search/list$1 last;
                rewrite ^/search/(.*) /base/search/$1 last;
                rewrite ^/base/search/(.*) /base/search/$1 last;

                rewrite ^/bj/?$ /bj/ last;
		rewrite ^/bj/([^/]*)/?([^/]*)/?$ /search/list?city=bj&cat=$1&loc=$2 last;
		rewrite ^/data/(.*) /data/$1 last;
		rewrite ^/passport/(.*) /passport/$1 last;
		rewrite ^/(.*) /base/search/$1 last;

		location / {
			root /home/mall/youa-php/runroot;
			rewrite '^/([\d]{3,10}.*?)$' /biz/c$1 last;
			rewrite ^/(.*)$ /index.php?route=$1 break;
		        include fastcgi_php.conf;
                	fastcgi_pass   youaserver;
		}
                
                include baidusafe.conf;
	}


