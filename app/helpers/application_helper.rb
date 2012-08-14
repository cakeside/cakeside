module ApplicationHelper
  def avatar_for(user, options = {size:260, class:''})
    if user.avatar == nil 
      return gravatar_for(user, options)
    else
      image_tag(user.avatar.avatar.thumb.url, alt: user.name, class: options[:class])
    end
  end
  def gravatar_for(user, options = { size: 260 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}", alt: user.name, class: 'gravatar')
  end
  def full_title(title)
    if( title.blank? )
      "Welcome to CakeSide, a place for cake enthusiasts to share their proud creations!"
    else
      "#{title} - CakeSide"
    end
  end
end
