require 'rails_helper'

RSpec.describe Api::TailsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }

  context 'no current user' do
    before do
      allow_any_instance_of(Api::TailsController).to receive(:current_user).and_return(nil)
    end
  end

  context 'with current user' do
    before do
      allow_any_instance_of(Api::TailsController).to receive(:current_user).and_return(user)
    end

    describe '#index' do
      context 'no tails' do
        before do
          response = get :index
        end

        it 'returns a blank json' do
        end
      end

      context 'with tails' do

      end
    end
  end
end
