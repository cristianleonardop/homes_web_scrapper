class CreateHomes < ActiveRecord::Migration[6.0]
  def change
    create_table :homes do |t|
      t.string :title
      t.string :address
      t.string :monthly_rent
      t.string :url

      t.timestamps
    end
  end
end
