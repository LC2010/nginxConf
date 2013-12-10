 
	server {
		listen       8080;
		server_name  zhaopin.youa.com hr.youa.com;
		
                include youa_static.conf; 
		location ~ / {
			root /home/work/htdocs/content/zhaopin;
			index index.html index.htm default.htm;
			expires 2h;
			limit_conn   ip_zone  500;
			limit_req   zone=req_zone  burst=2000;
		}

		include baidusafe.conf;
	} 


