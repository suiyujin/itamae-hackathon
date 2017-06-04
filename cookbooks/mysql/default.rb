package 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm' do
  not_if 'rpm -q mysql-community-release-el6-5'
end

%w(mysql-community-server mysql-community-devel).each do |pkg|
  package pkg
end

service 'mysqld' do
  action [:enable, :start]
end
