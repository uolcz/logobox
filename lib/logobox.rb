require 'ico-validator/ico_validation'
require 'logobox/version'
require 'uri'
require 'net/http'

module Logobox
  class LogoNotFound < StandardError; end

  LOGO_SIZES = [:small, :medium, :big]

  def self.generate_logo_url(ico, size = nil)
    if size
      fail ArgumentError, 'size must be one of :' + LOGO_SIZES.join(', :') unless LOGO_SIZES.include?(size)
      "http://www.logobox.cz/getimage.ashx?id=CZ#{ico}&size=#{size}"
    else
      "http://www.logobox.cz/getimage.ashx?id=CZ#{ico}"
    end
  end

  def self.generate_logo_url!(ico, size = nil)
    fail ArgumentError, 'ico is invalid' unless IcoValidation.valid_ico?(ico)
    fail LogoNotFound, 'logo does not exists' unless logo_exists?(ico)

    result = generate_logo_url(ico, size)
    fail ArgumentError unless result
    result
  end

  def self.logo_exists?(ico)
    uri = URI("http://www.logobox.cz/getimage.ashx?id=CZ#{ico}&error404=true")
    result = Net::HTTP.get_response uri
    result.code == '200'
  end
end
