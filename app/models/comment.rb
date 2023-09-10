class Comment < ApplicationRecord
  belongs_to :opinion
  belongs_to :user

  validates :content, presence: true
end
