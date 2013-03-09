include Java
require 'rubygems'
require 'pathname'
require 'logger'
require 'yaml'
require 'openssl'
require 'erb'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))


#Modified to allow class to be instantiated. Allows multiple connections with multiple users.
#Still have to allow aging of the connection to drop it.
#Only one connection can be open per opsware core. However more than one can be opened to different cores.
#See connect method for more info.
class Sasync
  require 'sasync/symmetric_encryption'

  class NotConnectedError < StandardError; end

  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::INFO


  class << self
    def env=(value)
      @@env = value.to_s
    end

    #Pulls environment from the current shell. This corresponds to a section in HPSA.yml file.
    def env
      if defined? @@env and @@env
        @@env
      elsif ENV['SASYNC_ENV']
        ENV['SASYNC_ENV']
      else
        if defined? Rails
          Rails.env
        else
          ENV['SASYNC_ENV'] || 'production'
        end
      end
    end

    def logger
      @@logger
    end

    def logger=(logger)
      @@logger=logger
    end

    def initialize_encryption!
      Sasync::SymmetricEncryption.load!("#{ENV['RAILS_ROOT'] || Dir.pwd}/config/symmetric_encryption.yml", env)
    end

  end

  attr_accessor :sa_connection


  def connected?
    @sa_connection.isConnected
  end

  def check_connection!
    raise NotConnectedError unless connected?
  end

  def reconnect
    self.connect! unless connected?
  end

  def disconnect
    if @sa_connection.isConnected then @sa_connection.disconnect() end
  end

  def vendor_path=(path)
    @vendor_path = Pathname.new path
  end

  def vendor_path
    @vendor_path || root + 'vendor'
  end

  def root
    Pathname.new(__FILE__).parent.parent
  end

  def lib_path
    Pathname.new(__FILE__).parent
  end

  def hpsa_path
    vendor_path
  end

  def env=(value)
    @@env = value.to_s
  end

  #Pulls environment from the current shell. This corresponds to a section in HPSA.yml file.
  def env
    if defined? @@env and @@env
      @@env
    elsif ENV['SASYNC_ENV']
      ENV['SASYNC_ENV']
    else
      if defined? Rails
        Rails.env
      else
        ENV['SASYNC_ENV'] || 'production'
      end
    end
  end

  def config_filename
    @config_filename ||= "#{ENV['RAILS_ROOT'] || Dir.pwd}/config/hpsa.yml"
  end


  def config_data
    #YAML.load(File.read(config_filename))
    YAML.load(ERB.new(File.new(config_filename).read).result)
  end

  def config
    config_data[self.env]
  end

  def server
    config['server']
  end

  def username
    config['username']
  end

  def password
    config['password']
  end

  def version
    config['version']
  end

  def port
    config['port']
  end

  def connection_info
    "HPSA connection to #{ server } with user #{ username }."
  end

  def initialize!(in_user=username.to_java(:string),in_password=password.to_java(:string), in_host=server.to_java(:string))
    require '914opswclient.jar' if version==914
    require '787opswclient.jar' if version==787

    require 'sasync/saservices'
    connect!(in_user.to_java(:string),in_password.to_java(:string), in_host.to_java(:string))
  end

  def init_patch_tools!
    require 'sasync/hpsa_tools/hpsa_patch_tools'
  end

  #Create a connection to the specified Opsware server.
  #Once a connection is formed, the connection remains for duration of the application
  #until it is explicitly disconnected or a new connection is formed in favor of the existing connection.
  #Only one connection to an Opsware server can exist at any given time,
  #though multiple users may share the same connection.
  #Multiple connections can exist if each connection is directed at a unique Opsware server.
  #Each connection is robust in it will attempt to automatically reconnect if a network failure is detected,
  #or a laptop revives from a sleep state. By default, the connection uses IIOP/HTTPS to connect to the Opsware server.
  def connect!(in_user, in_password, in_host)
    begin
      @sa_connection=OpswareClient
      @sa_connection.connect("https".to_java, in_host, port, in_user, in_password, true)
      require 'sasync/hpsa_tools/hpsa_tools'
      extend Sasync::HpsaTools
    rescue NativeException => e
      puts "Error during connection with error: #{e}"
      return
    end

      self.initialize_framework
      #puts @sa_connection.isConnected
      #puts connection_info
  end

  require 'sasync/framework'
  require 'sasync/version'
  require 'java_tools/java_trust_manager'
end

