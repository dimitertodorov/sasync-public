class Sasync

  #The following imports are required to prevent an unknown constant error when initializing.
  java_import Java::java.rmi.RemoteException

  java_import Java::com.opsware.client.OpswareClient
  java_import Java::com.opsware.client.OpswClientEndpoint
  java_import Java::com.opsware.client.ClientException
  java_import Java::com.opsware.client.APIUser
  java_import Java::com.opsware.client.ClientMessageSpec
  java_import Java::com.opsware.client.PerformanceMonitor
  java_import Java::com.opsware.client.TokenFinder
  java_import Java::com.opsware.client.UserFinder
  java_import Java::com.opsware.client.Version

  java_import Java::com.opsware.client.APIUserImpl


  java_import Java::com.opsware.common.ModifiableMap
  java_import Java::com.opsware.common.OpswareSystemException

  java_import Java::com.opsware.folder.FNodeReference
  java_import Java::com.opsware.folder.FolderCopyable
  java_import Java::com.opsware.folder.FolderMessageSpec
  java_import Java::com.opsware.folder.FolderRemovable
  java_import Java::com.opsware.folder.FolderService
  java_import Java::com.opsware.folder.FNodeVO
  java_import Java::com.opsware.folder.FolderPath
  java_import Java::com.opsware.folder.FolderRef
  java_import Java::com.opsware.folder.FolderVO

  java_import Java::com.opsware.search.Filter

  java_import Java::com.opsware.locality.CustomerRef
  java_import Java::com.opsware.locality.CustomerService


  java_import Java::com.opsware.job.JobRef
  java_import Java::com.opsware.job.JobService
  java_import Java::com.opsware.job.JobNotification
  java_import Java::com.opsware.job.JobSchedule

  java_import Java::com.opsware.script.ServerScriptRef
  java_import Java::com.opsware.script.ServerScriptJobArgs
  java_import Java::com.opsware.script.ServerScriptService
  java_import Java::com.opsware.script.ScriptJobOutput

  java_import Java::com.opsware.server.ServerService
  java_import Java::com.opsware.server.ServerRef
  java_import Java::com.opsware.server.ServerVO


  java_import Java::com.opsware.storage.FileSystemService
  java_import Java::com.opsware.storage.FileSystemRef
  java_import Java::com.opsware.storage.FileSystemVO
  java_import Java::com.opsware.storage.PhysicalDiskService
  java_import Java::com.opsware.storage.PhysicalDiskRef
  java_import Java::com.opsware.storage.PhysicalDiskVO

  java_import Java::com.opsware.fido.ACLConstants
  java_import Java::com.opsware.fido.AdminRoleReference
  java_import Java::com.opsware.fido.AdminRoleService
  java_import Java::com.opsware.fido.Operation
  java_import Java::com.opsware.fido.Authentication
  java_import Java::com.opsware.fido.AuthenticationService
  java_import Java::com.opsware.fido.AuthorizationService
  java_import Java::com.opsware.fido.CommonResourceTypes
  java_import Java::com.opsware.fido.CustomerAdminRoleService
  java_import Java::com.opsware.fido.FidoMessageSpec
  java_import Java::com.opsware.fido.OperationConstants
  java_import Java::com.opsware.fido.ResourceTypeConstants
  java_import Java::com.opsware.fido.RoleConstants
  java_import Java::com.opsware.fido.RoleReference
  java_import Java::com.opsware.fido.SearchableResourceTypes
  java_import Java::com.opsware.fido.SecureReference
  java_import Java::com.opsware.fido.SecureResourceTypes
  java_import Java::com.opsware.fido.UserRoleService

  java_import Java::com.opsware.device.DeviceGroupService
  java_import Java::com.opsware.device.DeviceMessageSpec
  java_import Java::com.opsware.device.DeviceReference
  java_import Java::com.opsware.device.PlatformService
  java_import Java::com.opsware.device.RemoteManagement
  java_import Java::com.opsware.device.Architecture
  java_import Java::com.opsware.device.DeviceConnectionInfoVO
  java_import Java::com.opsware.device.DeviceDetails
  java_import Java::com.opsware.device.DeviceGroupRecalcState
  java_import Java::com.opsware.device.DeviceGroupRef
  java_import Java::com.opsware.device.DeviceGroupVO
  java_import Java::com.opsware.device.DeviceHardwareVO
  java_import Java::com.opsware.device.DeviceVO
  java_import Java::com.opsware.device.PlatformFamily
  java_import Java::com.opsware.device.PlatformRef
  java_import Java::com.opsware.device.PlatformVO

  java_import Java::com.opsware.swmgmt.WindowsPatchPolicyService
  java_import Java::com.opsware.swmgmt.PolicyService
  java_import Java::com.opsware.swmgmt.PatchPolicyService
  java_import Java::com.opsware.swmgmt.PatchPolicy
  java_import Java::com.opsware.swmgmt.WindowsPatchPolicyVO
  java_import Java::com.opsware.pkg.windows.ServicePackRef

  java_import Java::com.opsware.pkg.windows.HotfixService
  java_import Java::com.opsware.pkg.windows.MSIService
  java_import Java::com.opsware.pkg.windows.PatchMetaDataService
  java_import Java::com.opsware.pkg.windows.ServicePackService
  java_import Java::com.opsware.pkg.windows.UpdateRollupService
  java_import Java::com.opsware.pkg.windows.WindowsPatch
  java_import Java::com.opsware.pkg.windows.WindowsPatchReference
  java_import Java::com.opsware.pkg.windows.WindowsPatchService
  java_import Java::com.opsware.pkg.windows.WindowsUtilityService

  def server_service
    server_service=@sa_connection.get_service(ServerService.java_class)
  end

  def customer_service
    customer_service=@sa_connection.get_service(CustomerService.java_class)
  end

  def device_group_service
    customer_service=@sa_connection.get_service(DeviceGroupService.java_class)
  end

  def job_service
    job_service=@sa_connection.get_service(JobService.java_class)
  end

  def platform_service
    platform_service=@sa_connection.get_service(PlatformService.java_class)
  end

  def windows_patch_policy_service
    windows_patch_policy_service=@sa_connection.get_service(WindowsPatchPolicyService.java_class)
  end

  def hotfix_service
    hotfix_service=@sa_connection.get_service(HotfixService.java_class)
  end

  def update_rollup_service
    update_rollup_service=@sa_connection.get_service(UpdateRollupService.java_class)
  end

  def service_pack_service
    service_pack_service=@sa_connection.get_service(ServicePackService.java_class)
  end

  def authorization_service
    service_pack_service=@sa_connection.get_service(AuthorizationService.java_class)
  end


  def script_service
    begin
      script_service=@sa_connection.get_service(ServerScriptService.java_class)
    rescue ClientException
      @@sa_logger.error("ERROR Getting Service Connection with: #{e}")
      self.reconnect
      self.script_service
    rescue OpswareSystemException
      @@sa_logger.error("ERROR Getting Service with: #{e}")
      script_service=nil
    end

  end

  def physical_disk_service
    physical_disk_service=@sa_connection.get_service(PhysicalDiskService.java_class)
  end

  def file_system_service
    file_system_service=@sa_connection.get_service(FileSystemService.java_class)
  end
end