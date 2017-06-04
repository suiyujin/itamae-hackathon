package 'http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm' do
  not_if 'rpm -q mysql-community-release-el6-5'
end

%w(mysql-community-server mysql-community-devel).each do |pkg|
  package pkg
end

service 'mysqld' do
  action [:enable, :start]
end

execute "mysql_secure_installation" do
  user "root"
  only_if "mysql -u root -e 'show databases' | grep information_schema"
  command <<-EOL
    mysqladmin -u root password "#{node[:mysql][:password]}"
    mysql -u root -p#{node[:mysql][:password]} -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -p#{node[:mysql][:password]} -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');"
    mysql -u root -p#{node[:mysql][:password]} -e "DROP DATABASE test;"
    mysql -u root -p#{node[:mysql][:password]} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u root -p#{node[:mysql][:password]} -e "FLUSH PRIVILEGES;"
  EOL
end
