# encoding: utf-8

module Promoter
  module Errors
    class BaseError < StandardError
      attr_accessor :response

      def initialize(message, response)
        super(message)
        @response = response
      end
    end

    class BadRequest < BaseError; end
    class Unauthorized < BaseError; end
    class Forbidden < BaseError; end
    class NotFound < BaseError; end
    class MethodNotAllowed < BaseError; end
    class NotAcceptable < BaseError; end
    class Gone < BaseError; end
    class TooManyRequests < BaseError; end
    class InternalServerError < BaseError; end
    class ServiceUnavailable < BaseError; end

    # Error Code	Meaning
    # 400	Bad Request – Something is wrong with your request
    # 401	Unauthorized – Your API key is incorrect or invalid
    # 403	Forbidden – The resource requested is hidden for administrators only
    # 404	Not Found – The specified resource could not be found
    # 405	Method Not Allowed – You tried to access a resource with an invalid method
    # 406	Not Acceptable – You requested a format that isn’t json
    # 410	Gone – The resource requested has been removed from our servers
    # 429	Too Many Requests – You’re requesting too much! Slown down!
    # 500	Internal Server Error – We had a problem with our server. Try again later.
    # 503	Service Unavailable – We’re temporarially offline for maintanance. Please try again later.
    def check_for_error(response)
      response_code = response.response.code.to_i
      case response_code
      when 400
        raise BadRequest.new("Something is wrong with your request", response)
      when 401
        raise Unauthorized.new("Your API key is incorrect or invalid", response)
      when 403
        raise Forbidden.new("The resource requested is hidden for administrators only", response)
      when 404
        raise NotFound.new("The specified resource could not be found", response)
      when 405
        raise MethodNotAllowed.new("You tried to access a resource with an invalid method", response)
      when 406
        raise NotAcceptable.new("You requested a format that isn’t json", response)
      when 410
        raise Gone.new("The resource requested has been removed from our servers", response)
      when 429
        raise TooManyRequests.new("You’re requesting too much! Slown down!", response)
      when 500
        raise InternalServerError.new("We had a problem with our server. Try again later.", response)
      when 503
        raise ServiceUnavailable.new("We’re temporarially offline for maintanance. Please try again later.", response)
      end
    end
  end
end
