# frozen_string_literal: true

folders = %w[site rate views]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
