class Board < ApplicationRecord
	belongs_to :user
	has_many :categories
	has_many :comments
	validates :title, length: {maximum: 50}
	validates :body, length: {maximum: 500}
end