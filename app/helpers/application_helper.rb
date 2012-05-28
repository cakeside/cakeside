module ApplicationHelper
  def avatar_url(user)
      default_url = "#{root_url}assets/chefhat_profile.PNG"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?&d=#{CGI.escape(default_url)}"
  end
  def full_title(title)
    if( title.blank? )
      "Welcome to CakeSide, a place for cake enthusiasts to share their proud creations!"
    else
      "#{title} - CakeSide"
    end
  end
end
