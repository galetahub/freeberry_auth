# encoding: utf-8
module FreeberryAuth
  class AccountsController < ::ActionController::Metal
  
    # POST /auth/:provider
    def create
      if data = render_provider(params)
        render_account(data)
      else
        render_unauthorized
      end
    end
    
    # GET /auth/logout
    def destroy
      current_account = nil
      session.delete(:account_id)
      request.flash[:alert] = I18n.t('destroy.success', :scope => i18n_scope)
      redirect_to "/"
    end
  
    protected
  
      def current_account=(new_account)
        session[:account_id] = new_account ? new_account.id : nil
      end
      
      def render_account(options = {})
        FreeberryAuth.log(options.inspect)
        account = FreeberryAuth::Account.find_or_create(options)
        
        if account && account.persisted?
          current_account = account
          request.flash[:alert] = I18n.t('create.success', :scope => i18n_scope)
        end
        
        redirect_to FreeberryAuth.extract_path_proc.call(params)
      end
      
      def render_unauthorized
        request.flash[:alert] = I18n.t('create.failure', :scope => i18n_scope)
        redirect_to "/"
      end
    
      def render_provider(params)
        if params[:provider]
          case params[:provider].to_s.downcase
            when 'vkontakte' then
              if params[:account] && ::Vkontakte.authorized?(request.cookie_jar)
                { :provider_name => 'Vkontakte' }.merge(params[:account])
              end
            when 'loginza' then
              ::Loginza.user_data(params[:token])
          end
        end
      end
    
      def redirect_to(location, options = {}) #:doc:
        raise ::ActionControllerError.new("Cannot redirect to nil!") if location.nil?
        raise ::AbstractController::DoubleRenderError if response_body

        self.status        = (options.delete(:status) || 302).to_i
        self.location      = location
        self.response_body = "<html><body>You are being <a href=\"#{::ERB::Util.h(location)}\">redirected</a>.</body></html>"
      end
      
      def i18n_scope
        [:flash, :freeberry_auth, :accounts]
      end
      
      def params
        @_params ||= request.parameters
      end
  end
end
