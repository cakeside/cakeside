class Subscription
  def self.subscribe(email:, first_name:, last_name:, list_id: ENV['MAILCHIMP_LIST_ID'])
    return if Rails.env.test?

    Gibbon::API.lists.subscribe({
      id: list_id,
      email: { email: email },
      merge_vars: {
        FNAME: first_name,
        LNAME: last_name
      },
      double_optin: false
    })
  end
end
