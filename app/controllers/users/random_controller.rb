class Users::RandomController < ApplicationController


  def create
    @user = User.create_random!
    sign_in(@user, :bypass => true)
    redirect_to root_path
  end

end
