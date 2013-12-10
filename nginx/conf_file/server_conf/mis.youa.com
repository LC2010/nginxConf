#mis
	server {

		listen     8080;
		server_name mis.youa.com mis88.youa.com mis87.youa.com mis86.youa.com mis89.youa.com;

		#allow 172.22.0.0/16;
		#allow 61.135.165.128/25;
		#allow 220.181.50.192/26;
		#allow 221.221.33.243;
		#allow 118.186.253.128/26;
		#deny all;

		set $mis_port '8888';
		if ($host ~ "mis88\.youa\.com|mis\.youa\.com"){
			set $mis_port '8888';
		}
		if ($host ~ "mis87.youa.com"){
			set $mis_port '8887';
		}
		if ($host ~ "mis86\.youa\.com"){
			set $mis_port '8886';
		}
		if ($host ~ "mis89\.youa\.com"){
			set $mis_port '8889';
		}

		location / {
			proxy_set_header  HOST  $host;
			proxy_set_header  CLIENTIP      $remote_addr;
#proxy_pass   http://misserver;
			proxy_pass   http://10.65.26.21:$mis_port; #jx-eb-youa-mis00.jx 
			limit_conn   ip_zone  500;
			limit_req   zone=req_zone  burst=1000;

		}
                include baidusafe.conf;

	}


