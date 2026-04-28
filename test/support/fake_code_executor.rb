class FakeCodeExecutor
  def initialize(all_pass: true)
    @all_pass = all_pass
  end

  def run_tests(_code, tests, _method_template)
    tests.each_with_index.with_object({}) do |(test, idx), hash|
      output = @all_pass ? test[:expected_output].to_s : "wrong_output"
      hash["test_#{idx}"] = {
        passed: @all_pass,
        output: output,
        expected: test[:expected_output].to_s,
        error: nil
      }
    end
  end
end
