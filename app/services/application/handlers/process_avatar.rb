class ProcessAvatar
  def initialize()
  end

  def handles?(event)
    :upload_avatar == event
  end

  def handle(message)
    user = User.find(message[:user_id])
    #avatar = avatar_for(user)
  end

  private

  def avatar_for(user)
    if user.avatar.nil?
      avatar = user.avatar = Avatar.new
      user.save
      return avatar
    else
      user.avatar
    end
  end
end
