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
require 'rails_helper'

RSpec.describe YogaPose do
  it 'has seeds' do
    load Rails.root.join('db/seeds.rb').to_s

    expect(described_class.count).to eq 6
    expect(described_class.order(:name).pluck(:name, :part_of_body, :sanskrit))
      .to eq [['Boat', 'Abs', 'Paripurna Navasana'],
              ['Bridge', 'Abs', 'Setu Bandha Sarvangasana'],
              ['Cat', 'Hips', 'Marjaryasana'],
              ['Cow', 'Hips', 'Bitilasana'],
              ['Crow', 'Arms', 'Bakasana'],
              ['Downward-Facing Dog', 'Arms', 'Adho Mukha Svanasana']]
  end
end
