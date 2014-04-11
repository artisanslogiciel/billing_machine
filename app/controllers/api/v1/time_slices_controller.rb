module Api
  module V1
    class TimeSlicesController <  ApiController
      def index
        user = current_user
        @time_slices = user.time_slices.order(day: :desc)
        respond_with @time_slices
      end

      def create
        @time_slice = TimeSlice.create(safe_params.merge({user: current_user}))
        render :show
      end

      def update
        @time_slice = TimeSlice.find(params[:id])
        authorize! :write, @time_slice
        @time_slice.update(safe_params)
        render :show
      end

      private

        def safe_params
          safe_p = params.require(:time_slice)

          # TODO: descendre dans le modèle
          if safe_p[:duration]
            safe_p[:duration].gsub!(',' , '.')
            if safe_p[:duration][0] == '='
              require 'mathn'
              cleaned = safe_p[:duration].gsub(/[^0-9+-\/*]/, '')
              safe_p[:duration] = eval(cleaned).to_f
            end
          end

          safe_p.permit(:duration, :project_id, :activity_id, :comment, :day)
        end
    end
  end
end
