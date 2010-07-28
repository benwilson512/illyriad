class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  before_filter :authenticate_user!
  
  private
  def data_cache(key)
    unless output = Rails.cache.read(key)
      output = yield
      Rails.cache.write(key, output, 1.hour)
    end
    return output
  end
  
end
