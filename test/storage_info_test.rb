require 'java'
require 'rubygems'
require 'lib/sasync'


#eit_ci=Server.all(:types => :all, :where => {:name => "", :ccl2 => 'Server', :status => 2})
#eit_ci=Server.all(:types => :all, :where => {:name.like => "CTSPIKDC%", :ccl2 => 'Server', :status => 2})

Sasync.initialize_encryption!


my_sas_client=Sasync.new

my_sas_client.initialize!

build_servers=my_sas_client.server_service.find_server_refs_by_filter("(ServerVO.hostName CONTAINS emmon)")

build_servers.each do |svr|
  pdisks=my_sas_client.server_service.get_physical_disks(svr)
  pdisks.each do |pd|
    filesystems=my_sas_client.physical_disk_service.get_file_systems(pd)
    filesystems.each do |fsr|
      fsvo=my_sas_client.file_system_service.get_file_system_vo(fsr)
      puts "#{svr.name},#{fsvo.description},#{fsvo.remote},#{fsvo.fileSystemType},#{fsvo.mountPoint}"
    end
  end
end