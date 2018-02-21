class Result
  def initialize(errors: [], value:)
    @errors = errors
    @value = value
  end

  def success?
    errors.empty?
  end
end

