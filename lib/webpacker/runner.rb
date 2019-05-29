module Webpacker
  class Runner
    def self.run(argv)
      $stdout.sync = true

      new(argv).run
    end

    def initialize(argv)
      @argv = argv

      $stderr.puts "*"*100
      @app_path              = File.expand_path(".", Dir.pwd)
      $stderr.puts `npm bin`
      $stderr.puts ENV["WEBPACKER_NODE_MODULES_BIN_PATH"]
      @node_modules_bin_path = ENV["WEBPACKER_NODE_MODULES_BIN_PATH"] || `yarn bin`.chomp
      $stderr.puts @node_modules_bin_path
      @webpack_config        = File.join(@app_path, "config/webpack/#{ENV["NODE_ENV"]}.js")
      $stderr.puts @webpack_config

      unless File.exist?(@webpack_config)
        $stderr.puts "webpack config #{@webpack_config} not found, please run 'bundle exec rails webpacker:install' to install Webpacker with default configs or add the missing config file for your custom environment."
        exit!
      end
    end
  end
end
