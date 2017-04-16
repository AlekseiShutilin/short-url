require 'rest-client'
class Entity < ApplicationRecord

	validates :url, presence: true
	validates :short_url,
			  length: {in:(4..8)},
			  uniqueness: true,
			  format: {with: /\A\p{Alpha}\p{Alpha}*\p{Alpha}\Z/, message: 'Incorret format, use only alphabetical characters'}
	before_save :add_protocol

	def check_fields
		@errors = []

		begin
			response = RestClient.get self.url
		rescue
			@errors << 'Invalid url'
		end

		if response.present? && response.code == 200
			if self.short_url.blank?
				self.generate_short_url
			end
		else
			@errors << 'Incorrect URL, status of response should be 200'
		end

		@errors
	end

	def generate_short_url
		self.short_url = (4 + rand(4)).times.map {[*('A'..'Z'), *('a'..'z')].sample}.join
	end

	private
	def add_protocol
		unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
			self.url = "http://#{self.url}"
		end
	end
end
