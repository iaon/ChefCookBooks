#
# Cookbook Name:: god
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


case node[:platform]
    when "centos","redhat","fedora"
	%w{ruby ruby-devel ruby-ri ruby-rdoc gcc gcc-c++ automake autoconf make}.each do |tool_package|
	    package tool_package
	end
end

package "rubygems" do
    case node[:platform]
	when "centos","redhat","fedora"
	    package_name "rubygems"
	when "debian","ubuntu"
	    package_name "rubygems"
	when "freebsd"
	    package_name "ruby18-gems"
	else
	    package_name "rubygems"
    end
    action :install
end


gem_package "god" do
    action :install
end

directory "/usr/local/etc/god" do
    owner "root"
    group "root"
    mode  "0755"
    action :create
end


template "/usr/local/etc/god.conf" do
  source "god.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

case node[:platform]
    when "freebsd"
	template "/usr/local/etc/rc.d/god" do
	    source "god.initrc.erb"
	    owner "root"
	    group "root"
	    mode  "0755"
	end
    else 
	template "/etc/init.d/god" do
	    source "god.initrc.erb"
	    owner "root"
	    group "root"
	    mode  "0755"
	end
end

service "god" do
    supports :status => true, :restart => true
	action [ :enable, :start ]
end
