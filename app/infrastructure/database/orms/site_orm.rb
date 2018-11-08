# frozen_string_literal: true

require_relative '../migrations/001_site_create.rb'

# module for Database
module Database
  site = DB[:site]
  site.insert(lat: '24.171193',
              lng: '120.664384',
              name: 'home',
              address: '台中市西屯區成都路267號')

  puts site.all
end
