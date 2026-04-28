class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show ]

  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
