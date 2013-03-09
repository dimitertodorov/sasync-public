require 'java'
require 'rubygems'
require 'lib/sasync'


#eit_ci=Server.all(:types => :all, :where => {:name => "", :ccl2 => 'Server', :status => 2})
#eit_ci=Server.all(:types => :all, :where => {:name.like => "CTSPIKDC%", :ccl2 => 'Server', :status => 2})

Sasync.initialize_encryption!


my_sas_client=Sasync.new

my_sas_client.initialize!

my_sas_client.create_lock_device_group(5280001,"TEST_LOCKED",5270001)
