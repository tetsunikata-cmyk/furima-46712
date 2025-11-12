class ApplicationController < ActionController::Base
  # テスト以外の環境でBasic認証をかける
  before_action :basic_auth, unless: -> { Rails.env.test? }

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
