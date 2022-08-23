class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :articles, through: :taggings

  belongs_to :user

  validates :name, 
    presence: true, 
    uniqueness: { scope: :user, case_sensitive: false }

  def to_param
    name
  end
end
