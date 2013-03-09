class Sasync
  class ServerVO


    #MonkeyPatched methods
    def short_host_name
      hostName.split('.')[0].to_s.upcase
    end

    def custom_fields(ss)
      ss.get_custom_fields(self.getRef)
    end

    #JSON Serialization override.
    def to_json(*a)
      {
          'class_name'	=>	self.class.name,
          'short_host_name' => short_host_name,
          'name'	=>	name,
          'state'	=>	state,
          'locale'	=>	locale,
          'realm'	=>	realm.name,
          'use'	=>	use,
          'platform'	=>	platform.name,
          'mid'	=>	mid,
          'agentVersion'	=>	agentVersion,
          'stage'	=>	stage,
          'opswLifecycle'	=>	opswLifecycle,
          'defaultGw'	=>	defaultGw,
          'hypervisor'	=>	hypervisor,
          'osFlavor'	=>	osFlavor,
          'virtualizationType'	=>	virtualizationType,
          'customer'	=>	customer.name,
          'facility'	=>	facility.name,
          'discoveredDate'	=>	discoveredDate,
          'loopbackIP'	=>	loopbackIP,
          'managementIP'	=>	managementIP,
          'netBIOSName'	=>	netBIOSName,
          'peerIP'	=>	peerIP,
          'reporting'	=>	reporting,
          'osSPVersion'	=>	osSPVersion,
          'previousSWRegDate'	=>	previousSWRegDate,
          'hostName'	=>	hostName,
          'description'	=>	description,
          'osVersion'	=>	osVersion,
          'serialNumber'	=>	serialNumber,
          'primaryIP'	=>	primaryIP,
          'manufacturer'	=>	manufacturer,
          'model'	=>	model,
          'modifiedBy'	=>	modifiedBy,
          'modifiedDate'	=>	modifiedDate,
          'logChange'	=>	logChange,
          'createdBy'	=>	createdBy,
          'createdDate'	=>	createdDate
      }.to_json(*a)
    end
  end
end