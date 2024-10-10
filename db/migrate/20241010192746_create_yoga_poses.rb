# frozen_string_literal: true

class CreateYogaPoses < ActiveRecord::Migration[7.0]
  def change
    create_table :yoga_poses do |t|
      t.string :name
      t.string :part_of_body
      t.string :sanskrit

      t.timestamps
    end
  end
end
