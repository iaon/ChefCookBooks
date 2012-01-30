#Restart all ssh tunnels (as  ssh_tunnels god group)
  execute "god_restart_tunnels" do
        command "god restart ssh_tunnels"
  end

