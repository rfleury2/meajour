require 'rails_helper'

RSpec.describe Track, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:crumbs) }
  it { should validate_presence_of(:name) }

  context 'name scoping -' do
    let(:user) { FactoryGirl.build(:user) }
    let!(:track) { FactoryGirl.create(:track, name: 'test') }

    it 'should not allow same name for same user' do
      new_track = FactoryGirl.build(:track, name: 'test', user: track.user)
      expect(new_track.save).to eq false
    end

    it 'should allow different name for same user' do
      new_track = FactoryGirl.build(:track, user: track.user)
      expect(new_track.save).to eq true
    end

    it 'should allow same name for different user' do
      new_track = FactoryGirl.build(:track, name: 'test', user: user)
      expect(new_track.save).to eq true
    end

    # TODO: Find syntax for scoped validations
    # it { should validate_uniqueness_of(:name).scoped_to(:user) } 
  end
end
