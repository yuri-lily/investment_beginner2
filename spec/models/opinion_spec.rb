require 'rails_helper'

RSpec.describe Opinion, type: :model do
  before do
    @opinion = FactoryBot.build(:opinion)
  end

  describe '意見投稿' do

    context '投稿ができるとき' do
      it '全ての条件を満たしていれば投稿できる' do
        expect(@opinion).to be_valid
      end
    end

    context '投稿が出来ないとき' do
      it 'brandが空では投稿できない' do
        @opinion.brand = ''
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include("Brand can't be blank")
      end
      it 'brandが全角では投稿できない' do
        @opinion.brand = 'ＡＡＡＡ'
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include("Brand is invalid.Please enter an alphabet of four letters or less")
      end
      it 'brandがアルファベット以外では投稿できない' do
        @opinion.brand = 'ああああ'
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include("Brand is invalid.Please enter an alphabet of four letters or less")
      end
      it 'brandが5文字以上では投稿できない' do
        @opinion.brand = 'aaaaa'
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include("Brand is invalid.Please enter an alphabet of four letters or less")
      end
      it 'privacy_idが1では投稿できない' do
        @opinion.privacy_id = '1'
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include("Privacy can't be blank")
      end
      it 'theoryが空では投稿できない' do
        @opinion.theory = ''
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include("Theory can't be blank")
      end
      it 'userが紐づいていないと投稿できない' do
        @opinion.user = nil
        @opinion.valid?
        expect(@opinion.errors.full_messages).to include('User must exist')
      end
    end

  end
end
