#
# Cookbook Name:: ssh_tunnels
# Recipe:: restart
#
# Copyright 2012, Ivan Onushkin
#
# All rights reserved - Do Not Redistribute
#


#Do restart for each ssh tunnel ID in :tunnels2restart array
node[:tunnels2restart].each do |t|
#restart ssh tunnel by god
  execute "god restart ssh_tunnel_#{t}"

end


