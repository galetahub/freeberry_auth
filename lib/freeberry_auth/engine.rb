# encoding: utf-8
require 'rails'
require 'freeberry_auth'

module FreeberryAuth
  class Engine < ::Rails::Engine
    config.after_initialize do
      ::ActionController::Base.send :include, FreeberryAuth::AuthorizedSystem
    end
  end
end
