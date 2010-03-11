require 'ostruct'
require 'yaml'

unless defined?(::WeConfig)
  config_hash = {}
  config_file = File.join(RAILS_ROOT, 'config', 'we_config.yml')
  if File.exist?(config_file)
    if (contents = YAML::load(ERB.new(IO.read(config_file)).result)) and (not contents.nil?)  
      if contents.has_key? Rails.env.downcase
        contents = contents[Rails.env.downcase]
      end
      config_hash.merge! contents
    end
  end
  ::WeConfig = OpenStruct.new(config_hash)
end
