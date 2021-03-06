require 'pry'
namespace :setup do
  desc "Upload all the secrets."
  task :upload_yml do
    on roles(:app) do
      upload! StringIO.new(File.read("config/database.yml")), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read("config/env.yml")), "#{shared_path}/config/env.yml"
      upload! StringIO.new(File.read("config/secrets.yml")), "#{shared_path}/config/secrets.yml"
      execute "touch www/aggregator/current/tmp/restart.txt"
    end
  end

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Symlinks config files for Nginx and Passenger"
  task :symlink_config do
    on roles(:app) do
      # execute "rm -f /etc/nginx/sites-enabled/default"
      # execute "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      # execute "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
   end
  end
end
