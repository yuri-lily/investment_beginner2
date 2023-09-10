require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do

    context '投稿できるとき' do
      it '全ての条件を満たしていれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context '投稿できないとき' do
      it 'contentが空では投稿できない' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが紐づいていないと投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('User must exist')
      end
      it 'opnionが紐づいていないと投稿できない' do
        @comment.opinion = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Opinion must exist')
      end
    end

  end
end
