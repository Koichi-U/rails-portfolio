class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  belongs_to :user
  belongs_to :url


  #関連付けしたモデルを一緒にデータ保存できるようにする
  accepts_nested_attributes_for :taggings
end
