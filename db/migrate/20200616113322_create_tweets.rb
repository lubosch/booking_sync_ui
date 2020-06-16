class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.jsonb :details
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
