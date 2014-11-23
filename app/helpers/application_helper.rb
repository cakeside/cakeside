module ApplicationHelper
  def avatar_for(user, size: 260, clazz: '')
    return gravatar_for(user, size) if user.avatar == nil || !user.avatar.image.present?
    image_tag(user.avatar.url_for(:thumb), alt: user.name, class: clazz, style: "width:#{size}px;")
  end

  def gravatar_for(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm", alt: user.name, class: 'gravatar')
  end

  def full_title(title)
    title.blank? ?  "CakeSide - for cake lovers!" : "#{title} - CakeSide"
  end

  def disqus_auth(user = current_user)
    data = { id: user.id, username: user.name, email: user.email, url: "https://#{request.host_with_port}/profiles/#{user.to_param}" }
    data[:avatar] = user.avatar.url_for(:thumb) if user.has_avatar?
    message = Base64.encode64(data.to_json).gsub("\n", "")
    timestamp = Time.now.to_i
    signature = OpenSSL::HMAC.hexdigest('sha1', ENV['DISQUS_SECRET_KEY'] || '', "#{message} #{timestamp}")
    "#{message} #{signature} #{timestamp}"
  end

  def controller?(name)
    params[:controller].include?(name.to_s)
  end

  def render_markdown(content)
    return "" if content.nil?
    GitHub::Markdown.render_gfm(content)
  end

  def configuration_for(key, default)
    content_for(key) || default
  end
end
