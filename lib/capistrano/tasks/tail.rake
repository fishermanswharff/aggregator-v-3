desc "Upload database.yml file."
task :tail do
  on roles(:app) do
    # execute "tail -f /var/log/nginx/error.log"
    # execute "tail -f /home/ubuntu/www/aggregator/current/log/production.log"
    execute :tail, "-f #{shared_path}/log/#{fetch(:rails_env)}.log" do |channel, stream, data|
      puts channel
      puts stream
      puts data
    end
  end
end
