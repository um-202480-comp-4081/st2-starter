# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YogaPosesController do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let!(:yoga_pose) { create(:yoga_pose) }

    it 'returns a success response' do
      get :show, params: { id: yoga_pose }
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get :show, params: { id: yoga_pose }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Track' do
        expect do
          post :create, params: { yoga_pose: attributes_for(:yoga_pose) }
        end.to change(YogaPose, :count).by(1)
      end

      it 'redirects to the created yoga_pose' do
        post :create, params: { yoga_pose: attributes_for(:yoga_pose) }
        expect(response).to redirect_to(yoga_poses_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new YogaPose' do
        expect do
          post :create, params: { yoga_pose: attributes_for(:yoga_pose, part_of_body: nil) }
        end.not_to change(YogaPose, :count)
      end

      it 're-renders the new template' do
        post :create, params: { yoga_pose: attributes_for(:yoga_pose, part_of_body: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
