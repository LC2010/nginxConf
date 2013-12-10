#data.youa.com
	server {

		listen     8080;
		server_name data.youa.com;

		allow 172.22.0.0/16;
		allow 61.135.165.128/25;
		allow 220.181.50.192/26;
		allow 221.221.33.243;
		allow 118.186.253.128/26;
		deny all;

		location / {
			proxy_set_header  HOST  $host;
			proxy_set_header  CLIENTIP      $remote_addr;
			proxy_pass   http://10.65.26.43:8888; #jx-eb-youa-sdb00.jx.baidu.com
			limit_conn   ip_zone  500;
			limit_req   zone=req_zone  burst=1000;

		}
                include baidusafe.conf;

	}


