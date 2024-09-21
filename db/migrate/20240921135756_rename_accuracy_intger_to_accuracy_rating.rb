class RenameAccuracyIntgerToAccuracyRating < ActiveRecord::Migration[7.2]
  def change
    rename_column :reviews, :accuracy_integer, :accuracy_rating
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
