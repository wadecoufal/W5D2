class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.boolean :upvote
      t.references :voteable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
