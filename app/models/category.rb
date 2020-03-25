class Category < ApplicationRecord
	belongs_to :board
	validates :category, length: {maximum: 10}
end