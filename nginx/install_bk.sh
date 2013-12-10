#!/bin/sh

source conf.sh

cd $SRC_ROOT_PATH;
rm -rf nginx-0.8.54
tar zxvf nginx-0.8.54.tar.gz
rm -rf pcre-8.01
tar zxvf pcre-8.01.tar.gz

#tar third modules
cd $SRC_ROOT_PATH"/third_modules"
rm -rf headers-more-nginx-module
tar zxvf headers-more-nginx-module.tar.gz

cd $SRC_ROOT_PATH"/nginx-0.8.54"

make clean
./configure \
    --prefix=$INSTALL_PATH  \
    --with-pcre=$SRC_ROOT_PATH"/pcre-8.01" \
    --http-log-path=$INSTALL_PATH"/logs/access_log" \
    --error-log-path=$INSTALL_PATH"/logs/error_log" \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --without-http_userid_module \
    --http-client-body-temp-path=$INSTALL_PATH"/cache/client_body" \
    --http-proxy-temp-path=$INSTALL_PATH"/cache/proxy" \
    --http-fastcgi-temp-path=$INSTALL_PATH"/cache/fastcgi" \
    --http-uwsgi-temp-path=$INSTALL_PATH"/cache/uwsgi" \
    --http-scgi-temp-path=$INSTALL_PATH"/cache/scgi" \
    --add-module=$SRC_ROOT_PATH"/third_modules/headers-more-nginx-module" \
    --add-module=$SRC_ROOT_PATH"/baidu_modules/baidu-usertrack-nginx-module"
