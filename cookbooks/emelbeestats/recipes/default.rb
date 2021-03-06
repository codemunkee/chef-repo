#
# Cookbook Name:: emelbeestats
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

yum_package 'git' do
  action :install
end

yum_package 'screen' do
  action :install
end

yum_package 'sendmail' do
  action :remove
end

yum_package 'postfix' do
  action :install
end

service 'postfix' do
  supports :status => true, :reload => true, :restart => true
  action :start
  subscribes :run, 'yum_package[sendmail]', :immediately
end

python_pip 'flask'
python_pip 'twilio'
python_pip 'requests'
python_pip 'pytest'
python_pip 'pytest-cov'

git '/root/emelbeestats' do
  repository 'git://github.com/codemunkee/emelbee.git'
  revision 'master'
  checkout_branch 'master'
  action :sync
end
