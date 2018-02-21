# frozen_string_literal: true

class Project::Index < Operation
  lane 0, :happy1
  lane 0, :happy2
  lane 1, :fail1, success: 0
  lane 0, :happy3

  def happy1(options)
    options['happy'] ||= []
    options['happy'] << 1
  end

  def happy2(options)
    raise FailStep
    options['happy'] ||= []
    options['happy'] << 2
  end

  def happy3(options)
    options['happy'] ||= []
    options['happy'] << 3
  end

  def fail1(options)
    options['fail'] ||= []
    options['fail'] << 1
  end
end
