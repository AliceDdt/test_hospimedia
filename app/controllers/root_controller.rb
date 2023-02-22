# frozen_string_literal: true
require 'rest-client'

class RootController < ApplicationController
    def index
			
      get_people

			results = get_people['results']
	
			people = results.select { |person| person['mass'].to_i > 75 }
			
			@people = people.map do |person|
				{
          name: person['name'],
					mass: person['mass'].to_i,
					homeworld: get_homeworld_name(person['homeworld']),
					films: person['films'].map {|film| get_film_name(film) }
				}
			end
		end

		private

		def base_url
			'https://swapi.dev/api/'
		end

		def get_api(url)
			response =  RestClient.get(url)
      JSON.parse(response.body)
		end

  	def get_people
			get_api(base_url + 'people')
		end

		def get_homeworld_name(url)
			json = get_api(url)
			json['name']
		end

		def get_film_name(url)
			json = get_api(url)
			json['title']
		end
  end
  