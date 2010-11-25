require 'rails/generators'
require 'rails/generators/migration'

module FreeberryAuth
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    
    desc "Generates migration for accounts model"
    
    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end
    
    def self.current_time
      @current_time ||= Time.now
      @current_time += 1.minute
    end

    def self.next_migration_number(dirname)
      current_time.strftime("%Y%m%d%H%M%S")
    end
    
    def create_migration
      migration_template "create_accounts.rb", File.join('db/migrate', "freeberry_create_accounts.rb")
    end
  end
end
