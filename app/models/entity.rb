require 'rest-client'
class Entity < ApplicationRecord
  RESERVED_URLS = %w(api entities)
  ENTITY_TTL = (ENV['ENTITY_TTL'].present? &&
      ENV['ENTITY_TTL'].to_i.is_a?(Numeric) &&
      ENV['ENTITY_TTL'].to_i >= 1) ? ENV['ENTITY_TTL'].to_i : 21600
  validate :check_url
  validate :check_short_url
  validates :url, presence: true
  validates :short_url,
            length: {in:(4..8)},
            uniqueness: true,
            format: {with: /\A\p{Alpha}\p{Alpha}*\p{Alpha}\Z/, message: 'Incorret format, use only alphabetical characters at least 4 symbols'}

  before_save :add_protocol

  def check_url
    begin
      response = RestClient.get self.url
    rescue
      errors.add(:url, 'Invalid URL')
      return
    end

    if response.present? && response.code != 200
      errors.add(:url, 'Incorrect URL, response code should be 200')
    end
  end

  def check_short_url
    if self.short_url.present?
      if RESERVED_URLS.include? self.short_url
        errors.add(:short_url, 'Ouch... No. You cannot use this URL, I\'m so, so sorry about it')
      end
    else
      self.generate_short_url
    end
  end


  def generate_short_url
    self.short_url = (4 + rand(4)).times.map {[*('A'..'Z'), *('a'..'z')].sample}.join if short_url.blank?
  end

  def self.clean_expired_entities
    @entities = Entity.where('created_at < ?', ENTITY_TTL.minutes.ago)
    @entities.destroy_all if @entities.present?
  end

  private
  def add_protocol
    unless url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end
end
