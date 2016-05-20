require 'rails_helper'

RSpec.describe Api::CrumbsController, type: :controller do
  let!(:tail) { FactoryGirl.create(:tail) }
  let(:crumb_params) do
    { record_date: Time.zone.now - 24.hours, 
      measurement: 200 }
  end

  context '#create' do
    context 'valid params' do
      before do
        request = post :create, { crumb: crumb_params, tail_id: tail.id }
      end

      it 'creates a new crumb associated with the tail' do
        crumb = Crumb.find_by(measurement: crumb_params[:measurement])
        expect(crumb.tail).to eq tail
        expect(crumb.measurement).to eq crumb_params[:measurement]
        expect(crumb.record_date.to_date).to eq crumb_params[:record_date].to_date
      end

      it { should respond_with 200 }
    end

    context 'invalid params' do
      context 'bad tail' do
        before do
          request = post :create, { crumb: crumb_params, tail_id: 1000 }
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
          request = post :create, { crumb: crumb_params, tail_id: crumb.tail }
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
  end

  context '#destroy' do
  end
end