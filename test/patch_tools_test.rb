require 'java'
require 'rubygems'
require 'lib/sasync'


#eit_ci=Server.all(:types => :all, :where => {:name => "", :ccl2 => 'Server', :status => 2})
#eit_ci=Server.all(:types => :all, :where => {:name.like => "CTSPIKDC%", :ccl2 => 'Server', :status => 2})

Sasync.initialize_encryption!


my_sas_client=Sasync.new

my_sas_client.initialize!
my_sas_client.init_patch_tools!

products_match_map=Array.new
products_match_map[0]=/Windows Server/i



products_regexp=Regexp.union(products_match_map)

Sasync::HpsaPatchTools.initialize!(my_sas_client)

hffilter=Sasync::Filter.new()
hffilter.object_type='patch_unit'
hffilter.expression="((patch_unit_platform_id = 170092) & (PatchVO.modifiedDate GREATER_THAN_OR_EQUAL_TO 1351798395000))"

hf_refs = Sasync::HpsaPatchTools.create_patch_policies('20070101.010101',"20130226",true,"Supplemental Security Update Rollup Feb 2013",products_regexp)
#def create_patch_policies(start_date, policy_date, bulletins_only=true, policy_custom_name=nil, product_filter_regexp=nil)



#spref=Sasync::ServicePackRef.new(18540860001)

#Sasync::HpsaPatchTools.convert_to_epoch('20130205.010101')

#Sasync::HpsaPatchTools.create_patch_policies('20130101.010101',"February 2013 MS Patch Rollup - Bulletins Only","20130225",true)
