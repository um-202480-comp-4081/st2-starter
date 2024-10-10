# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes follow resource naming' do
  context 'when routing' do
    specify 'YogaPoses index' do
      expect(get: yoga_poses_path).to route_to 'yoga_poses#index'
    end

    specify 'YogaPoses show' do
      expect(get: yoga_pose_path(1)).to route_to controller: 'yoga_poses', action: 'show', id: '1'
    end

    specify 'YogaPoses new' do
      expect(get: new_yoga_pose_path).to route_to 'yoga_poses#new'
    end

    specify 'YogaPoses create' do
      expect(post: yoga_poses_path).to route_to 'yoga_poses#create'
    end
  end

  context 'when creating path helpers' do
    specify 'yoga_poses_path' do
      expect(yoga_poses_path).to eq '/yoga_poses'
    end

    specify 'new_yoga_pose_path' do
      expect(new_yoga_pose_path).to eq '/yoga_poses/new'
    end

    specify 'yoga_pose_path' do
      expect(yoga_pose_path(1)).to eq '/yoga_poses/1'
    end
  end
end
