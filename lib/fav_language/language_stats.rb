module FavLanguage
  class LanguageStats
    def initialize(username:, token: nil, repo_list_class: RepoList)
      @username = username
      @token = token
      @repo_list_class = repo_list_class
    end

    def fetch
      language_stats.group_by(&:language).map do |language, stats|
        OpenStruct.new(language: language, weight: stats.inject(0){ |sum, next_one| sum + next_one.bytes })
      end
    end

  private
    attr_reader :username, :token

    def language_stats
      @repo_list_class.new(github: github, username: username).language_stats
    end

    def github
      @github ||= Github.new(oauth_token: token || ENV['GH_AUTH_TOKEN'])
    end
  end
end
