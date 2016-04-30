desc "Upload database.yml file."
task :log do
  on roles(:app) do
    execute "tail -f /var/log/nginx/error.log"
  end
end
