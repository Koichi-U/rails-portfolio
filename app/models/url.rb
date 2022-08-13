class Url < ApplicationRecord
  has_one :articles, dependent: :destroy
end
