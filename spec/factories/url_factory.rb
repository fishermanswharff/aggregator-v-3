FactoryGirl.define do
  factory :url, class: String do
    skip_create

    ignore do
      protocol 'http://'
      subdomain Faker::Internet.domain_word
      domain_name Faker::Internet.domain_name

      host { [subdomain, domain_name].compact.join('.') }
      port 80
      path '/'
    end

    trait :secure do
      protocol 'https://'
      port nil
    end

    initialize_with { new "#{protocol}#{[host,port].compact.join(':')}#{path}" }

    factory :nytimes_homepage_feed do
      subdomain 'www'
      domain_name 'nytimes.com'
      path '/services/xml/rss/index.html'
      port nil
    end
  end
end
