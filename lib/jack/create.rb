require "yaml"

module Jack
  class Create
    include Util

    def initialize(options={})
      @options = options
      @root = options[:root] || '.'
      @env_name = options[:env_name]
      @app_name = options[:app] || app_name_convention(@env_name)
    end

    def run
      create_app
      EbConfig::Create.new(@options).sync unless @options[:noop]
      create_env
    end

    def create_app
      eb.create_application(
        application_name: @app_name
      ) unless app_exist?
    end

    def app_exist?
      return true if @options[:noop]
      r = eb.describe_applications
      r.applications.collect(&:application_name).include?(@app_name)
    end

    def create_env
      command = build_command
      do_cmd(command, @options)
    end

    def build_command
      @cfg = upload_cfg
      flags = CreateYaml.new.flags
      "eb create --sample --nohang #{flags} #{@cfg}#{cname}#{@env_name}"
    end

    def upload_cfg
      @upload = Config::Upload.new(@options.merge(skip_sync: true))
      if @upload.local_cfg_exist?
        @upload.upload 
        cfg = "--cfg #{@upload.upload_name} "
      end
    end

    def cname
      "--cname #{@env_name} "
    end

  end
end