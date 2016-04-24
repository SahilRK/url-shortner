class ShortVisitsController < ApplicationController
  require 'open-uri'
  before_filter :authenticate_user

  def show
    @short_visit = ShortVisit.where(short_url_id: params[:id])
  end

  def short_original_url
    orig_url = ShortUrl.search_shorty(params[:short_url_id])
    if orig_url.exists?
      visitor_ip = find_remote_ip
      visitor_details = short_visit_location(visitor_ip)
      short_visit = ShortVisit.create(visitor_ip: visitor_details["ip"], visitor_city: visitor_details["city"], visitor_country_iso2: visitor_details["country"]["code"], short_url_id: orig_url.first.id)
      ShortUrl.update_short_visit_counts(orig_url, orig_url.first.visit_counts+=1)
      redirect_to orig_url.first.original_url
    end
  end

  private

  def find_remote_ip
    if request.remote_ip == "::1"
      '216.58.196.100'
    else
      request.remote_ip
    end
  end

  def short_visit_location(visitor_ip)
    response = open("http://geoip.nekudo.com/api/#{visitor_ip}").read
    JSON.parse(response)
  end



end
