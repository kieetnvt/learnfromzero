class Api::V1::Mobile::CompaniesController < ApplicationController
  def show
    @company = Company.find_by(params[:id])
    render json: @company
  end
end