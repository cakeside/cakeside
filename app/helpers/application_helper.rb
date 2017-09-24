module ApplicationHelper
  def avatar_for(user, size: 260, clazz: 'img-thumbnail')
    return gravatar_for(user, size) if user.avatar == nil || !user.avatar.image.present?
    image_tag(user.avatar.url_for(:thumb), alt: user.name, class: clazz)
  end

  def gravatar_for(user, size)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    image_tag("https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm", alt: user.name, class: 'gravatar')
  end

  def full_title(title)
    title.blank? ? "CakeSide - for cake lovers!" : "#{title} - CakeSide"
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

  def flash_to_alert(key)
    case key.to_sym
    when :success
      'primary'
    when :error
      'danger'
    when :warning
      'warning'
    else
      'info'
    end
  end

  def backbone_collection_for(items)
    render partial: 'backbone_collection', locals: {
      items: items,
      model_name: items.model_name.human,
      plural_name: items.model_name.plural,
    }
  end
end
