#
# Cookbook Name:: ssh_tunnels
# Recipe:: default
#
# Copyright 2012
#
# All rights reserved - Do Not Redistribute
#


node[:tunnels2remove].each do |t|
  execute "god_stop_tunnel" do 
	command "god stop ssh_tunnel_#{t}; god remove ssh_tunnel_#{t} "
  end 

  file "/usr/local/etc/god/ssh_tunnel_#{t}.god" do
    action :delete
  end

end


service "god" do
	supports :status => true, :restart => true, :reload => true
	action [:start]
end
