module Admin
  class SubscriptionsController < AdminController
    def index
      members =  Gibbon::API.lists.members({ id: '6ea750df21', status: 'subscribed', opts: { start: 0, limit: 100}})
      @subscriptions = members["data"]
      @total = members["total"]
    end
  end
end
