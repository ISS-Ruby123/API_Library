# frozen_string_literal: true

folders = %w[entities mappers repositiories]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end