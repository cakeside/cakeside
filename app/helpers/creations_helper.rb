module CreationsHelper
  def short_name(creation, length)
    if( creation.name.length > length)
      #creation.name.split(//).first(length).join('') + '...'
      creation.name[0...length] + '...'
    else
      creation.name
    end
  end
end
