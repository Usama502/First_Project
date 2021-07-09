class Bug < ApplicationRecord

	before_save {self.title = title.downcase  }  	
    validates :title, presence: true, length: { maximum: 80 },
        uniqueness: { case_sensitive: false }

	validates :status, presence: true
	validates :bug_type, presence: true
	validates :deadline, presence: true
	validates :project_id, presence: true
	validates :user_id, presence: true

	mount_uploader :image, ImageUploader


	belongs_to :project
	belongs_to :user
end