module LicenseFinder
  module Persistence
    class Configuration
      attr_accessor :whitelist, :ignore_groups, :dependencies_dir

      def self.config_file_path
        File.join('.', 'config', 'license_finder.yml')
      end

      def self.ensure_default
        make_config_file unless File.exists?(config_file_path)
        new
      end

      def self.make_config_file
        FileUtils.mkdir_p(File.join('.', 'config'))
        FileUtils.cp(
          File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'files', 'license_finder.yml'),
          config_file_path
        )
      end

      def initialize(config={})
        if File.exists?(config_file_path)
          yaml = File.read(config_file_path)
          config = YAML.load(yaml).merge config
        end

        @whitelist = config['whitelist'] || []
        @ignore_groups = (config["ignore_groups"] || []).map(&:to_sym)
        @dependencies_dir = config['dependencies_file_dir'] || './doc/'
        FileUtils.mkdir_p(@dependencies_dir)
      end

      def config_file_path
        self.class.config_file_path
      end

      def dependencies_yaml
        File.join(dependencies_dir, "dependencies.yml")
      end

      def dependencies_text
        File.join(dependencies_dir, "dependencies.txt")
      end

      def dependencies_html
        File.join(dependencies_dir, "dependencies.html")
      end
    end
  end
end
