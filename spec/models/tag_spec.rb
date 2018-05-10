# coding: utf-8
require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:tag) { FactoryBot.create(:tag) }

  describe '登録確認' do
    context 'nameが' do
      it '正しい時登録成功' do
        expect(tag).to be_valid
      end
    end
  end

  describe 'バリデーション確認' do
    context 'nameが' do
      it '空の時登録失敗' do
        tag.name = nil
        expect(tag).not_to be_valid
      end
      
      it '重複している時登録失敗' do
        FactoryBot.create(:tag)
        tag2 = FactoryBot.build(:tag)
        expect(tag2).not_to be_valid
      end
    end
  end
end
