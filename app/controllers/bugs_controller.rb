class BugsController < ApplicationController
	
	before_action :logged_in, except: [:index, :show]

	def index
		@bugs = Bug.all
	end

	def new
		@bug = Bug.new
	end

	def create

		@bug = Bug.new(bug_params)
		@bug.creator_id = current_user.id 
		@bug.status = "New"
		if @bug.save
			flash[:success]="Bug added successfully"
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