require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe "GET /index" do
    subject { get :index, params: params }

    let(:params) { {} }

    it { is_expected.to have_http_status(:success) }

    context 'with empty users table' do
      it { expect(subject.body).to eq '[]' }
    end

    context 'with non empty response' do
      before { create_list(:user, 15) }

      it { is_expected.to have_http_status(:success) }
      it 'returns limited size of records' do
        users = JSON.parse(subject.body)

        expect(users.size).to eq User.per_page
      end

      context 'with page param' do
        let(:page) { 2 }
        let(:params) { { page: page } }

        it { is_expected.to have_http_status(:success) }
        it 'returns limited size of records' do
          users = JSON.parse(subject.body)

          expect(users.size).to eq 5
        end
      end
    end
  end
end
