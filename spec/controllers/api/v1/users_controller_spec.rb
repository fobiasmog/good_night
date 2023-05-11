require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  let(:user) { create(:user) }
  let(:auth_user_id) { user.id }
  let(:params) { { auth_user_id: auth_user_id } }

  describe "GET /index" do
    subject { get :index, params: params }

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

      context 'with second page parameter' do
        let(:page) { 2 }
        let(:params) { { page: page, auth_user_id: auth_user_id } }

        it { is_expected.to have_http_status(:success) }
        it 'returns limited size of records' do
          users = JSON.parse(subject.body)

          expect(users.size).to eq 5
        end
      end
    end
  end
end
