class UpsdatePasswordResetColumnName < ActiveRecord::Migration
  def change
  	rename_column :users, :password_rest_token, :password_reset_token
  end
end
