module Sasync::HpsaPatchTools
  class << self
    def sas_client=(sas_client)
      @@sas_client=(sas_client)
    end

    def initialize!(sas_client)
      @@sas_client=sas_client
    end

    def sas_client
      @@sas_client
    end

    #Returns platforms based on filter.
    def get_platform_refs(filter)
      begin
        platform_refs=sas_client.platform_service.find_platform_refs(filter)
        return platform_refs
      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end
    end

    #Needed to convert time to HPSA format Epoch in Milliseconds
    def convert_to_epoch(date_time_string)
      begin
        date_time=(DateTime.strptime(date_time_string,'%Y%m%d.%H%M%S'))
        epoch_time=((date_time.to_time.to_f) * 1000.0).to_i
        return epoch_time
      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end
    end

    def get_update_rollups_by_filter(filter,bulletins_only, product_filter_regexp=nil)
      begin
        refs=sas_client.update_rollup_service.find_update_rollup_refs(filter)
        if (bulletins_only==true) & (product_filter_regexp==nil)
          out_refs=Array.new()
          refs_vos=sas_client.update_rollup_service.get_update_rollup_vos(refs)
          refs_vos.each do |hfvo|
            if hfvo.bulletinId != nil
              out_refs << hfvo.get_ref
            end
          end
          return out_refs
        elsif (product_filter_regexp !=nil) & (bulletins_only==true)
          out_refs=Array.new()
          refs_vos=sas_client.update_rollup_service.get_update_rollup_vos(refs)
          refs_vos.each do |hfvo|
            hfaps=hfvo.affectedProducts.to_a.join(', ')
            if (hfvo.bulletinId != nil) & (hfaps.match(product_filter_regexp))
              out_refs << hfvo.get_ref
            end
          end
          return out_refs
        elsif (bulletins_only==false) & (product_filter_regexp!=nil)
          out_refs=Array.new()
          refs_vos=sas_client.update_rollup_service.get_update_rollup_vos(refs)

          refs_vos.each do |hfvo|
            hfaps=hfvo.affectedProducts.to_a.join(', ')
            if (hfaps.match(product_filter_regexp))
              out_refs << hfvo.get_ref
            end
          end
          return out_refs
        else
          return refs
        end
      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end
    end


    def get_hotfixes_by_filter(filter,bulletins_only, product_filter_regexp=nil)
      begin
        refs=sas_client.hotfix_service.find_hotfix_refs(filter)
        if (bulletins_only==true) & (product_filter_regexp==nil)

          out_refs=Array.new()
          refs_vos=sas_client.hotfix_service.get_hotfix_vos(refs)
          refs_vos.each do |hfvo|
            if hfvo.bulletinId != nil
              out_refs << hfvo.get_ref
            end
          end
          return out_refs
        elsif (product_filter_regexp !=nil) & (bulletins_only==true)
          out_refs=Array.new()
          refs_vos=sas_client.hotfix_service.get_hotfix_vos(refs)

          refs_vos.each do |hfvo|
            hfaps=hfvo.affectedProducts.to_a.join(', ')
            if (hfvo.bulletinId != nil) & (hfaps.match(product_filter_regexp))
              #puts "#{hfvo.name},#{hfvo.bulletinId},#{hfaps}"
              out_refs << hfvo.get_ref
            end
          end
          return out_refs

        elsif (bulletins_only==false) & (product_filter_regexp!=nil)
          out_refs=Array.new()
          refs_vos=sas_client.hotfix_service.get_hotfix_vos(refs)

          refs_vos.each do |hfvo|
            hfaps=hfvo.affectedProducts.to_a.join(', ')
            if (hfaps.match(product_filter_regexp))
              #puts "#{hfvo.name},#{hfvo.bulletinId},#{hfaps}"
              out_refs << hfvo.get_ref
            end
          end
          return out_refs

        else
          return refs
        end

      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end
    end

    def get_service_packs_by_filter(filter,bulletins_only, product_filter_regexp=nil)
      begin
        refs=sas_client.service_pack_service.find_service_pack_refs(filter)
        if (bulletins_only==true) & (product_filter_regexp==nil)

          out_refs=Array.new()
          refs_vos=sas_client.service_pack_service.get_service_pack_vos(refs)
          refs_vos.each do |hfvo|
            if hfvo.bulletinId != nil
              out_refs << hfvo.get_ref
            end
          end
          return out_refs
        elsif (product_filter_regexp !=nil) & (bulletins_only==true)
          out_refs=Array.new()
          refs_vos=sas_client.service_pack_service.get_service_pack_vos(refs)

          refs_vos.each do |hfvo|
            hfaps=hfvo.affectedProducts.to_a.join(', ')
            if (hfvo.bulletinId != nil) & (hfaps.match(product_filter_regexp))
              out_refs << hfvo.get_ref
            end
          end
          return out_refs

        elsif (bulletins_only==false) & (product_filter_regexp!=nil)
          out_refs=Array.new()
          refs_vos=sas_client.service_pack_service.get_service_pack_vos(refs)

          refs_vos.each do |hfvo|
            hfaps=hfvo.affectedProducts.to_a.join(', ')
            if (hfaps.match(product_filter_regexp))
              puts "#{hfvo.name},#{hfvo.bulletinId},#{hfaps}"
              out_refs << hfvo.get_ref
            end
          end
          return out_refs

        else
          return refs
        end

      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end
    end


    def create_windows_patch_policy(policy_name, platform_ref, description)
      begin
        wpps=sas_client.windows_patch_policy_service
        filter = Sasync::Filter.new()
        filter.expression="(patch_policy_name = \"#{policy_name}\")"
        puts filter.expression
        policy_refs=wpps.find_windows_patch_policy_refs(filter)
        if policy_refs.count > 0
          return policy_refs
        else
          wppvo = Sasync::WindowsPatchPolicyVO.new()
          wppvo.name=policy_name
          wppvo.platform=platform_ref
          wppvo.type = 'STATIC'
          wppvo.description = description
          wppvo.dirtyAttributes = ['name','platform','type','description']
          wppvo = wpps.create(wppvo)
        end
        policy_refs=wpps.find_windows_patch_policy_refs(filter)
        return policy_refs
      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end
    end

    def add_to_patch_policy_by_patch_refs(policy_refs, patch_refs)
      begin
        wpps=sas_client.windows_patch_policy_service
        puts policy_refs
        puts patch_refs
        wpps.add_patches(policy_refs, patch_refs)
        return policy_refs
      rescue
        Sasync.logger.error "Error during - #{__method__}"
        return nil
      end

    end

    def create_os_patch_policies(start_date, policy_date, bulletins_only=true, policy_custom_name=nil)

    end

    def create_patch_policies(start_date, policy_date, bulletins_only=true, policy_custom_name=nil, product_filter_regexp=nil)
      filter=Sasync::Filter.new()
      filter.expression= '(platform_name CONTAINS "Windows") & (platform_name NOT_CONTAINS "IA64") & (platform_name NOT_CONTAINS "Windows 2000") & (platform_name NOT_CONTAINS "Windows XP") & (platform_name NOT_CONTAINS "Windows NT 4.0")'
      prefs=get_platform_refs(filter)
      in_date=convert_to_epoch(start_date)
      policy_date_time=(DateTime.strptime(policy_date,'%Y%m%d').to_date.to_s)
      prefs.each do |pref|
        hffilter=Sasync::Filter.new()
        hffilter.object_type='patch_unit'
        hffilter.expression="((patch_unit_platform_id = #{pref.id}) & (PatchVO.modifiedDate GREATER_THAN_OR_EQUAL_TO #{in_date}))"

        hf_refs=get_hotfixes_by_filter(hffilter, bulletins_only, product_filter_regexp)
        #ur_refs=hf_refs
        #sp_refs=hf_refs
        ur_refs=get_update_rollups_by_filter(hffilter,bulletins_only, product_filter_regexp)
        sp_refs=get_service_packs_by_filter(hffilter,bulletins_only, product_filter_regexp)

        if (ur_refs.count > 0 || hf_refs.count > 0 || sp_refs.count > 0)
          if policy_custom_name==nil; policy_name="#{policy_date_time} - #{pref.name} Patch Policy" end
          if policy_custom_name!=nil; policy_name="#{policy_custom_name}- #{pref.name} Patch Policy" end
          policy_desc="Associated #{hf_refs.count} hotfix(es), #{sp_refs.count} service pack(s), #{ur_refs.count} update rollup(s)"
          policy_refs=create_windows_patch_policy(policy_name, pref, policy_desc)

          if hf_refs.count > 0

            #puts "Hotfixes #{hf_refs.count} - #{pref.name}"
            add_to_patch_policy_by_patch_refs(policy_refs,hf_refs)
          end
          if ur_refs.count > 0
            #puts "Update Rollups #{ur_refs.count} - #{pref.name}"
            add_to_patch_policy_by_patch_refs(policy_refs,ur_refs)
          end
          if sp_refs.count > 0
            #puts "Service packs #{sp_refs.count} - #{pref.name}"
            add_to_patch_policy_by_patch_refs(policy_refs,sp_refs)
          end
        end
      end
    end


    ##Test Methods Below here - Not supported
    def print_hotfixes_by_filter(filter,bulletins_only, hf_regex_array=nil)
      #begin
      refs=sas_client.hotfix_service.find_hotfix_refs(filter)
      if bulletins_only==true
        out_refs=Array.new()
        refs_vos=sas_client.hotfix_service.get_hotfix_vos(refs)
        refs_vos.each do |hfvo|
          hfaps=hfvo.affectedProducts.to_a.join(', ')

          if hfaps.match(hf_regex_array)
            puts "#{hfvo.name},#{hfvo.bulletinId},#{hfaps}"
          end



        end
        return "DD"
      else
        return "DD"
      end

      #rescue
      #Sasync.logger.error "Error during - #{__method__}"
      #return nil
      #end
    end




  end
end