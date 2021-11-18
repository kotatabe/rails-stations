class RemoveMovieIdFromScreen < ActiveRecord::Migration[6.1]
  def change
    remove_reference :screens, :movie
  end
end
