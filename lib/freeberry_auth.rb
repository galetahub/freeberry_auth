# encoding: utf-8
module FreeberryAuth
  autoload :Account,          'freeberry_auth/account'
  autoload :AuthorizedSystem, 'freeberry_auth/authorized_system'
  autoload :Version,          'freeberry_auth/version'
  
  def self.table_name_prefix
    'auth_'
  end
end

require 'freeberry_auth/engine'
