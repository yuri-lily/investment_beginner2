class Opinion < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_many  :comments

  with_options presence: true do
    validates :brand, format: { with: /\A[a-zA-Z]{1,4}\z/, message: "is invalid.Please enter an alphabet of four letters or less"}
    validates :privacy_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :theory
  end
end
