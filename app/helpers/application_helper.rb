module ApplicationHelper
  def avatar_for(user, size: 260, clazz: '')
    return gravatar_for(user, size) if user.avatar == nil || !user.avatar.avatar.present?
    image_tag(user.avatar.avatar.thumb.url, alt: user.name, class: clazz, :style => "width:#{size}px;")
  end

  def gravatar_for(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm", alt: user.name, class: 'gravatar')
  end

  def full_title(title)
    if( title.blank? )
      "CakeSide - for cake lovers!"
    else
      "#{title} - CakeSide"
    end
  end

  def disqus_auth(user = current_user)
    if user.has_avatar?
      data = { id: user.id, username: user.name, email: user.email, :avatar => user.avatar.avatar.url, :url => "https://#{request.host_with_port}/profiles/#{user.to_param}" }.to_json
    else
      data = { id: user.id, username: user.name, email: user.email, :url => "https://#{request.host_with_port}/profiles/#{user.to_param}" }.to_json
    end
    message = Base64.encode64(data).gsub("\n", "")
    timestamp = Time.now.to_i
    signature = OpenSSL::HMAC.hexdigest('sha1', ENV['DISQUS_SECRET_KEY'] || '', "#{message} #{timestamp}")
    "#{message} #{signature} #{timestamp}"
  end
end
