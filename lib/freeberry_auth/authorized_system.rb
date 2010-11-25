# encoding: utf-8
module FreeberryAuth
  module AuthorizedSystem
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
      
      base.helper_method :current_account, :account_signed_in?
    end
    
    module ClassMethods
    end

    module InstanceMethods
      protected
      
        def account_signed_in?
          !!current_account
        end
        
        def current_account=(new_account)
          session[:account_id] = new_account ? new_account.id : nil
          @current_account = new_account || false
        end
        
        def current_account
          @current_account ||= account_login_from_session unless @current_account == false
        end
        
        def account_login_from_session
          self.current_account = FreeberryAuth::Account.find_by_id(session[:account_id]) if session[:account_id]
        end
    end
  end
end
