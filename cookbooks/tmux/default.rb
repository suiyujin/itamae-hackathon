include_recipe 'tmux'

execute 'link so file' do
  from_file = '/usr/local/lib/libevent-2.1.so.6'
  to_file = '/usr/lib64/libevent-2.1.so.6'
  command "ln -s #{from_file} #{to_file}"
  not_if "test -e #{to_file}"
end
