class Book < ActiveRecord::Base
	belongs_to :users
	mount_uploader :attachment, AttachmentUploader 
    validates :title, :description, presence: true, length: { minimum: 3 }
    validates :attachment, presence: true
end
