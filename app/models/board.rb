class Board < ApplicationRecord
	belongs_to :user
	has_many :categories, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :title, length: {maximum: 50}
	validates :body, length: {maximum: 500}
	accepts_nested_attributes_for :categories

	# def self.search(search)
	#     if search
	#       self.where(['title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%"])
	#     else
	#       self.all
	#     end
 #  	end
end