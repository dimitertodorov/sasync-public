class Sasync
  module ServerService
    def find_server_refs_by_ci(ci)
      filter = Filter.new('device',"((vc_string_id EQUAL_TO 2500001) & (vc_string_value EQUAL_TO #{ci}))")
      self.find_server_refs(filter)
    end

    #filter=java string
    def find_server_vos_by_filter(filter)
      my_filter=Filter.new("device", filter)
      my_refs=Array.new
      my_server_vos=Array.new
      my_refs=self.find_server_refs(my_filter)
      self.get_server_vos(my_refs)
    end

    def find_server_refs_by_filter(filter)
      my_filter=Filter.new("device", filter)
      my_refs=Array.new
      my_refs=self.find_server_refs(my_filter)
    end

    def find_one_ref_by_name(name)
      filter=Filter.new("device", "(ServerVO.hostName BEGINS_WITH #{name})")
      refs=Array.new
      refs=self.find_server_refs(filter)
      if refs.count==1 and refs != [nil]
        return {:ref => refs.first, :status => "OK"}
      elsif refs.count > 1
        return {:ref => nil, :status => "Cannot find one ref. More than one server found with #{name}"}
      elsif refs.count == 0
        return {:ref => nil, :status => "Cannot find one ref. No refs found beginning with #{name}"}
      end
    end
  end
end