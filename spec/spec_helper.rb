# frozen_string_literal: false

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'

require 'pry' # for debugging

require_relative '../init.rb'

TOKEN = CodePraise::App.config.Google_TOKEN
CORRECT = YAML.safe_load(File.read('spec/fixtures/Test.yml'))
