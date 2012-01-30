#
# Cookbook Name:: ssh_tunnels
# Recipe:: default
# Add ssh tunnels
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
#

include_recipe "god"

#Apply ssh tunnel enviroment for each member of the :tunnels array
node[:tunnels].each do |t|

#god configuration preparation
  template "/usr/local/etc/god/ssh_tunnel_#{t[:local_port]}.god" do
    source "ssh_tunnel.god.erb"
    owner "root"
    mode  "0644"
    variables(t)
  end
#reload god service
  service "god" do
	supports :status => true, :restart => true, :reload => true
	action [:reload]
  end
#start tunnel as god subprocess
  execute "god_start_tunnel" do
        command "god start ssh_tunnel_#{t[:local_port]}"
  end

end


