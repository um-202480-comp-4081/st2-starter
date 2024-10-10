# frozen_string_literal: true

# == Schema Information
#
# Table name: yoga_poses
#
#  id           :bigint           not null, primary key
#  name         :string
#  part_of_body :string
#  sanskrit     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :yoga_pose do
    name { 'Mountain' }
    part_of_body { 'Legs' }
    sanskrit { 'Tadasana' }
  end
end
