module Api
  module V1
    class ProjectsController <  ApiController
      def index
        respond_with Project.all
      end

      def show
        @project = Project.find(params[:id])
      end

      def create
        @project = Project.create(safe_params)
        render :show
      end

      private

        def safe_params
          params.require(:project).permit(:name)
        end
    end
  end
end
