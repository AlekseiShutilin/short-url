require 'open-uri'
class Entity < ApplicationRecord
	include HTTParty

	validates :url, presence: true
	validates :short_url,
			  length: {in:(4..8)},
			  uniqueness: true,
			  format: {with: /\A\p{Alpha}\p{Alpha}*\p{Alpha}\Z/, message: 'Incorret format, use only alphabetical characters'}

	def check_fields
		begin
			response = HTTParty.get(URI.parse self.url)
		rescue
			return false
		end

		if response.code == 200
			if self.short_url.blank?
				self.generate_short_url
			end

			true
		end
		false
	end

	def generate_short_url
		self.short_url = (4 + rand(4)).times.map {[*('A'..'Z'), *('a'..'z')].sample}.join
	end
end
