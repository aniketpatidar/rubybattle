# frozen_string_literal: true

require_relative "../lib/challenge_creator"
include ChallengeCreator

Dir[Rails.root.join("db/seeds/*.rb")].sort.each { |f| load f }
