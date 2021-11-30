
# Mac 安装md5sum等

一、安装md5sum

方案1、使用brew 安装

![[./_resources/Mac_安装md5sum等_-_茄子_2008_-_博客园.resources/45148-20170620171521976-1297138228.png]]

方案2、使用源码编译安装

源码下载地址：<http://www.microbrew.org/tools/md5sha1sum/md5sha1sum-0.9.5.tar.gz>

 # tar xvfz md5sha1sum-0.9.5.tar.gz  

# cd md5sha1sum-0.9.5   

# ./configure  

# make   

# make install  

二、安装md5deep和sha1deep

源码下载地址：<https://github.com/jessek/hashdeep/archive/release-4.4.tar.gz>

 # tar xfvz hashdeep-release-4.4.tar.gz  

# cd hashdeep-release-4.4  

# sh bootstrap.sh  

# ./configure  

# make  

# make install  

在执行sh bootstrap.sh时，提示aclocal不存在，则可以先使用homebrew安装automake

 # brew install automake  

Measure
Measure

    Created at: 2019-09-11T10:17:18+08:00
    Updated at: 2019-09-11T10:17:18+08:00

