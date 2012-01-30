#
# Cookbook Name:: ssh_tunnels
# Recipe:: remove
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
#


node[:tunnels2remove].each do |t|
#Stop ssh and remove ssh tunnel from god monitoring
  execute "god_stop_tunnel" do 
	command "god stop ssh_tunnel_#{t}; god remove ssh_tunnel_#{t} "
  end 
#Remove god configuration file
  file "/usr/local/etc/god/ssh_tunnel_#{t}.god" do
    action :delete
  end

end

#Ensure that god is up
service "god" do
	supports :status => true, :restart => true, :reload => true
	action [:start]
end
