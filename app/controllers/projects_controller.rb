class ProjectsController < ApplicationController
	
	before_action :set_project, only: [:show, :edit, :update, :destroy]
	before_action :require_manager, except: [:index, :show]
	before_action :current_manger, only: [:edit, :destroy]
	before_action :logged_in


	def index
		if(current_user.user_type== "Manager")
	    	@user_projects = current_user.createProjects
	    else
	    	@user_projects = current_user.projects
	    end
	end

	def show
		@project_user = @project.users 
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
	end

	def update
		if @project.update(project_params)
			flash[:success] = "Project updated successfully!"
			redirect_to project_path(@project)
		else
			render 'edit'
		end
	end

	def destroy
		Project.find(params[:id]).destroy
		flash[:success] = "Project deleted successfully!"
		redirect_to projects_path
	end

	private

	def project_params
		params.require(:project).permit(:name, :user_id, :description, user_ids: [])
	end

	def set_project
		@project = Project.find(params[:id])
	end

	

	def require_manager
		if !(user_signed_in? && current_user.user_type == "Manager" )
			flash[:danger] = "Only Manager can perform this action!"
			redirect_to projects_path
		end
	end

	def current_manger
		if !(user_signed_in? && current_user.user_type == "Manager" && current_user.id == @project.user_id)
			flash[:danger] = "Only Creator Manager can perform this action!"
			redirect_to projects_path
		
		end
	end

	def logged_in
		if (!user_signed_in?)
			flash[:danger] = "You have to Log in first!"
			redirect_to '/users/sign_in'
		end

	end

end 