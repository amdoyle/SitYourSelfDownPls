# This is a standalone migration for Reservations/comment
class AddCommentToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :comment, :string
  end
end
