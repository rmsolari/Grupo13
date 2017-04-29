class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render html: "Bienvenido a TVSeries4u"
  end
end
