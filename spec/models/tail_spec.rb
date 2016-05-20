require 'rails_helper'

RSpec.describe Tail, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:crumbs) }
  it { should validate_presence_of(:name) }

  context 'name scoping -' do
    let!(:tail) { FactoryGirl.create(:tail, name: 'test') }

    it 'should not allow same name for same user' do
      new_tail = FactoryGirl.build(:tail, name: 'test', user: tail.user)
      expect(new_tail.save).to eq false
    end

    it 'should allow different name for same user' do
      new_tail = FactoryGirl.build(:tail, user: tail.user)
      expect(new_tail.save).to eq true
    end

    it 'should allow same name for different user' do
      new_tail = FactoryGirl.build(:tail, name: 'test')
      expect(new_tail.save).to eq true
    end

    # TODO: Find syntax for scoped validations
    # it { should validate_uniqueness_of(:name).scoped_to(:user) } 
  end
end
