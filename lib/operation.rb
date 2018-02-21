# frozen_string_literal: true

class Operation
  class FailStep < StandardError; end

  def self.lane(lane_index, method, failure: nil, success: nil)
    @lanes ||= []
    @step_count ||= 0

    @lanes[lane_index] ||= []
    @lanes[lane_index][@step_count] = {
      method: method,
      success: success,
      failure: failure
    }

    @step_count += 1
    @lanes
  end

  def self.lanes
    @lanes
  end

  def self.run(options = {})
    lane_index = lanes.index { |v| !v.nil? }
    step_index = 0

    new.run(options, lane_index, step_index)
  end

  def run(options, lane_index = 0, step_index = 0)
    return options if step_index > last_step_index
    current_step = lanes[lane_index][step_index]

    begin
      send(current_step[:method], options) if current_step
      run(options, current_step.try(:[], :success) || lane_index, step_index + 1)
    rescue FailStep
      next_lane_index = current_step[:failure] || lane_index + 1
      run(options, next_lane_index, step_index + 1)
    end
  end

  def lanes
    self.class.lanes
  end

  def last_step_index
    @lsi ||= lanes.sort_by(&:length).last.length - 1
  end
end
