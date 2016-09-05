class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_as_admin
end
