module Ingreedy
  module ContinuousLanguageLocale
    CONTINUOUS_LANGUAGES_LOCALES = %i(ja th zh-TW)

    def use_whitespace?(locale)
      !CONTINUOUS_LANGUAGES_LOCALES.include?(locale)
    end
  end
end
