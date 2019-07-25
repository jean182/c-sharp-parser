# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

group :development, :test do
  gem "pry-byebug"
  gem "rspec", "~> 3.8"
  gem "simplecov", require: false
  gem "simplecov-rcov", require: false
end

group :development do
  gem "rubocop", "~> 0.73.0", require: false
end
