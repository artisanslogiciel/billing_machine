module Api
  module V1
    class ProjectsController <  ApiController
      def index
        @projects = Project.where(entity_id: current_user.entity_id).order(:name)
        respond_with @projects
      end

      def show
        @project = Project.find(params[:id])
      end

      def create
        @project = Project.new(safe_params)
        @project.entity= current_user.entity
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
