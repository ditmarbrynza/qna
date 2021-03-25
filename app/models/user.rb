# frozen_string_literal: true

class User < ApplicationRecord
  has_many :questions
  has_many :answers
  has_many :awards, through: :answers
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable, :recoverable,
          :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github vkontakte]
  has_many :authorizations, dependent: :destroy
  has_many :subscribers, dependent: :destroy

  def author_of?(subject)
    id == subject.user_id
  end

  def self.find_for_oauth(auth)
    Services::FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def create_unconfirmed_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid, confirmation_token: Devise.friendly_token)
  end

  def auth_confirmed?(auth)
    auth && authorizations.find_by(uid: auth.uid, provider: auth.provider)&.confirmed?
  end

  def generate_password
    new_password = Devise.friendly_token
    self.password = self.password_confirmation = new_password
    self
  end
end
