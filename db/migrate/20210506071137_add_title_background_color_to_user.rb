class AddTitleBackgroundColorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :title_background_color, :string, default: '#005a55'
  end
end
