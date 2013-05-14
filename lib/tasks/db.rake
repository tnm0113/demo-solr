namespace :db do

  task remake: :environment do
    if Rails.env.development? || Rails.env.staging?
      Rake::Task['db:mongoid:drop'].invoke
      Rake::Task['db:seed'].invoke
    else
      puts 'Can rake db:remake in development & staging environments only'
    end
  end
end
