require 'rails_helper'

RSpec.describe UrlUtils, type: :module do
  include UrlUtils

  describe '.to_uri' do
    it 'converts a string to a uri' do
      url = FactoryGirl.create(:url, :secure, subdomain: 'www')
      expect(to_uri(url)).to be_a URI
    end
  end
end
