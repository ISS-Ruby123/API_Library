# frozen_string_literal:false

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require 'vcr'
require 'webmock'

require_relative '../lib/lbs_api.rb'

Test = File.read('spec/fixtures/test.yml')

CASSETTES_FOLDER = 'fixtures/cassettes'.freeze
CASSETTE_FILE = 'lbs_api'.freeze
