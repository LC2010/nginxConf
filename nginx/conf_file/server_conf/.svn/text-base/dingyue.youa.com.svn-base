
#dingyue
	server {

		listen     8080;
		server_name dingyue.youa.com dyst.youa.com;
                
                include youa_static.conf;
		
                location / {
			proxy_set_header  HOST  $host;
			proxy_set_header  CLIENTIP      $remote_addr;
			proxy_pass   http://dyserver;
			limit_conn   ip_zone  500;
			limit_req   zone=req_zone  burst=1000;
		}

                include baidusafe.conf;

	}  
