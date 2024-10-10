# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Visitor Features' do
  let!(:yoga_pose_one) { create(:yoga_pose, name: 'Tree', part_of_body: 'Hips', sanskrit: 'Vrksasana') }
  let!(:yoga_pose_two) { create(:yoga_pose, name: 'Cobra', part_of_body: 'Back', sanskrit: 'Bhujangasana') }

  feature 'YogaPoses' do
    feature 'Browse YogaPoses', :js do
      scenario 'Viewing the yoga_pose index page content' do
        visit yoga_poses_path

        aggregate_failures do
          expect(page).to have_css('h1', exact_text: 'Yoga Poses')
          within('table') do
            within('tbody') do
              # expect(page).to have_css('tr', count: 2)

              within('tr:nth-child(1)') do
                expect(page).to have_css('td', count: 1)

                within('td') do
                  expect(page).to have_link(yoga_pose_two.name)
                end
              end

              within('tr:nth-child(2)') do
                expect(page).to have_css('td', count: 1)

                within('td') do
                  expect(page).to have_link(yoga_pose_one.name)
                end
              end
            end
          end
          expect(page).to have_link('New Pose')
        end
      end

      scenario 'Redirecting from the root page to the yoga_pose index page' do
        visit root_path

        expect(page).to have_current_path(yoga_poses_path, ignore_query: true)
      end
    end

    feature 'View YogaPose Details' do
      scenario 'Viewing a yoga_pose one show page content' do
        visit yoga_pose_path(yoga_pose_one)

        aggregate_failures do
          expect(page).to have_css('h1', count: 1)
          expect(page).to have_css('p', count: 3)
          expect(page).to have_css('a', count: 1)

          expect(page).to have_css('h1', exact_text: 'Tree Pose')
          expect(page).to have_css('p', exact_text: 'Vrksasana')
          expect(page).to have_css('p', exact_text: 'Part of Body: Hips')
          expect(page).to have_link('Back')
        end
      end

      scenario 'Viewing a yoga_pose two show page content' do
        visit yoga_pose_path(yoga_pose_two)

        aggregate_failures do
          expect(page).to have_css('h1', count: 1)
          expect(page).to have_css('p', count: 3)
          expect(page).to have_css('a', count: 1)

          expect(page).to have_css('h1', exact_text: 'Cobra Pose')
          expect(page).to have_css('p', exact_text: 'Bhujangasana')
          expect(page).to have_css('p', exact_text: 'Part of Body: Back')
          expect(page).to have_link('Back')
        end
      end

      scenario 'Navigating to a yoga_pose show page from the index page' do
        visit yoga_poses_path

        click_on 'Tree', match: :first

        expect(page).to have_current_path(yoga_pose_path(yoga_pose_one), ignore_query: true)
      end

      scenario 'Navigating back to the yoga_pose index page from the show page' do
        visit yoga_pose_path(yoga_pose_one)

        click_on 'Back'

        expect(page).to have_current_path(yoga_poses_path, ignore_query: true)
      end
    end

    feature 'Create New YogaPose' do
      scenario 'Viewing the new yoga_pose form page' do
        visit new_yoga_pose_path

        aggregate_failures do
          expect(page).to have_css('h1', exact_text: 'New Yoga Pose')
          expect(page).to have_field('Name')
          expect(page).to have_field('Part of body')
          expect(page).to have_field('Sanskrit')
          expect(page).to have_button('Create Yoga pose')
          expect(page).to have_link('Cancel')
        end
      end

      scenario 'Creating a new yoga_pose with valid details' do
        visit new_yoga_pose_path

        fill_in 'Name', with: 'Mountain'
        select 'Legs', from: 'Part of body'
        fill_in 'Sanskrit', with: 'Tadasana'
        click_on 'Create Yoga pose'

        expect(YogaPose.last).to have_attributes(name: 'Mountain', part_of_body: 'Legs', sanskrit: 'Tadasana')
        expect(page).to have_current_path(yoga_poses_path, ignore_query: true)
        expect(page).to have_css('.alert-success', exact_text: 'Yoga pose created successfully!')
        expect(page).to have_css('tbody tr', count: 3)
      end

      scenario 'Creating a new yoga_pose with missing name', :js do
        visit new_yoga_pose_path

        expect do
          select 'Legs', from: 'Part of body'
          fill_in 'Sanskrit', with: 'Tadasana'
          click_on 'Create Yoga pose'
        end.not_to change(YogaPose, :count)

        message = page.find_by_id('yoga_pose_name').native.attribute('validationMessage')
        expect(message).to match(/Please fill (out|in) this field\./)
      end

      scenario 'Creating a new yoga_pose with missing part_of_body' do
        visit new_yoga_pose_path

        expect do
          fill_in 'Name', with: 'Mountain'
          fill_in 'Sanskrit', with: 'Tadasana'
          click_on 'Create Yoga pose'
        end.not_to change(YogaPose, :count)

        expect(page).to have_css('.alert-danger', exact_text: 'Error! Unable to create yoga pose')
        expect(page).to have_content('is not included in the list', normalize_ws: true)
      end

      scenario 'Navigating to the new yoga_pose page from the index page' do
        visit yoga_poses_path

        click_on 'New Pose'

        expect(page).to have_current_path(new_yoga_pose_path, ignore_query: true)
      end

      scenario 'Navigating back to the yoga_pose index page from the new yoga_pose page' do
        visit new_yoga_pose_path

        click_on 'Cancel'

        expect(page).to have_current_path(yoga_poses_path, ignore_query: true)
      end
    end
  end
end
