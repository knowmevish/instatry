class SessionsController < ApplicationController

  # callback form github
  # Create user for first time
  # Redirect to registration form unless email is filled
  # Session is not created unless user has email
  def create

    auth = request.env["omniauth.auth"]
    #raise auth.inspect
    user = User.find_by_id(auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    render "home/newsfeed"

    # @user = User.find_by_uid(auth["uid"])
    # if @user
    #   session[:user_id] = @user.id
    #   redirect_to root_url, :notice => "Signed in!"
    # else
    # 	raise "hellloooo"
    # 	raise auth.inspect
    #     # session[:auth] = auth
    #     # @users = User.all
    #     # @members = @users.index_by(&:id)
    #     # @name = auth[:info][:name]
    #     # @email = auth[:info][:email]
    #     # @avatar = auth[:extra][:raw_info][:avatar_url]
    #     # @handle = auth["extra"]["raw_info"]["login"] 
    #   # render "home/index"
    #   return
   
  end

  def failure
    render :text => "Failed!"
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end