require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションについて' do
    it 'ユーザーの作成が有効であること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'メールアドレスが入力されていない場合、無効であること' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it 'メールアドレスがすでに存在する場合は、無効であること' do
      FactoryBot.create(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it '名前がない場合、無効であること' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'パスワードが短い場合、無効であること' do
      user = FactoryBot.build(:user, password: 'short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end
  end
end
