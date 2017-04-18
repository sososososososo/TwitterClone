class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, foreign_key: true
      #実際のデータベース上では、 
      #user_id カラムとして存在し、
      #そこに User の id が保存されます。
      #これで Micropost を発言したユーザを特定することができます。
      #また、foreign_key は外部キー制約というものです。

      t.timestamps
    end
  end
end
