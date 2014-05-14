class AddToFavorites
  def initialize(context, current_user = context.current_user)
    @context = context
    @current_user = current_user
  end

  def run(creation_id)
    cake = Creation.find(creation_id)
    if @current_user.owns(cake)
      @context.favorite_created(cake, "You can't favorite your own stuff")
      return
    end

    favorite = @current_user.add_favorite(cake)
    if favorite.save
      @context.favorite_created(cake, 'Welcome to the fanclub!')
    else
      @context.create_favorite_failed
    end
  end
end
