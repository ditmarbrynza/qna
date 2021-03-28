# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Search do
  it 'calls for all scopes' do
    object = Services::Search.new('query', 'all')
    allow(ThinkingSphinx).to receive(:search).with('query', classes: [Question, Answer, Comment, User], page: 1)
    object.call
  end

  it 'calls for question scope' do
    object = Services::Search.new('query', 'question')
    allow(Question).to receive(:search).with('query', page: 1)
    object.call
  end

  it 'calls for answer scope' do
    object = Services::Search.new('query', 'answer')
    allow(Answer).to receive(:search).with('query', page: 1)
    object.call
  end

  it 'calls for user scope' do
    object = Services::Search.new('query', 'user')
    allow(User).to receive(:search).with('query', page: 1)
    object.call
  end

  it 'calls for comment scope' do
    object = Services::Search.new('query', 'comment')
    allow(Comment).to receive(:search).with('query', page: 1)
    object.call
  end

  it 'calls for comment scope with third page' do
    object = Services::Search.new('query', 'comment', 3)
    allow(Comment).to receive(:search).with('query', page: 3)
    object.call
  end
end
