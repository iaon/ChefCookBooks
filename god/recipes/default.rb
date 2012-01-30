#
# Cookbook Name:: god
# Recipe:: default
#
# Copyright 2012, Ivan Onushkin
#
# All rights reserved - Do Not Redistribute
#

# This needed because those OSes has strange dependency issue after rubygems installation
case node[:platform]
    when "centos","redhat","fedora"
	%w{ruby ruby-devel ruby-ri ruby-rdoc gcc gcc-c++ automake autoconf make}.each do |tool_package|
	    package tool_package
	end
end

#Install ruby gems
package "rubygems" do
    case node[:platform]
	when "centos","redhat","fedora"
	    package_name "rubygems"
	when "debian","ubuntu"
	    package_name "rubygems"
	when "freebsd"
	    package_name "ruby-gems"
	else
	    package_name "rubygems"
    end
    action :install
end

#Install 
gem_package "god" do
    action :install
end

# Create directory for child/custom configuration files
directory "/usr/local/etc/god" do
    owner "root"
    mode  "0755"
    action :create
end

# Parent configuration file that includes /usr/local/etc/god/*
template "/usr/local/etc/god.conf" do
  source "god.conf.erb"
  owner "root"
  mode "0644"
end

# Put init script into appropriate place
case node[:platform]
    when "freebsd"
	template "/usr/local/etc/rc.d/god" do
	    source "god.initrc.erb"
	    owner "root"
	    mode  "0755"
	end
    else 
	template "/etc/init.d/god" do
	    source "god.initrc.erb"
	    owner "root"
	    mode  "0755"
	end
end

# Start god as system service
service "god" do
    supports :status => true, :restart => true
	action [ :enable, :start ]
end
