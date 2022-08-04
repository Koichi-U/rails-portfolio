class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
         validates :username, presence: true
         has_many :comments, dependent: :destroy
         has_many :taggings, dependent: :destroy
         has_many :articles
         mount_uploader :userimage, ImageUploader
end
