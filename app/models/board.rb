class Board < ApplicationRecord
	belongs_to :user
	has_many :categories, dependent: :destroy
	has_many :comments, dependent: :destroy
	validates :title, length: {maximum: 100}
	validates :body, length: {maximum: 500}
	accepts_nested_attributes_for :categories

	# def self.search(search)
	#     if search
	#       self.where(['title LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%"])
	#     else
	#       self.all
	#     end
 #  	end
 	scope :with_keywords, -> keywords {
    if keywords.present?
      columns = [:title, :body]
      where(keywords.split(/[[:space:]]/).reject(&:empty?).map {|keyword|
        columns.map { |a| arel_table[a].matches("%#{keyword}%") }.inject(:or)
      }.inject(:and))
    end
  	}
end