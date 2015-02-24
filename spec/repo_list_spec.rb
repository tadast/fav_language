require 'spec_helper'
require 'ostruct'

module FavLanguage
  describe RepoList do
    describe "#fetch" do
      it "omits forks" do
        repo_list = double
        allow(repo_list).to receive(:list).and_return([{"fork" => true}, {"fork" => false}])
        gh_stub = OpenStruct.new(repos: repo_list)

        repos = described_class.new(github: gh_stub, username: 'test').fetch
        expect(repos.size).to eq 1
      end
    end

    describe "#language_stats" do
      it "flattens the repos' language stats" do
        subject = described_class.new(github: :gh, username: 'test')
        allow(subject).to receive(:fetch).and_return([
          OpenStruct.new(language_stats: [OpenStruct.new(language: "Ruby", bytes: 4), OpenStruct.new(language: 'JavaScript', bytes: 2)]),
          OpenStruct.new(language_stats: [OpenStruct.new(language: "CoffeeScript", bytes: 4)])
        ])

        expect(subject.language_stats.map(&:language)).to match_array ["Ruby", "JavaScript", "CoffeeScript"]
      end
    end
  end
end
