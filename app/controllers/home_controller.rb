class HomeController < ApplicationController
  def index
    @welcome_message = "Hi #{current_user.name}" if user_signed_in?
  end
end
