require 'fluent/output'
require 'json'

module Fluent
  class MDMOutput < Output
    # First, register the plugin. NAME is the name of this plugin
    # and identifies the plugin in the configuration file.
    Fluent::Plugin.register_output('mdm', self)

    # config_param defines a parameter. You can refer a parameter via @path instance variable
    # Without :default, a parameter is required.
    config_param :host, :string, :default => "0.0.0.0"
    config_param :port, :integer, :default => 8125

    # This method is called before starting.
    # 'conf' is a Hash that includes configuration parameters.
    # If the configuration is invalid, raise Fluent::ConfigError.
    def configure(conf)
      super

      # You can also refer raw parameter via conf[name].
      @conf = conf
    end

    # This method is called when starting.
    # Open sockets or files here.
    def start
      super
      @socket = UDPSocket.new(Socket::AF_INET)
    end

    # This method is called when shutting down.
    # Shutdown the thread and close sockets or files here.
    def shutdown
      super
    end

    # This method is called when an event reaches Fluentd.
    # 'es' is a Fluent::EventStream object that includes multiple events.
    # You can use 'es.each {|time,record| ... }' to retrieve events.
    # 'chain' is an object that manages transactions. Call 'chain.next' at
    # appropriate points and rollback if it raises an exception.
    #
    # NOTE! This method is called by Fluentd's main thread so you should not write slow routine here. It causes Fluentd's performance degression.
    def emit(tag, es, chain)
      chain.next
      es.each {|time,record|
        value = record["Value"]

        stat = {
          "Namespace"=> record["Namespace"],
          "Metric"=> record["Metric"],
          "Dims"=> record["Dimensions"]
        }

        metric = "#{stat.to_json}:#{value}|g"

        begin
          @socket.send(metric, 0, @host, @port)
        rescue Errno::ECONNREFUSED => error
          log.warn "Error connecting to #{@host} while sending the record \"#{record}\": #{error}"
        rescue => error
          log.error "Unhandled error trying to send MDM message: \"#{record}\""
        end
      }
    end

  end
end
