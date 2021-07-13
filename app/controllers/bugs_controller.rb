class BugsController < ApplicationController
	
	before_action :logged_in

	def index
		if(current_user.user_type == "Manager" || current_user.user_type == "QA")
			@bugs = current_user.bugs
		else 
			@bugs = Bug.where(:developer_id => current_user.id)
		end
	end

	def home

	end

	def new
		@bug = Bug.new
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
		@bug = Bug.find(params[:id])
	end

	def edit
		@bug = Bug.find(params[:id])
	end

	def update
		@bug = Bug.find(params[:id])
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
		if (!user_signed_in?)
			flash[:danger] = "You have to logged in to perform this action!"
			redirect_to bugs_path
		end
	end
end