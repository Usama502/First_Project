class Project < ApplicationRecord

	validates :name, presence: true
	validates :description, presence: true
	validates :user_id, presence: true

	belongs_to :user
	default_scope -> { order(updated_at: :desc)}

	has_many :bugs, dependent: :destroy
	has_many :project_users , dependent: :destroy
	has_many :users ,through: :project_users , dependent: :destroy
end