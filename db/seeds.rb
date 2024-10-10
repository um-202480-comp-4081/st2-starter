# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

YogaPose.create!(
  name:         'Boat',
  sanskrit:     'Paripurna Navasana',
  part_of_body: 'Abs'
)

YogaPose.create!(
  name:         'Bridge',
  sanskrit:     'Setu Bandha Sarvangasana',
  part_of_body: 'Abs'
)

YogaPose.create!(
  name:         'Downward-Facing Dog',
  sanskrit:     'Adho Mukha Svanasana',
  part_of_body: 'Arms'
)

YogaPose.create!(
  name:         'Crow',
  sanskrit:     'Bakasana',
  part_of_body: 'Arms'
)

YogaPose.create!(
  name:         'Cat',
  sanskrit:     'Marjaryasana',
  part_of_body: 'Hips'
)

YogaPose.create!(
  name:         'Cow',
  sanskrit:     'Bitilasana',
  part_of_body: 'Hips'
)
