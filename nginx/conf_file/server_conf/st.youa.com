server {

				listen       8080;
				server_name  st.youa.com;
#�������������
				if ($ancient_browser = "ancient.")
				{
#keepalive_timeout 0;
				}
#������
				if ($http_referer ~ "http//.*\.youalife\.com") {

						rewrite ^[/]?(.*)$ http://www.youa.com/ redirect;

				}
#�ٶȰ�ȫ��׼
				if ($host !~ "\.baidu\.com$|\.youa\.com$||\.youa\.com\:|\.baidu\.com\:|\.baidu\.com\.cn$|\.baidu\.com\.cn\:|\.baidu\.cn$|\.baidu\.cn\:|^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$|^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:") {       
						rewrite ^/(.*)$ http://error.baidu.com/errorname.html?url=%1&fr=xxx redirect;
				}  
		rewrite ^/crossdomain.xml /static/crossdomain.xml last;
		rewrite ^/robots.txt /static/robots.txt last;
		rewrite ^/sitemapCat.txt /static/sitemapCat.txt last;
		rewrite ^/favicon.ico /static/favicon.ico last;


				location / {
						root /home/work/htdocs;
						rewrite ^/resource/(.*) /resource/services/$1 break;
						rewrite ^/(item|shop|search)/(.*)$ http://www.youa.com/$1 permanent;
  						expires 24h;  
            			if ($uri ~ ^/content)
            			{
                 			expires 1h;
            			}
						limit_conn   ip_zone  500;
						limit_req   zone=req_zone  burst=2000;
				}

#�ٶȰ�ȫ��׼   
				location /nginx-status {
						stub_status     on;
						access_log      off;
						allow 127.0.0.1; #�˴�������Ϊ������������IP��ַ������������Ϊ������칫����ַ
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
		
