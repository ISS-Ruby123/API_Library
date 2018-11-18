# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'

require 'pry' # for debugging

require_relative '../../init.rb'

NAME = 'NTHU'.freeze
ADDRESS_HAPPY = '新竹市光復路二段101號'.freeze
ADDRESS_SAD = '新竹市XXX路101號'.freeze
COMMENT = 'GOOD PLACE'.freeze
