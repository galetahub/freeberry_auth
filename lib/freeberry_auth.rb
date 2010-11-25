# encoding: utf-8
module FreeberryAuth
  autoload :Account,          'freeberry_auth/account'
  autoload :AuthorizedSystem, 'freeberry_auth/authorized_system'
  autoload :Version,          'freeberry_auth/version'
  
  cattr_accessor :extract_path_proc
  @@extract_path_proc = Proc.new{ |params| '/' }
  
  def self.table_name_prefix
    'auth_'
  end
end

require 'freeberry_auth/engine'
