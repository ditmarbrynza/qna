class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :awards, through: :answers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author_of?(subject)
    self.id == subject.user_id
  end
end
