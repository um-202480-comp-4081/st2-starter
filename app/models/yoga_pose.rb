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
class YogaPose < ApplicationRecord
  validates :name, presence: true
  validates :part_of_body, inclusion: { in: %w[Legs Abs Arms Back Hamstrings Hips Chest Shoulders] }
end
