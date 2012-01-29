#
# Cookbook Name:: ssh_tunnels
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



node[:tunnels2restart].each do |t|

  execute "god restart ssh_tunnel_#{t}"

end


