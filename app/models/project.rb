class Project < ApplicationRecord

	validates :name, presence: true
	validates :description, presence: true
	validates :user_id, presence: true

	belongs_to :user
	default_scope -> { order(updated_at: :desc)}

	has_many :bugs, dependent: :destroy

end