class CreateEntrylogs < ActiveRecord::Migration[5.2]
  def change
    create_table :entrylogs do |t|
      t.text :content
      t.string :report_id

      t.timestamps
    end
  end
end
