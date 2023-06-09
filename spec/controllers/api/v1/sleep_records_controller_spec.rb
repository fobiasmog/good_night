# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SleepRecordsController do
  let(:user) { create(:user) }
  let(:auth_user_id) { user.id }
  let(:params) { { auth_user_id: auth_user_id } }

  describe 'GET /sleep_records' do
    subject { get :index, params: params }

    it { is_expected.to have_http_status(:ok) }

    context 'when user has sleep records' do
      before { create_list(:sleep_record, 2, :completed_past_week, user: user) }

      it 'returns all user completed sleep records' do
        response = JSON.parse(subject.body)
        expect(response.size).to eq 2
      end
    end
  end

  describe 'POST /sleep_record' do
    subject { post :create, params: params }

    it { is_expected.to have_http_status(:created) }
    it { expect { subject }.to change(SleepRecord, :count).by(1) }

    context 'when trying to create record if not stopped already exist' do
      before { create(:sleep_record, user: user) }

      it { is_expected.to have_http_status(:accepted) }
      it { expect { subject }.not_to change(SleepRecord, :count) }
    end
  end

  describe 'PATCH /sleep_records/:id' do
    subject { patch :update, params: { id: sleep_record.id, **params } }

    let!(:sleep_record) { create(:sleep_record, created_at: Time.now - 1.hour, user: user) }

    it 'makes active sleep records as finished' do
      expect { subject }
        .to change { sleep_record.reload.stopped_at }
        .and change(sleep_record, :duration)
    end

    context 'when duration < 0' do
      let!(:sleep_record) { create(:sleep_record, created_at: Time.now + 1.hour, user: user) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it { expect { subject }.not_to change { sleep_record } }
    end
  end
end
