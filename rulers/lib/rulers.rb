require "rulers/version"
require "rulers/routing"
require "rulers/array"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end
      if env['PATH_INFO'] == '/'
        return [302, {"Location" => '/home/index'}, []]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        # rescue NoMethodError  => e
        #   text = "missing method!"
      rescue Exception => e
        #text = e
        text = "<!doctype html><html><head></head><body>"
        text = "Oops! A #{e.class}:#{e.message} exception happened! <br>\n"
        text += "<ul>"
        e.backrace.each do |line|
          text += "<li>#{line}</li>"
        end
        text = "</ul></body></html>"
      end
      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end
end
