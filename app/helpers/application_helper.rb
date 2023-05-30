module ApplicationHelper
  include Pagy::Frontend

  def sort_direction_for(column)
    column == @sort_column && @sort_direction == 'asc' ? 'desc' : 'asc'
  end
end
