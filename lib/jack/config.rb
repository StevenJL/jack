require 'fileutils'

module Jack
  module Config
    autoload :Base, 'jack/config/base'
    autoload :Diff, 'jack/config/diff'
    autoload :Download, 'jack/config/download'
    autoload :Sort, 'jack/config/sort'
    autoload :Transmit, 'jack/config/transmit'
    autoload :Upload, 'jack/config/upload'
    autoload :YamlFormatter, 'jack/config/yaml_formatter'
  end
end