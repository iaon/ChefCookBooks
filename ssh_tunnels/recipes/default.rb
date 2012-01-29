#
# Cookbook Name:: ssh_tunnels
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
#

include_recipe "god"


node[:tunnels].each do |t|

  template "/usr/local/etc/god/ssh_tunnel_#{t[:local_port]}.god" do
    source "ssh_tunnel.god.erb"
    owner "root"
    group "root"
    mode  "0644"
    variables(t)
  end
  service "god" do
	supports :status => true, :restart => true, :reload => true
	action [:reload]
  end
  execute "god_start_tunnel" do
        command "god start ssh_tunnel_#{t[:local_port]}"
  end

end


