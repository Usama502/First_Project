class ProjectsController < ApplicationController
	
	before_action :require_manager, except: [:index, :show]

	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
	end

	def new
		@project = Project.new
		
	end

	def create 
		@project = Project.new(project_params)
		@project.user_id = current_user.id 
		if @project.save
			flash[:success]="Project added successfully"
			redirect_to project_path(@project)
		else
			render 'new'
		end

	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update(project_params)
			flash[:success] = "Project updated successfully!"
			redirect_to project_path(@project)
		else
			render 'edit'
		end
	end

	def destroy

	end

	private

	def project_params
		params.require(:project).permit(:name, :user_id, :description)
	end

	def require_manager
		if (!user_signed_in? || current_user.user_type != "Manager")
			flash[:danger] = "Only Creator can perform this action!"
			redirect_to projects_path
		end
	end

end 