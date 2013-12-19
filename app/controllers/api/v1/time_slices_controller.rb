module Api
  module V1
    class TimeSlicesController <  ApiController
      def index
        respond_with TimeSlice.all
      end

      def create
        @time_slice = TimeSlice.create(safe_params)
        render :show
      end

      def update
        @time_slice = TimeSlice.find(params[:id])
        @time_slice.update(safe_params)
        render :show
      end

      private

        def safe_params
          params.require(:time_slice).permit(:duration, :project_id, :activity_id, :comment, :day)
        end
    end
  end
end
