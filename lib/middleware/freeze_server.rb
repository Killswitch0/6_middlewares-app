class FreezeServer
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = app.call(env)

    sleep 2

    [@status, @headers, @response]
  end
end