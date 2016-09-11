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
  #
  #
  #
  # should be able to crawl the web
  # must be able to limit the depth of the crawl (otherwise will potentially keep going forever
  #   and will also run out of memory eventually because of the way it's written)
  # must be able to limit number of pages to crawl (even with a depth limited crawl, might
  #   still have too many pages to get through depending on the starting set of domains)
  # must be able to crawl just a single domain (you would also be able to limit this by number of pages)
  # the only output it will produce is the print out the fact that it is crawling a url
  #
end
