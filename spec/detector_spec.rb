require 'spec_helper'
require 'ostruct'

module FavLanguage
  describe Detector do
    class TestStat
      def initialize(*args)
      end

      def fetch
        [
          OpenStruct.new(language: "JavaScript", weight: 3),
          OpenStruct.new(language: "Ruby", weight: 4),
          OpenStruct.new(language: "CoffeeScript", weight: 4)
        ]
      end
    end

    describe "#favourite_languages" do
      it "selects all languages with the top weight" do
        langs = described_class.new(username: 'test', stats_class: TestStat).favourite_languages
        expect(langs.map(&:language)).to match_array ["CoffeeScript", "Ruby"]
      end

      it "raises an error if the username is missing" do
        subject = described_class.new(username: '', stats_class: TestStat)
        expect {
          subject.favourite_languages
        }.to raise_error("Please provide GitHub username")
      end
    end
  end
end
