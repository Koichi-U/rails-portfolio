class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  belongs_to :user
end
