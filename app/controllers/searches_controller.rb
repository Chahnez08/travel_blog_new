class SearchesController < ApplicationController

  def index
    if params[:query].present?
      @posts = PgSearch.multisearch(params[:query])
                        .includes(:searchable)
                        .map(&:searchable)
                        .compact
    else
      @posts = Post.all
    end
  end

end
