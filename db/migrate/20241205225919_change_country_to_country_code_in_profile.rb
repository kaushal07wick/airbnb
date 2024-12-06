class ChangeCountryToCountryCodeInProfile < ActiveRecord::Migration[7.2]
  def change
    rename_column :profiles, :country, :country_code
  end
end
