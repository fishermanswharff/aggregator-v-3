class FeedCrawler
  include Sidekiq::Worker

  def perform(url)
    Crawler.new.crawl(url)
  end

  # perform async:
  # HardWorker.perform_async('bob', 5)
  #
  # process in the future:
  # HardWorker.perform_in(5.minutes, 'bob', 5)
  #
  # You can also create jobs by calling the delay method on a class method:
  # User.delay.do_some_stuff(current_user.id, 20)
end
