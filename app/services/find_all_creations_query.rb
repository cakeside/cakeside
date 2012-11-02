class FindAllCreationsQuery
  def initialize(user)
    @user = user
  end
  def fetch(params)
    Creation.where(:is_restricted => false, :is_published => true).page(params[:page]).per(16)
  end
end
