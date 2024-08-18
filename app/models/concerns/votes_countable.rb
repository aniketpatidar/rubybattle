require 'active_support/concern'

module VotesCountable
  extend ActiveSupport::Concern

  included do
    def total_vote_count
      upvotes = self.get_upvotes(vote_scope: "like").size
      downvotes = self.get_downvotes(vote_scope: "like").size
      (upvotes - downvotes).to_s
    end
  end
end
