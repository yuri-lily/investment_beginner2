class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  extend  ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :age
  belongs_to :gender

  validates :name, presence: true
  validates :age_id, :gender_id, numericality: { other_than: 1, message: "can't be blank" }

  has_many :opinions
  has_many :comments
end
