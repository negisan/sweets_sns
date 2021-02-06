class ApplicationController < ActionController::Base


  private
    def user_prohibition?
      if current_user.prohibition?
        flash[:alert] = '機能が制限されています'
        redirect_to root_url
      end
    end
end
