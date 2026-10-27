class PaginasController < ApplicationController
  skip_before_filter :exigir_login
  
  def index
  end
end
