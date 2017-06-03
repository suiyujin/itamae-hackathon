package 'zsh' do
  action :install
end

node[:zsh_users].each do |zsh_user|
  remote_file "/home/#{zsh_user}/.zshenv" do
    user 'root'
    source 'files/.zshenv'
    mode '755'
    owner zsh_user
    group zsh_user
    action :create
    not_if "test -e /home/#{zsh_user}/.zshenv"
  end

  execute 'change default shell to zsh' do
    user 'root'
    command "chsh -s $(which zsh) #{zsh_user}"
    not_if "test '/bin/zsh' = $(grep #{zsh_user} /etc/passwd | cut -d: -f7)"
  end
end
