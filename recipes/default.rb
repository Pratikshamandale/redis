#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute 'apt-get update' do
  command "sudo apt-get update"
  action :run
end


#install the 'Development tools' package group
%w[build-essential libpcre3 libpcre3-dev openssl libssl-dev unzip].each do |pkg|
  package pkg do
    action :install
  end
end


package 'redis' do
  action :install
end

template "/etc/redis/redis.conf" do
        source "redis.conf.erb"
        variables({
                :web_server_ip => node['redis']['web_server_ip'],
                :active_mq_server_ip => node['redis']['active_mq_server_ip'] ,
        })
        notifies :restart, "service[redis]"
end
