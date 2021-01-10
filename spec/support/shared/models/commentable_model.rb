# frozen_string_literal: true

shared_examples 'commentable model' do
  it { should have_many(:comments).dependent(:destroy) }
end
