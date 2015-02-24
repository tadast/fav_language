require 'spec_helper'
require 'ostruct'

module FavLanguage
  describe LanguageStats do
    class TestRepoList
      def initialize(*args)
      end

      def language_stats
        [
          OpenStruct.new(language: "JavaScript", bytes: 3),
          OpenStruct.new(language: "JavaScript", bytes: 3),
          OpenStruct.new(language: "Ruby", bytes: 4),
          OpenStruct.new(language: "Ruby", bytes: 5),
          OpenStruct.new(language: "CoffeeScript", bytes: 4)
        ]
      end
    end

    describe "#fetch" do
      it "groups repo stats by language and sums the bytes written as weight" do
        stats = described_class.new(username: 'test', repo_list_class: TestRepoList).fetch

        expect(stats.map(&:language)).to match_array ["Ruby", "JavaScript", "CoffeeScript"]
        expect(stats.find{ |s| s.language == "Ruby" }.weight).to eq 9
      end
    end
  end
end
