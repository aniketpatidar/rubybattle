# frozen_string_literal: true

require 'challenge_creator'
include ChallengeCreator

namespace :db do
  desc 'Load specific seed data'
  task seed_challenges: :environment do
    seed_files = [
                   Rails.root.join('db', 'seeds', '01_easy_challenges.rb'),
                   Rails.root.join('db', 'seeds', '02_medium_challenges.rb'),
                 ]

    seed_files.each do |file|
      puts ''
      puts "Seeding data..."
      load(file)
    end

    puts ''
    puts "Seed data loaded successfully!"
  end
end
