require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'お気に入り銘柄登録' do

    context 'お気に入り銘柄が登録できるとき' do
      it '全ての条件を満たしていれば登録できる' do
        expect(@favorite).to be_valid
      end
    end

    context 'お気に入り銘柄が登録できないとき' do
      it 'symbolが空では登録できない' do
        @favorite.symbol = ''
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Symbol can't be blank")
      end
      it 'symbolが全角では登録できない' do
        @favorite.symbol = 'ＡＡＡＡ'
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Symbol is invalid.Please enter an alphabet of four letters or less")
      end
      it 'symbolがアルファベット以外では登録できない' do
        @favorite.symbol = 'ああああ'
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Symbol is invalid.Please enter an alphabet of four letters or less")
      end
      it 'symbolが5文字以上では登録できない' do
        @favorite.symbol = 'aaaaa'
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Symbol is invalid.Please enter an alphabet of four letters or less")
      end
      it 'userが紐づいていないと登録できない' do
        @favorite.user = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('User must exist')
      end
    end

  end
end
