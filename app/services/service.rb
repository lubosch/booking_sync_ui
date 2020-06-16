class Service
  def initialize(*_args)
  end

  def self.call(*args)
    new(*args).call
  end

  def call

  end
end
