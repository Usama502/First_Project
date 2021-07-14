class BugsController < ApplicationController
	
	before_action :logged_in
	before_action :set_bug, only: [ :show, :edit, :update, :destroy]
	before_action :require_manager_qa, except: [:index, :show, :edit, :update]
	before_action :check_user, except: [:index, :new, :create, :show]


	def index
		if(current_user.user_type == "Manager" || current_user.user_type == "QA")
			@bugs = current_user.bugs
		else 
			@bugs = Bug.where(:developer_id => current_user.id)
		end
	end

	def new
		@bug = Bug.new
		@project = Project.find_by_id(params[:id])
	end

	def create
		
		@bug = Bug.new(bug_params)
		@bug.user_id = current_user.id 
		
		@bug.status = "New"
		if @bug.save
			flash[:success] = "Bug added successfully"
			redirect_to bug_path(@bug)
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @bug.update(bug_params)
			flash[:success] = "Bug updated successfully!"
			redirect_to bug_path(@bug)
		else
			render 'edit'
		end
	end

	def destroy
		Bug.find(params[:id]).destroy
		flash[:success] = "Bug deleted successfully!"
		redirect_to bugs_path
	end


	private
		def bug_params
			params.require(:bug).permit(:title, :status, :description, :bug_type, :deadline, :project_id, :user_id, :developer_id, :image)
		end

		def logged_in
		if(!user_signed_in?)
			flash[:danger] = "You have to logged in to perform this action!"
			redirect_to '/users/sign_in'
		end

		def require_manager_qa
			if(current_user.user_type == "Developer")
				flash[:danger] = "Manager and QA can perform this action!"
				redirect_to bugs_path
			end
		end

		def check_user
			if(! (current_user.id == @bug.user_id || current_user.id == @bug.developer_id))
				redirect_to bugs_path
			end
		end

		def set_bug
			@bug = Bug.find(params[:id])
		end
	end
end