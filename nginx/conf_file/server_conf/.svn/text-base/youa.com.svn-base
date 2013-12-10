   server {
           listen       8080;
           server_name  .youa.com;
        
           if ($ancient_browser = "ancient.")
           {
                 # keepalive_timeout 0;
           }
            
           if ($http_referer ~ "http//.*\.youalife\.com") {

                 rewrite ^[/]?(.*)$ http://www.youa.com/ redirect;

           }
          
           set $wap_cookie "";
           if ($http_cookie ~* ^(.*)BDUSS=(.*)$)
           {
                set $wap_cookie '1';
           }

           if ($host ~ ^(life\.|beijing\.)?youa.com$) {
                rewrite ^/newpage(.*) http://www.youa.com$1 redirect;
                rewrite ^/(.*)$ http://www.youa.com/$1 redirect;
           }
    
           if ($host !~ "\.baidu\.com$|\.youa\.com$||\.youa\.com\:|\.baidu\.com\:|\.baidu\.com\.cn$|\.baidu\.com\.cn\:|\.baidu\.cn$|\.baidu\.cn\:|^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$|^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:") {	   
                rewrite ^/(.*)$ http://error.baidu.com/errorname.html?url=%1&fr=xxx redirect;
	      } 

           rewrite ^/$  http://s.leho.com/ redirect;  
           rewrite ^/(.*) /newpage/$1 last;
         
           location ~ ^/(content|static|mis_static|xcontent|resource|picture) {
                index index.html index.htm default.htm;
                expires 24h;
                if ($uri ~ ^/content) 
                { 
                    expires 1h;
                }
                limit_conn   ip_zone  500;
                limit_req   zone=req_zone  burst=2000;
           }



           location / {
                root /home/mall/youa-php/runroot; 
                rewrite ^/(.*)$ /index.php?route=$1 break;
                include        fastcgi.conf;
                
                if ($request_uri ~ (.*)\?.*){  
                       #     set $xxx $1;
                } 
                fastcgi_param   SCRIPT_URL /$1;
                fastcgi_param   SCRIPT_URI http://$host:$server_port/$1;
                fastcgi_param   SCRIPT_NAME /$1; 
                
        #         fastcgi_cache_bypass $wap_cookie;
         #       fastcgi_cache_bypass $cookie_nocache  $arg_nocache$arg_comment;
         #       fastcgi_cache_bypass $http_pragma     $http_authorization;
                fastcgi_pass   youaserver;
                limit_conn   ip_zone  500;
                limit_req   zone=req_zone  burst=500;
           }

           #安全标准
     	   location /nginx-status {
	            stub_status     on;			
   	            access_log      off;
	            allow 127.0.0.1; #此处可配置为其它内网机器IP地址，但不能配置为外网或办公网地址
	            allow 10.65.26.15; #jx-eb-mall-mis00.jx
                    allow 10.65.26.21; #jx-eb-youa-mis00.jx
                    allow 10.81.7.138; #db-sierra64.db01
                    deny  all;		  
           }

	       location ~* \.(sql|bak|inc|old)$ {
	            return 403;
	       }		 

           location ^~ /upload/ {
	        if ($request_filename  !~* \.(jpg|jpeg|gif|png|swf|zip|rar|txt)$) {
		    return 403;			
	        }
		alias   /home/work/path/to/upload/;
  	  }

    }
