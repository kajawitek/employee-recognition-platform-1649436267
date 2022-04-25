module Admins
  class PagesController < ApplicationController
    before_action :authenticate_admin!
    layout 'admin'

    def dashboard; end
  end
end
