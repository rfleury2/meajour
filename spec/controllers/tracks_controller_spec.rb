require 'rails_helper'

RSpec.describe Api::TracksController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }

  context 'no current user' do
    before do
      allow_any_instance_of(Api::TracksController).to receive(:current_user).and_return(nil)
    end
  end

  context 'with current user' do
    before do
      allow_any_instance_of(Api::TracksController).to receive(:current_user).and_return(user)
    end

    describe '#index' do
      context 'no tracks' do
        before do
          response = get :index
        end

        it 'returns a blank json' do
        end
      end

      context 'with tracks' do

      end
    end
  end
end
