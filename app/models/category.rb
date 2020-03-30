class Category < ApplicationRecord
	belongs_to :board
	validates :category, length: {maximum: 50}
end