require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'アソシエーションについて' do
    context 'Userモデルとの関係' do
      it 'belongs to follower' do
        association = Relationship.reflect_on_association(:follow)
        expect(association.macro).to eq :belongs_to
      end

      it 'belongs to followed' do
        association = Relationship.reflect_on_association(:followed)
        expect(association.macro).to eq :belongs_to
      end
    end
  end

  describe 'バリデーションについて' do
    context 'フォローする人とフォロワーが同じ場合' do
      let(:user) { create(:user) }
      subject(:relationship) { build(:relationship, follow_id: user.id, followed_id: user.id) }

      it 'is invalid' do
        expect(relationship.valid?).to be_falsey
      end

      it 'adds error message' do
        relationship.valid?
        expect(relationship.errors[:followed]).to include('自分をフォローすることは出来ません！')
      end
    end
  end
end
