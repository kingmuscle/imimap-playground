class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :semeseter_id
      t.date :start_date
      t.date :end_date
      t.integer :company_id
      t.string :title
      t.string :internship_report

      t.timestamps null: false
    end
  end
end
