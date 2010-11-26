# encoding: utf-8
module FreeberryAuth
  class Account < ::ActiveRecord::Base
    validates_presence_of :identifier, :provider_name
  
    attr_accessible :name, :username, :photo, :identity, :identifier, :email, 
                    :provider, :provider_name, :address, :uid, :language, :gender
    
    before_validation :make_defaults
    
    def identity=(value)
      self.identifier = value
    end
    
    def provider=(value)
      self.provider_name = value
    end
    
    def nickname=(value)
      self.username = value
    end
    
    def name=(value)
      str = nil
      
      if value.is_a?(Hash)
        value.symbolize_keys!
        str = value[:full_name] if value.has_key?(:full_name)
      end
      
      str ||= value
      write_attribute(:name, str)
    end
    
    def dob=(value)
      self.birthday = value
    end
    
    def without_email?
      self.email.blank?
    end
    
    def has_photo?
      !self.photo.blank?
    end
    
    def self.find_or_create(attributes)
      attributes.symbolize_keys!
      
      client = where(:identifier => attributes[:identity]).first
      client ||= new(attributes)
      client.save ? client : nil
    end
    
    protected
    
      def make_defaults
        self.provider_name ||= 'undefined'
        self.identifier ||= Time.now.to_i
      end
  end
end
