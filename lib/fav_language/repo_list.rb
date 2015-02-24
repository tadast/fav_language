require 'github_api'

module FavLanguage
  class RepoList
    attr_reader :github, :username

    def initialize(github:, username:)
      @github = github
      @username = username
    end

    def fetch
      @repos ||= github.repos
                  .list(user: username, auto_pagination: true)
                  .reject{ |r| r["fork"] }
                  .map{ |r| Repo.new(r, github: github) }
    end

    def language_stats
      fetch.flat_map do |repo|
        repo.language_stats
      end
    end
  end
end
