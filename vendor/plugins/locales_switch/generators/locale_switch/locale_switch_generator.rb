class LocaleSwitchGenerator < Rails::Generator::NamedBase
  attr_reader :table
  def initialize(runtime_args, runtime_options = {})
    @table = (runtime_args[0] || 'users').tableize
    runtime_args = Array("#{@table}_add_locale_identifier".pluralize)
    super
  end

  def manifest
    record do |m|
      m.migration_template 'migration.rb', 'db/migrate'
    end
  end
end
