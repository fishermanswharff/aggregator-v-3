require 'o_auth'

class Users::OmniauthCallbacksController < ApplicationController
  def passthru
    self.send(params[:provider])
  end

  def twitter
    token = TwitterOauthStrategy.new.request_token(ENV['TWITTER_ACCESS_TOKEN'], root_url)
    response = token.request_data(OAuth.get_header_string('request_token', token.params), OAuth.get_base_url('request_token'), OAuth.get_method)
    render json: { url: "https://api.twitter.com/oauth/authenticate?#{response.body}" }
  end

  def twitter_callback
    fullpath = request.fullpath
    access_token = TwitterOauthStrategy.new.access_token({ oauth_token: strip_token(fullpath), oauth_verifier: strip_verifier(fullpath) })
    response = access_token.request_data(OAuth.get_header_string('access_token', access_token.params),OAuth.get_base_url('access_token'), OAuth.get_method, access_token.data)
    obj = convertToHash(response.body)
    if response.code.to_i >= 200 && response.code.to_i < 300
      UserAuthentication.create_from_omniauth(obj, current_user, params['provider'])
      redirect_to root_url, flash: {
        notice: "You have successfully logged in with #{params['provider']}"
      }
    else
      redirect_to root_url, flash: {
        alert: 'Something went wrong :('
      }
    end
  end

  private

  def strip_token(string)
    string.split('&').detect { |param| param.include? 'oauth_token' }.split('=').second
  end

  def strip_token_secret(string)
    string.split('&').detect { |param| param.include? 'oauth_token_secret' }.split('=').second
  end

  def strip_verifier(string)
    string.split('&').detect { |param| param.include? 'oauth_verifier' }.split('=').second
  end

  def strip_user_token(string)
    string.scan(/(?:user-token=)(\w+)/)[0][0]
  end

  def strip_authorized_token(string)
    string.scan(/(?:oauth_token=)([\w\-]+)/)[0][0]
  end

  def strip_token_secret(string)
    string.scan(/(?:oauth_token_secret=)(\w+)/)[0][0]
  end

  def strip_user_id(string)
    string.scan(/(?:user_id=)(\d+)/)[0][0]
  end

  def strip_screen_name(string)
    string.scan(/(?:screen_name=)(.+)/)[0][0]
  end

  def convertToHash(string)
    string.split('&').each_with_object({}) { |i,o|
      array = i.split('=')
      o[array[0]] = array[1]
    }
  end
end
