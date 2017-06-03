node[:users].each do |new_user|
  user new_user do
    home "/home/#{new_user}"
    password '$1$.hmQevXz$VjB0yEn3lQiAZipMN5DZw1'
    action :create
    not_if "id #{new_user}"
  end

  execute 'add wheel group' do
    command "usermod -aG wheel #{new_user}"
    only_if "id #{new_user}"
    not_if "getent group wheel | grep #{new_user}"
  end

  directory ".ssh dir of user" do
    path "/home/#{new_user}/.ssh"
    mode '700'
    user new_user
    owner new_user
    group new_user
    not_if "ls -la /home/#{new_user} | grep .ssh"
  end

  execute 'cp authorized_keys' do
    user 'root'
    ec2_keys = '/home/ec2-user/.ssh/authorized_keys'
    user_keys = "/home/#{new_user}/.ssh/authorized_keys"
    command <<-EOF
    cp #{ec2_keys} #{user_keys}
    chown #{new_user}:#{new_user} #{user_keys}
    EOF
    not_if "test -e /home/#{new_user}/.ssh/authorized_keys"
  end

  execute 'ssh key generate' do
    user new_user
    command "ssh-keygen -t rsa -b 4096 -N '' -f /home/#{new_user}/.ssh/id_rsa"
    not_if "test -e /home/#{new_user}/.ssh/id_rsa"
  end
end

remote_file '/etc/sudoers.d/wheel' do
  user 'root'
  source 'files/wheel'
  mode '440'
  owner 'root'
  group 'root'
  action :create
  not_if "test -e /etc/sudoers.d/wheel"
end
