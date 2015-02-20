require 'spec_helper'

module Helpers

  def request_headers
    return {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
    }
  end

  def patch_header
    return {
        'Accpet' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s
    }
  end

  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end