env_file = 'config/capistrano_aws.yml'
if File.exists?(env_file)
  YAML.load_file(env_file).each do |key, value|
    ENV[key.to_s] = value
  end
end
# config valid only for current version of Capistrano
lock '3.5.0'
set :application, 'aggregator'
set :repo_url, 'git@github.com:fishermanswharff/aggregator-v-3.git'
set :deploy_to, '/home/ubuntu/www/aggregator'
set :scm, :git
set :format, :airbrussh
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto
set :linked_files, fetch(:linked_files, []).push('config/database.yml','config/secrets.yml','config/env.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
set :keep_releases, 5
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :pty, true

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "touch #{current_path}/tmp/restart.txt"
      # Here we can do anything such as:
      # within release_path do
      #  execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'reopen passenger logs'
  task :passenger_reopen_logs do
    execute "passenger-config reopen-logs"
  end

  desc 'restart-app'
  task :passenger_restart_app do
    on roles(:web) do
      execute "passenger-config restart-app #{current_path}"
    end
  end

  after :publishing, :passenger_reopen_logs, :passenger_restart_app
  after :finishing, :cleanup
end
