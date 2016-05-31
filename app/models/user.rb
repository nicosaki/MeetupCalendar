class User < ActiveRecord::Base
  # validates :uid, presence: true, uniqueness: true

  def self.find_or_create_from_omniauth(auth_hash)
    @uid = auth_hash["uid"]
    @current_user = User.find_by(uid: @uid, provider: "meetup")
    if @current_user
      return  @current_user
    else
      @current_user = User.new(uid: @uid, provider: auth_hash["provider"], zip: auth_hash["extra"]["raw_info"]["city"])
      if @current_user.save
        return @current_user
      else
        return nil
      end
    end
  end
end
