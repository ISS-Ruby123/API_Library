# frozen_string_literal: true

folders = %w[site comment views]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end