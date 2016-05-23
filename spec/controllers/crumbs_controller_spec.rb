require 'rails_helper'

RSpec.describe Api::CrumbsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let!(:track) { FactoryGirl.create(:track, user: user) }
  let(:crumb_params) do
    { record_date: Time.zone.now - 24.hours, 
      measurement: 200 }
  end

  context '#create' do
    context 'valid params' do
      before do
        request = post :create, { crumb: crumb_params, track_id: track.id }
      end

      it 'creates a new crumb associated with the track' do
        crumb = Crumb.find_by(measurement: crumb_params[:measurement])
        expect(crumb.track).to eq track
        expect(crumb.measurement).to eq crumb_params[:measurement]
        expect(crumb.record_date.to_date).to eq crumb_params[:record_date].to_date
      end

      it { should respond_with 200 }
    end

    context 'invalid params' do
      context 'bad track' do
        before do
          request = post :create, { crumb: crumb_params, track_id: 1000 }
        end

        it 'does not create new crumb' do
          crumb = Crumb.find_by(measurement: crumb_params[:measurement])
          expect(crumb).to be_nil
        end

        it { should respond_with 401 }
      end

      context 'bad user' do
        # TODO: implement proper #current_user mock to test this
        before do
          request = post :create, { crumb: crumb_params, track_id: track.id }
        end

        # it 'does not create new crumb' do
        #   crumb = Crumb.find_by(measurement: crumb_params[:measurement])
        #   expect(crumb).to be_nil
        # end

        # it { should respond_with 401 }
      end
    end
  end

  context '#update' do
    let!(:crumb) { FactoryGirl.create(:crumb, track: track) }

    context 'valid params' do
      before do
        request = put :update, { crumb: crumb_params, track_id: track.id, id: crumb.id }
      end

      it { should respond_with 200 }

      it 'updates crumb with new information' do
        new_crumb = Crumb.find_by(measurement: 200)
        expect(new_crumb.id).to eq crumb.id
      end
    end

    context 'invalid params' do
      before do
        request = put :update, { crumb: {measurement: 'not_a_number'}, track_id: track.id, id: crumb.id }
      end

      it { should respond_with 401 }

      it 'does not update crumb' do
        new_crumb = Crumb.find_by(measurement: 'not_a_number')
        expect(new_crumb).to be_nil
      end
    end
  end

  context '#destroy' do
    # TODO: current_user to mock fraudulent request
    let!(:crumb) { FactoryGirl.create(:crumb, track: track) }

    context 'valid crumb' do
      before do
        request = delete :destroy, { track_id: track.id, id: crumb.id }
      end

      it 'destroys the crumb' do
        crumbs = track.crumbs
        expect(crumbs).to be_empty
      end

      it { should respond_with 200 }
    end

    context 'invalid crumb' do
      before do
        request = delete :destroy, { track_id: track.id, id: 10000 }
      end

      it 'does not destroy the crumb' do
        crumbs = track.crumbs
        expect(crumbs).to_not be_empty
      end

      it { should respond_with 401 }
    end

    context 'valid crumb, invalid track' do
      before do
        request = delete :destroy, { track_id: 10000, id: crumb.id }
      end

      it 'does not destroy the crumb' do
        crumbs = track.crumbs
        expect(crumbs).to_not be_empty
      end

      it { should respond_with 401 }
    end
  end
end