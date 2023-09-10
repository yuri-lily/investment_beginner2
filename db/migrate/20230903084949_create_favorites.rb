class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.string :symbol,                                      null: false
      t.decimal :registered_price, precision: 10, scale: 2,  null: false
      t.decimal :price, precision: 10, scale: 2
      t.references  :user,                                   null: false, foreign_key: true
      t.timestamps
    end
  end
end
