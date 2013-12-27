module Api
  module V1
    class TimeSlicesController <  ApiController
      def index
        @time_slices = TimeSlice.all.order(day: :desc)
        respond_with @time_slices
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
          safe_p = params.require(:time_slice)

          safe_p[:duration].gsub!(',' , '.')
          if safe_p[:duration][0] == '='
            require 'mathn'
            cleaned = safe_p[:duration].gsub(/[^0-9+-\/*]/, '')
            safe_p[:duration] = eval(cleaned).to_f
          end

          safe_p.permit(:duration, :project_id, :activity_id, :comment, :day)
        end
    end
  end
end
