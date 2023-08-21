class Opinion < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  
  validates :brand, :theory, presence: true
  validates :privacy_id, numericality: { other_than: 1 , message: "can't be blank"}
end
