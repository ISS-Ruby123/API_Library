# frozen_string_literal: true

folders = %w[site rate]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
