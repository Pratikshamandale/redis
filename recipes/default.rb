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


package "redis-server" do
  action :install
end


cookbook_file "/etc/redis/redis.conf" do
   source "redis.conf"
   owner "root"
   group "root"
   mode 0644
end



service "redis-server" do
        supports :restart => :true
        action [:enable, :start]
end
