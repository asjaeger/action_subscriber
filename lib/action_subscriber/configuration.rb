module ActionSubscriber
  class Configuration
    attr_accessor :allow_low_priority_methods, :decoder, :default_exchange,
      :error_handler, :host, :port, :threadpool_size

    def initialize
      self.allow_low_priority_methods = false
      self.decoder = {
        'application/json' => lambda { |payload| JSON.parse(payload) },
        'text/plain' => lambda { |payload| payload.dup }
      }
      self.default_exchange = :events
      self.error_handler = lambda { |error| raise }
      self.host = 'localhost'
      self.port = 5672
      self.threadpool_size = 8
    end

    ##
    # Instance Methods
    #
    def add_decoder(hash)
      self.decoder.merge!(hash)
    end

    def inspect
      inspection_string  = <<-INSPECT.strip_heredoc
        Rabbit Host: #{host}
        Rabbit Port: #{port}
        Threadpool Size: #{threadpool_size}
        Low Priority Subscriber: #{allow_low_priority_methods}
        Decoders:
      INSPECT
      decoder.each_key { |key| inspection_string << "  --#{key}\n" }
      return inspection_string
    end
  end
end
