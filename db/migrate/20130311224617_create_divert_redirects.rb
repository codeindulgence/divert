class CreateDivertRedirects < ActiveRecord::Migration
  def change
    create_table :divert_redirects do |t|
      t.string :hither
      t.string :thither
      t.integer :hits
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
