module Api
  module V1
    class ProjectsController <  ApiController
      def index
        @projects = Project.all.order(:name)
        respond_with @projects
      end

      def show
        @project = Project.find(params[:id])
      end

      def create
        @project = Project.new(safe_params)
        if @project.save
          render :show
        else
          render json: @project.errors.full_messages, status: 422
        end
      end

      def update
        @project = Project.find(params[:id])
        if @project.update(safe_params)
          render :show
        else
          render json: @project.errors.full_messages, status: 422
        end
      end

      private

        def safe_params
          params.require(:project).permit(:name)
        end
    end
  end
end
