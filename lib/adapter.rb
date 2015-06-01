require 'yaml'

module Weebo
  class << self

    def publish(text)
      # slack:
      #   hook: ..      
      adapters.each do |adptr|
        raise ArgumentError '#' if config[adptr].values.any?(&:empty?)

        klass = Weebo.const_get(adptr.capitalize)
        params = config[adptr]

        object = klass.new(params)

        if object.respond_to?(:say)
          object.send(:say, text)
        end
      end
    end

    def adapters
      config.keys if config.any?
    end

    def config
      load_yaml_file
    end

    def load_yaml_file(file_name='./lib/default.yml')
      raw_config = File.open(file_name)
      yaml = YAML::load(raw_config)

      symbolize_keys(yaml)
    end

    def symbolize_keys(hash)
      hash.inject({}) { |res, (k, v)|
        n_k = k.is_a?(String) ? k.to_sym : k
        n_v = v.is_a?(Hash) ? symbolize_keys(v) : v
        res[n_k] = n_v
        res
      }
    end
  end
end