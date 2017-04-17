ENTITY_TTL = (ENV['ENTITY_TTL'].present? &&
    ENV['ENTITY_TTL'].to_i.is_a?(Numeric) &&
    ENV['ENTITY_TTL'].to_i >= 1) ? ENV['ENTITY_TTL'].to_i : 21600

namespace :clean_expired_entities do
  desc 'This task destroys expired entities'
  task :perform => :environment do
    @entities = Entity.where('created_at < ?', ENTITY_TTL.minutes.ago)
    @entities.destroy_all if @entities.present?
  end
end
