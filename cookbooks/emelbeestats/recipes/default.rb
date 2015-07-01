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

python_pip 'flask'
python_pip 'twilio'
python_pip 'requests'

git '/root/emelbeestats' do
  repository 'git://github.com/codemunkee/emelbee.git'
  revision 'master'
  checkout_branch 'master'
  action :sync
end

cron 'get-standings-json' do
  minute '*/1'
  command '/usr/bin/wget -O /root/emelbeestats/data/standings.json https://erikberg.com/mlb/standings.json'
  user    'root'
end
