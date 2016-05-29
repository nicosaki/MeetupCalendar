class User < ActiveRecord::Base
  validates uid, presence: true, uniqueness: true

  def self.find_or_create_from_omniauth(auth_hash)
    @uid = auth_hash["uid"]
    @current_user = User.find_by(uid: @uid)
    if @current_user
      return  @current_user
    else
      @current_user = User.new(uid: @uid)
      if @current_user.save
        return @current_user
      else
        return nil
      end
    end
  end
end
