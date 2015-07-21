require 'logobox/version'

module Logobox
  class LogoNotFound < StandardError; end

  LOGO_SIZES = [:small, :medium, :big]

  def self.generate_logo_url(ico, size = nil)
    if size
      fail ArgumentError, 'size must be one of :' + LOGO_SIZES.join(', :') unless LOGO_SIZES.include?(size)
      "http://www.logobox.cz/getimage.ashx?id=CZ#{ico}?size=#{size}"
    else
      "http://www.logobox.cz/getimage.ashx?id=CZ#{ico}"
    end
  end

  def self.generate_logo_url!(ico, size = nil)
    fail ArgumentError, 'ico is invalid' unless valid_ico?(ico.to_s)
    fail LogoNotFound, 'logo does not exists' unless logo_exists?(ico.to_s)

    result = generate_logo_url(ico, size)
    fail ArgumentError unless result
    result
  end

  def self.logo_exists?(ico)
    uri = URI("http://www.logobox.cz/getimage.ashx?id=CZ#{ico}&error404=true")
    result = Net::HTTP.get_response uri
    result.code == '200'
  end

  private



  # TODO: Remove when migrated to ico-validator gem
  def self.valid_ico?(value)
    value.length == 8 && value.match(/^\d+$/) && last_number_valid?(value)
  end

  def self.last_number_valid?(value)
    value[7].to_i == calculate_valid_last_number(value)
  end

  def self.calculate_valid_last_number(value)
    sum = (0..6).inject(0) { |sum, i| sum += value[i].to_i * (8 - i) }
    mod = sum % 11

    case mod
    when 0, 10 then 1
    when 1     then 0
    else 11 - mod
    end
  end
end
