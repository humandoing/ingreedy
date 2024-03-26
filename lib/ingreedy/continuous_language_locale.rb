module Ingreedy
  module ContinuousLanguageLocale
    CONTINUOUS_LANGUAGES_LOCALES = [:ja].freeze

    def use_whitespace?(locale)
      !CONTINUOUS_LANGUAGES_LOCALES.include?(locale)
    end
  end
end
