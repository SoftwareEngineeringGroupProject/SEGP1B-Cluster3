class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.string :spec_name
      t.text :spec_content

      t.timestamps
    end
  end
end
