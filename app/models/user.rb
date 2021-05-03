class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false

  has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followed, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :followers, through: :relationships, source: :follower

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end
