

class WelcomeController < ApplicationController
  def index
  	render :partial => 'queries/form'
  end
end
