class PlainpageController < ApplicationController
  before_action :validate_login, only: [:index]
  def index
    # flash[:success ] = "Success Flash Message: Welcome to GentellelaOnRails"
    #other alternatives are
    # flash[:warn ] = "Israel don't quite like warnings"
    #flash[:danger ] = "Naomi let the dog out!"
  end

end
