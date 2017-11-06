class HomeController < ApplicationController
  def index
  end
  layout "details", only: [:view,:reviews]
  def view
  end
  def reviews
  end
end
