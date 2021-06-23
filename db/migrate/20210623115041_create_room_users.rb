class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      # referencesは外部のテーブルを参照する型。foreign_key: trueで外部キー参照ができる制約を設けている
      t.timestamps
    end
  end
end
