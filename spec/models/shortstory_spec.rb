# coding: utf-8
require 'rails_helper'

RSpec.describe Shortstory, type: :model do
  let(:ss) { FactoryBot.create(:shortstory) }

  describe '登録確認' do
    context 'titleとurlが' do
      it '正しい時登録成功' do
        expect(ss).to be_valid
      end
    end
  end

  describe 'バリデーション確認' do
    context 'titileが' do
      it '空の時登録失敗' do
        ss.title = nil
        expect(ss).not_to be_valid
      end
    end
    context 'urlが' do
      it '空の時登録失敗' do
        ss.url = nil
        expect(ss).not_to be_valid
      end
      it '重複している時登録失敗' do
        FactoryBot.create(:shortstory)
        ss2 = FactoryBot.build(:shortstory)
        expect(ss2).not_to be_valid
      end
    end
  end
end
