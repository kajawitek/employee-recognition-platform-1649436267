module Admins
  class AdminsController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!
  end
end
