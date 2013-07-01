module ApplicationHelper
  def avatar_for(user, options = {size:260, class:''})
    return gravatar_for(user, options) unless user.avatar
    image_tag(user.avatar.avatar.thumb.url, alt: user.name, class: options[:class], :style => "width:#{options[:size]}px;")
  end

  def gravatar_for(user, options = { size: 260 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}&d=mm", alt: user.name, class: 'gravatar')
  end

  def full_title(title)
    if( title.blank? )
      "CakeSide - for cake lovers!"
    else
      "#{title} - CakeSide"
    end
  end
end
