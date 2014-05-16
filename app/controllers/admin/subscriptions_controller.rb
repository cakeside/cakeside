module Admin
  class SubscriptionsController < AdminController
    def index
      members =  Gibbon::API.lists.members({ id: ENV['MAILCHIMP_LIST_ID'], status: 'subscribed'})
      @subscriptions = members["data"]
      @total = members["total"]
    end
  end
end
