class CodeEvaluation
  Result = Data.define(:test_results, :all_passed, :completion, :duel_resolved) do
    def all_passed? = all_passed
    def duel_resolved? = duel_resolved
  end

  def self.run(user:, challenge:, code:, duel_id: nil, broadcaster: ActionCable.server, executor: Judge0Service.new)
    new(user:, challenge:, code:, duel_id:, broadcaster:, executor:).run
  end

  def initialize(user:, challenge:, code:, duel_id:, broadcaster:, executor:)
    @user        = user
    @challenge   = challenge
    @code        = code
    @duel_id     = duel_id
    @broadcaster = broadcaster
    @executor    = executor
  end

  def run
    test_results = @executor.run_tests(@code, @challenge.parsed_tests, @challenge.method_template)
    all_passed   = test_results.values.all? { |r| r[:passed] }
    completion   = ChallengeCompletion.find_or_create_by(user: @user, challenge: @challenge) if all_passed
    duel_resolved = broadcast_duel_progress(@duel_id, test_results, all_passed) if @duel_id.present?

    Result.new(
      test_results:,
      all_passed:,
      completion:,
      duel_resolved: duel_resolved || false
    )
  end

  private

  def broadcast_duel_progress(duel_id, test_results, all_passed)
    duel = Duel.find_by(id: duel_id)
    return false unless duel&.active? && duel.participant?(@user)

    passed = test_results.values.count { |r| r[:passed] }
    total  = test_results.values.size

    @broadcaster.broadcast("duel_#{duel.id}", {
      type: "progress",
      user_id: @user.id,
      passed: passed,
      total: total
    })

    return false unless all_passed
    return false unless duel.resolve!(winner: @user)

    @broadcaster.broadcast("duel_#{duel.id}", {
      type: "duel_won",
      winner_id: @user.id,
      winner_name: @user.full_name
    })

    true
  end
end
