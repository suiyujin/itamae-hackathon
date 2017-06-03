include_recipe 'tmux'

execute 'link so file' do
  command 'ln -s /usr/local/lib/libevent-2.1.so.6 /usr/lib64/libevent-2.1.so.6'
end
