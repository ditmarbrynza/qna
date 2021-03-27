# frozen_string_literal: true

ThinkingSphinx::Index.define :comment, with: :active_record do
  # fields
  indexes text
  indexes user.email, as: :author, sortable: true

  # attributes
  has user_id, commentable_type, created_at, updated_at
end
