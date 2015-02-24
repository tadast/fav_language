require 'github_api'

module FavLanguage
  class Repo
    attr_reader :github

    def initialize(raw, github:)
      @raw = raw
      @github = github
    end

    def language_stats
      github.get_request(@raw['languages_url']).body.to_h.map do |language, bytes|
        OpenStruct.new(language: language, bytes: bytes.to_i)
      end
    end
  end
end
