namespace :db do
  desc 'Creates postgres user for all environments.'
  task create_user: :environment do
    Rails.configuration.database_configuration
         .map { |_, conf| conf['username'] }
         .uniq.compact.each do |username|
      `createuser -e -s -d #{username}`
    end
  end
end
