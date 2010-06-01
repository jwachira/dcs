require 'ostruct'
require 'yaml'

unless defined?(::ApplicationConfig)
  class AppConfigStruct < OpenStruct
    def initialize(args)
      super
    end
    def method_missing(mid, *args)
      if mid.to_s =~ /(.+)\?$/
        val = send($1)
        if val.is_a?(FalseClass) or val.is_a?(TrueClass)
          return val
        else
          return ![0, 'nil'].include?(val)
        end
      else
        super
      end
    end
  end
  config_hash = {}
  config_file = File.join(RAILS_ROOT, 'config', 'application_config.yml')
  if File.exist?(config_file)
    if (contents = YAML::load(ERB.new(IO.read(config_file)).result)) and (not contents.nil?)
      if contents.has_key? Rails.env.downcase
        contents = contents[Rails.env.downcase]
      end
      config_hash.merge! contents
    end
  end
  ::ApplicationConfig = AppConfigStruct.new(config_hash)
end
