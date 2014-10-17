class AddToFavorites
  def handles?(event)
    :add_cake_to_favorites
  end

  def handle(message)
    cake = Creation.find(message[:cake_id])
    user = User.find(message[:user_id])
    return if user.owns(cake)

    favorite = user.add_favorite(cake)
    favorite.save
  end
end
