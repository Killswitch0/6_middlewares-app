class RequestTimelogger
  attr_reader :app, :logger_identifier

  def initialize(app, logger_identifier = '*')
    @app = app
    @logger_identifier = logger_identifier
  end

  # метод call вызывается на дубликате объекта, что будет гарантировать нам полную потокобезопасность
  # мы защищены от того, что наш оригинальный объект не изменится, передаваясь в каждую middleware, и
  # попадёт в контроллер целостным.
  def call(env)
    dup.send(:_call, env) # то же самое, что self.send(:_call, env), где self - это app
  end

  private

  def beauty_logging(time)
    Rails.logger.debug(logger_identifier * 50)
    Rails.logger.debug("Request time: #{time}")
    Rails.logger.debug(logger_identifier * 50)
  end

  def _call(env)
    request_received_at = Time.now

    @status, @headers, @response = app.call(env)
    debugger

    request_handled_at = Time.now
    beauty_logging(request_handled_at - request_received_at)

    [@status, @headers, @response]
  end
end