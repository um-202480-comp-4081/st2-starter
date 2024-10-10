# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'yoga_poses/new.html.erb' do
  context 'when empty model object' do
    before do
      assign :yoga_pose, YogaPose.new

      allow(view).to receive(:bootstrap_form_with).and_call_original
      allow(view).to receive(:link_to).and_call_original
      allow(view).to receive(:yoga_poses_path).and_call_original

      render
    end

    it 'uses bootstrap_form_with helper for forms' do
      expect(view).to have_received(:bootstrap_form_with).once
    end

    it 'uses link_to helper for links' do
      expect(view).to have_received(:link_to).once
    end

    it 'uses appropriate route helper(s)' do
      expect(view).to have_received(:yoga_poses_path).twice
    end

    it 'has properly closed HTML tags' do
      %w[h1 h2 h3 h4 h5 h6 p a div span ul ol li b i strong table thead tbody tr th td].each do |tag|
        expect(rendered.scan(/<#{tag}[ >]/).size).to eq(rendered.scan("</#{tag}>").size), -> { "check #{tag} tags" }
      end
    end

    it 'does not duplicate elements from layout' do
      %w[head style body].each do |el|
        expect(rendered.scan(/<#{el}[ >]/).size).to eq(0)
      end
    end

    it 'has only the required elements and text' do
      page_elements = Nokogiri::HTML.parse(rendered).search('*').map(&:name)
      expect(page_elements).to eq %w[html body h1 form div label input div label select option option option option
                                     option option option option option div label input input a]
      page_text = Nokogiri::HTML.parse(rendered).text.gsub(/\s+/, '')
      expect(page_text).to eq 'NewYogaPoseNamePartofbodyLegsAbsArmsBackHamstringsHipsChestShouldersSanskritCancel'
    end
  end

  context 'when model object has errors' do
    before do
      pose = build(:yoga_pose, part_of_body: '')
      pose.valid?
      assign :yoga_pose, pose

      allow(view).to receive(:bootstrap_form_with).and_call_original
      allow(view).to receive(:link_to).and_call_original
      allow(view).to receive(:yoga_poses_path).and_call_original

      render
    end

    it 'has only the required elements and text' do
      page_elements = Nokogiri::HTML.parse(rendered).search('*').map(&:name)
      # pp page_elements
      expect(page_elements).to eq %w[html body h1 form div label input div label select option option option option
                                     option option option option option div div label input input a]
      page_text = Nokogiri::HTML.parse(rendered).text.gsub(/\s+/, '')
      # pp page_text
      expect(page_text).to eq 'NewYogaPoseNamePartofbodyLegsAbsArmsBackHamstringsHipsChestShouldersisnotincludedinthelistSanskritCancel'
    end
  end
end
