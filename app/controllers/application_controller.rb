class ApplicationController < ActionController::Base
  protect_from_forgery :secret=>''

  before_filter :authorize,:except=>:login

  protected
  def authorize
    unless User.find_by_id(session[:user_id])
      session[:original_url] = request.url
      flash[:notice] = 'please login'
      redirect_to :controller => 'admin',:action=>'login'
    end
  end
end
