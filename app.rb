require 'erb'
require_relative 'monoro'
require_relative 'advice'

class App
  def call(env)
    case env['REQUEST_PATH']
    when '/'
        fmk = Monoro.new
        status = '200'
        headers = {"Content-Type" => "text/html"}
        fmk.response(status, headers) do
          fmk.erb :index
        end

    when '/advice'
      fmk = Monoro.new
      piece_of_advice = Advice.new.generate
      status = '200'
      headers = {"Content-Type" => "text/html"}
      fmk.response(status, headers) do
        fmk.erb :advice, message: piece_of_advice
      end
    else
      fmk = Monoro.new
      status = '404'
      headers = {"Content-Type" => "text/html"}
      fmk.response(status, headers) do
        fmk.erb :not_found
      end
    end
  end
end
