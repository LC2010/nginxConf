#!/bin/sh

source conf.sh

cd $SRC_ROOT_PATH;
tar -zxvf nginx-1.2.3.tar.gz
tar -zxvf pcre-8.01.tar.gz

#tar third modules
cd $SRC_ROOT_PATH"/third_modules"
rm -rf headers-more-nginx-module
tar zxvf headers-more-nginx-module.tar.gz

cd $SRC_ROOT_PATH"/nginx-1.2.3"

make clean
./configure \
    --prefix=$INSTALL_PATH  \
    --with-pcre=$SRC_ROOT_PATH"/pcre-8.01" \
    --http-log-path=$INSTALL_PATH"/logs/access_log" \
    --error-log-path=$INSTALL_PATH"/logs/error_log" \
    --with-http_ssl_module \
    --with-openssl=$SRC_ROOT_PATH"/openssl-0.9.8l" \
	--with-http_realip_module \
    --with-http_stub_status_module \
    --without-http_userid_module \
    --http-client-body-temp-path=$INSTALL_PATH"/cache/client_body" \
    --http-proxy-temp-path=$INSTALL_PATH"/cache/proxy" \
    --http-fastcgi-temp-path=$INSTALL_PATH"/cache/fastcgi" \
    --http-uwsgi-temp-path=$INSTALL_PATH"/cache/uwsgi" \
    --http-scgi-temp-path=$INSTALL_PATH"/cache/scgi" \
    --add-module=$SRC_ROOT_PATH"/third_modules/headers-more-nginx-module" \
    --add-module=$SRC_ROOT_PATH"/baidu_modules/baidu-usertrack-nginx-module" \
    --with-debug 
make 
make install

echo "make done!";
cd $SRC_ROOT_PATH"/../"
#mkdir & cp conf
rm -rf $INSTALL_PATH"/cache/"
mkdir $INSTALL_PATH"/cache/"
cp -r conf/* $INSTALL_PATH"/conf/"
cp conf_file/nginx_youa.conf $INSTALL_PATH"/conf/nginx.conf"
mkdir -p $INSTALL_PATH"/tmp/proxy_tmp"
mkdir -p $INSTALL_PATH"/data/cache"

#clean
rm -rf $SRC_ROOT_PATH"/nginx-1.2.3"
rm -rf $SRC_ROOT_PATH"/pcre-8.01"
