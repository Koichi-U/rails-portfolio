class Tagging < ApplicationRecord
  # validates :tag_id, presence: true  # 空のデータをはじくバリデーション
  
  belongs_to :user
  belongs_to :article
  belongs_to :tag
end
