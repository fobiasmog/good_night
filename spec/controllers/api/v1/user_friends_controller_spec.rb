# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UserFriendsController do
  let(:user) { create(:user) }
  let(:auth_user_id) { user.id }
  let(:params) { { auth_user_id: auth_user_id } }

  describe 'GET /friends' do
    subject { get :index, params: params }

    before do
      create_list(:user_friend, friends_count, user: user)
    end

    let(:friends_count) { 3 }

    it { is_expected.to have_http_status(:ok) }

    it 'returns list of user friends' do
      response = JSON.parse(subject.body)
      expect(response.size).to eq friends_count
    end
  end

  describe 'POST /friends' do
    subject { post :create, params: { user_id: friend_user.id, **params } }

    let(:friend_user) { create(:user) }

    it { is_expected.to have_http_status(:created) }
    it { expect{ subject }.to change(UserFriend, :count).by(1) }

    context 'when trying to add user who alredy your friend' do
      before do
        create(:user_friend, user_id: user.id, friend_user_id: friend_user.id)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE /friends' do
    subject { delete :destroy, params: {id: friend_user.id, **params} }

    before do
      create(:user_friend, user_id: user.id, friend_user_id: friend_user.id)
    end

    let(:friend_user) { create(:user) }

    it { is_expected.to have_http_status(:no_content) }
    it { expect{ subject }.to change(UserFriend, :count).from(1).to(0) }
  end

  describe 'GET /friends/sleep_records' do
    subject { get :sleep_records, params: params }

    before do
      create(:user_friend, user_id: user.id, friend_user_id: friend_user.id)

      create(:sleep_record, :completed_past_month, user: friend_user)
      create(:sleep_record, :completed_this_week, user: friend_user)
    end

    let(:friend_user) { create(:user) }
    let!(:past_week_record) { create(:sleep_record, :completed_past_week, user: friend_user) }

    it { is_expected.to have_http_status(:ok) }

    it 'returns only this week completed records' do
      response = JSON.parse(subject.body)

      expect(response.size).to eq 1
      expect(response.first['id']).to eq past_week_record.id
    end
  end
end
