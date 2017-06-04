package 'nginx' do
  action :install
end

service 'nginx' do
  action [:enable, :start]
end

template "/etc/nginx/conf.d/#{node[:rails][:app_name]}.conf" do
  user 'root'
  owner 'root'
  group 'root'
  source 'templates/hackathon.conf.erb'
  variables app_name: node[:rails][:app_name]
  not_if "test -e /etc/nginx/conf.d/#{node[:rails][:app_name]}.conf"
  notifies :reload, 'service[nginx]'
end
