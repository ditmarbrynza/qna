# frozen_string_literal: true

class Answer < ApplicationRecord
  include Votable
  belongs_to :question
  belongs_to :user
  has_many_attached :files
  has_many :links, dependent: :destroy, as: :linkable
  has_one :award

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  def set_the_best
    Answer.transaction do
      Answer.where(question_id: question_id, best: true).update_all(best: false)
      update!(best: true)
      update!(award: question.award) if question.award
    end
  end
end
