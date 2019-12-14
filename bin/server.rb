#!/usr/bin/env ruby  
require 'pathname'  
require 'fileutils'  
include FileUtils  
# path to your application root.  
APP_ROOT = Pathname.new File.expand_path('..', __dir__)  
def system!(*args)  
  system(*args) || abort("\n== Command #{args} failed ==")  
end  
chdir APP_ROOT do  
  puts "\n== Removing pid =="  
  system! 'rm -f /opt/tmp/pids/server.pid'  
  # puts "\n== Installing Gems =="  
  # system! 'bin/bundle install'  
  # puts "\n== Installing JavaScript dependencies =="  
  # system! 'bin/yarn install'  
  puts "\n== Compile Assets =="  
  system! 'rake assets:precompile'
  puts "\n== DB Migration =="  
  system! 'rake db:migrate'
  puts "\n== Starting server =="  
  system! 'bundle exec rails s -b 0.0.0.0 -p 3000'  
end