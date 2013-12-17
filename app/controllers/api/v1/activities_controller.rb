module Api
  module V1
    class ActivitiesController <  ApiController
      def index
        respond_with Activity.all
      end
    end
  end
end
