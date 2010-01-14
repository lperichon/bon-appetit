module LocalesSwitch
  LOCALES_DIRECTORY = "#{RAILS_ROOT}/config/locales/" 
  AVAILABLE_LOCALES =
    Dir.new(LOCALES_DIRECTORY).entries.collect do |x|
      x =~ /\.yml/ ? x.sub(/\.yml/,"") : nil
    end.compact.each_with_object({}) do |str, hsh|
      hsh[str] = YAML.load_file(LOCALES_DIRECTORY + str + ".yml")[str]["this_file_language"]
    end.freeze
  
  LOCALE_IDENTIFIER = :locale
  
  module Controller
    def self.included(base)
      base.class_eval do
        prepend_before_filter :set_locale        
      end
    end
  
    protected
    
    def set_locale
      # I18n.default_locale returns the current default locale. Defaults to 'en-US'
      locale = params[LOCALE_IDENTIFIER] || session[LOCALE_IDENTIFIER] || (current_user.send(LOCALE_IDENTIFIER) if logged_in?) || I18n.default_locale
      session[LOCALE_IDENTIFIER] = I18n.locale = locale
    end
    
    def available_locales
      AVAILABLE_LOCALES
    end
  end
  
  module Helper
    def language_selection(&block)
      def_proc = lambda{|language_code, language|
        link_to_unless(I18n.locale == language_code, language, params.merge(LOCALE_IDENTIFIER => language_code)) + "&nbsp;"  
      }
      AVAILABLE_LOCALES.collect do |language_code, language|
        if block_given?
          yield language_code, language
        else
          def_proc.call language_code, language
        end
      end.join ''
    end
    
    # params key that identificate a locale code
    def locale_identifier
      LOCALE_IDENTIFIER
    end
  end
end