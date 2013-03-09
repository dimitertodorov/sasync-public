require 'java'
require 'rubygems'
require 'lib/sasync'


#eit_ci=Server.all(:types => :all, :where => {:name => "", :ccl2 => 'Server', :status => 2})
#eit_ci=Server.all(:types => :all, :where => {:name.like => "CTSPIKDC%", :ccl2 => 'Server', :status => 2})

Sasync.initialize_encryption!


my_sas_client=Sasync.new

my_sas_client.initialize!

build_servers=my_sas_client.server_service.find_server_refs_by_filter("((device_customer_id EQUAL_TO 9)&((ServerVO.stage NOT_IN LIVE,UNKNOWN,OFFLINE)))")

build_servers.each do |svr|
  puts "#{svr.name}"
end