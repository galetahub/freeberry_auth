# encoding: utf-8
module FreeberryAuth
  class AccountsController < ::ActionController::Metal
  
    # POST /auth/accounts
    def create
      if data = ::Loginza.user_data(params[:token])
        render_account(data)
      else
        render_unauthorized
      end
    end
    
    # POST /auth/vkontakte
    def vkontakte
      if ::Vkontakte.authorized?(request.cookie_jar) && params[:account]
        options = { :provider_name => 'Vkontakte' }.merge(params[:account])
        render_account(options)
      else
        render_unauthorized
      end
    end
  
    protected
  
      def set_current_account(new_account)
        session[:account_id] = new_account ? new_account.id : nil
      end
      
      def render_account(options = {})
        account = FreeberryAuth::Account.find_or_create(options)
        
        if account && account.persisted?
          set_current_account(account)
          request.flash[:alert] = I18n.t(:success, :scope => [:flash, :accounts, :create])
        end
        
        redirect_to FreeberryAuth.extract_path_proc.call(params)
      end
      
      def render_unauthorized
        request.flash[:alert] = I18n.t(:access_denied, :scope => [:flash, :accounts, :create])
        redirect_to "/"
      end
    
      def redirect_to(location, options = {}) #:doc:
        raise ::ActionControllerError.new("Cannot redirect to nil!") if location.nil?
        raise ::AbstractController::DoubleRenderError if response_body

        self.status        = (options.delete(:status) || 302).to_i
        self.location      = location
        self.response_body = "<html><body>You are being <a href=\"#{::ERB::Util.h(location)}\">redirected</a>.</body></html>"
      end
      
      def params
        @_params ||= request.parameters
      end
  end
end
