class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :createProjects, class_name: 'Project' , dependent: :destroy
  has_many :bugs , dependent: :destroy

  has_many :assignedBugs, class_name: 'Bug' 


  has_many :project_users , dependent: :destroy
  has_many :projects, through: :project_users , dependent: :destroy
end
