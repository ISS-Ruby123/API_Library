# frozen_string_literal: true

folders = %w[orms migrations]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
