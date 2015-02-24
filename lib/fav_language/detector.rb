module FavLanguage
  class Detector
    def initialize(username:, token: nil, stats_class: LanguageStats)
      @username = username
      @token = token
      @stats_class = stats_class
    end

    def print
      message = favourite_languages.map do |weighted_language|
        "#{weighted_language.language}: #{weighted_language.weight} bytes written"
      end.join("\n")
      puts message
    end

    def favourite_languages
      max_weight = weighted_languages.map(&:weight).max
      weighted_languages.select{ |lww| lww.weight == max_weight }
    end

  private
    attr_reader :username, :token

    def weighted_languages
      validate_username
      @weighted_languages ||= @stats_class.new(username: username, token: token).fetch
    end

    def validate_username
      if username.to_s.size == 0
        raise "Please provide GitHub username"
      end
    end
  end
end
