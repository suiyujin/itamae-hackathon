directory '/var/www' do
  user 'root'
  owner 'root'
  group 'root'
  not_if 'test -d /var/www'
end

directory "/var/www/#{node[:rails][:app_name]}" do
  user 'root'
  owner 'deploy'
  group 'deploy'
  not_if "test -d /var/www/#{node[:rails][:app_name]}"
end
