class CreateTravels < ActiveRecord::Migration[5.2]
  def change
    create_table :travels do |t|
      t.string :time
      t.string :distance
      t.string :value
      t.string :user_identification
      t.string :user_phone
      t.string :user_email
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
