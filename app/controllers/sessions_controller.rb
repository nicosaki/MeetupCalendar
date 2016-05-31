class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def create
    auth_hash = request.env['omniauth.auth']
    # token = HTTParty.post("https://secure.meetup.com/oauth2/access",
    #   body: {
    #     client_id: ENV["MEETUP_KEY"],
    #     client_secret: ENV["MEETUP_SECRET"],
    #     grant_type: authorization_code,
    #     redirect_uri: "http://localhost:3000/auth/meetup/callback",
    #     code: response.code
    # }.to_json,
    #   headers: {"Content-Type" => "application/json" })

    if auth_hash["uid"]
     @user = User.find_or_create_from_omniauth(auth_hash)
     if @user
       @token = token
       @token_code = token.code
       session[:user_id] = @user.id
       redirect_to root_path
     else
       @token = token
       @token_code = token.code
       redirect_to root_path, notice: "Failed to save the user"
     end
    else
      @token = token
      @token_code = token.code
     redirect_to root_path, notice: "Failed to authenticate"
    end
  end


  def destroy

  end


  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
