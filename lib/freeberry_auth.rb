# encoding: utf-8
module FreeberryAuth
  autoload :Account,          'freeberry_auth/account'
  autoload :AuthorizedSystem, 'freeberry_auth/authorized_system'
  autoload :Version,          'freeberry_auth/version'
  
  mattr_accessor :extract_path_proc
  @@extract_path_proc = Proc.new{ |params| '/' }
  
  mattr_accessor :logger
  @@logger = nil
  
  def self.table_name_prefix
    'auth_'
  end
  
  def self.log(message)
    if @@logger
      @@logger.info("FreeberryAuth: #{message}")
    end
  end
end

require 'freeberry_auth/engine'
