module Api
  module V1
    class TimeSlicesController <  ApiController
      def index
        authorize! :read, TimeSlice
        render_time_slice_list
      end

      def create
        authorize! :write, TimeSlice
        begin
          @time_slice = TimeSlice.create(safe_params.merge({user: current_user}))
          if @time_slice.save
            render :show , status: 200
          else
            render json: @time_slice.errors ,status: 422
          end
        rescue ActionController::ParameterMissing
          render json: '{"TimeSlice":["can\'t be empty"]}' ,status: 422
        end
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

          safe_p.permit(:duration, :project_id, :activity_id, :comment, :day, :billable)
        end

        def render_time_slice_list
          user = current_user
          @time_slices = user.time_slices.order(day: :desc, updated_at: :desc)
          respond_to do |format|
            format.csv { send_data generate_encoded_csv(@time_slices), type: "text/csv" }
            format.json  { respond_with @time_slices }
          end
        end

        def generate_encoded_csv time_slices # TODO extract to own class
          time_slices.to_csv.encode("WINDOWS-1252", :crlf_newline => true, :invalid => :replace, :undef => :replace, :replace => "?")
        end
    end
  end
end
