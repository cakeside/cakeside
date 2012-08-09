module ApplicationHelper
  def avatar_url(user, options = {size: 260})
    if user.avatar == nil 
      default_url = "#{root_url}assets/chefhat_profile.PNG"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?&d=#{CGI.escape(default_url)}&s={options[:size]}"
    else
      user.avatar.avatar.thumb.url
    end
  end
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
  def full_title(title)
    if( title.blank? )
      "Welcome to CakeSide, a place for cake enthusiasts to share their proud creations!"
    else
      "#{title} - CakeSide"
    end
  end
end
