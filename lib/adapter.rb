module Weebo
  class << self

    def publish(text)
      # slack:
      #   hook:
      adapters.each do |adptr|
        if config.has_key?(adptr)
          next if config[adptr].values.any?(&:empty?)

          klass = Weebo.const_get(adptr.capitalize)
          params = config[adptr]
          object = klass.new(params)

          if object.respond_to?(:say)
            object.send(:say, text)
          end
        end
      end
    end

    def adapters
      config.keys if config.any?
    end

    def config
      load_yaml_file
    end

    def load_yaml_file(file_name='./lib/config.yml')
      raw_config = File.open(file_name)
      yaml = YAML::load(raw_config)

      Weebo::Util.symbolize_keys(yaml)
    end
  end
end
