class Sasync
  module HpsaTools
    def update_management_ip(mid,mgmt_ip)
      ss=self.server_service
      new_server_vo=ServerVO.new()
      server_ref=ServerRef.new(mid)
      new_server_vo.managementIP=mgmt_ip
      svo = ss.update(server_ref, new_server_vo, true, true)
      puts "updates #{svo.name}"
    end
  end

  def create_lock_device_group(source_group_id,short_name,parent_id)
    dgs=self.device_group_service
    dg_ref=DeviceGroupRef.new(source_group_id)
    new_dg_vo=dgs.getDeviceGroupVO(dg_ref)
    pg_ref=DeviceGroupRef.new(parent_id)
    puts new_dg_vo.fullName
    new_dg_vo.parent=pg_ref
    new_dg_vo.shortName=short_name
    new_dg_vo.setLocked(true)
    nvo=dgs.create(new_dg_vo)
    puts "Creating locked Group #{nvo.name}"
  end
end