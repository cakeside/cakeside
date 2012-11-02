module CreationsHelper
  def short_name(creation, length)
    if( creation.name.length > length)
      creation.name[0...length] + '...'
    else
      creation.name
    end
  end
  def shrink(name, length)
    if( name.length > length)
      name[0...length] + '...'
    else
      name
    end
  end
end
