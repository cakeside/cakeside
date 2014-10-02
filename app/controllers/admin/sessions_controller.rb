module Admin
  class SessionsController < AdminController
    def index
      @user_sessions = sessions.filter_by(search_filters)
      @direction = params[:direction].present? ? directions[params[:direction].to_sym] : :asc
    end

    def destroy
      UserSession.find(params[:id]).revoke!
      redirect_to admin_sessions_path
    end

    private

    def sessions
      UserSession.includes(:user, :location)
    end

    def search_filters
      [sort_filter]
    end

    def sort_filter
      direction = params[:direction].present? ? params[:direction].to_sym : :asc
      case params[:sort].try(:downcase)
      when "ip"
        ->(sessions) { sessions.order(ip: direction) }
      when 'city'
        ->(sessions) { sessions.joins(:location).order("locations.city #{direction}") }
      when 'ua'
        ->(sessions) { sessions.order(user_agent: direction) }
      else
        ->(sessions) { sessions.order(created_at: :desc) }
      end
    end

    def directions
      {
        asc: :desc,
        desc: :asc,
      }
    end
  end
end
