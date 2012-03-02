class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :thumbnail
      t.string :embed_src
	  t.text :description
	  
      t.timestamps
    end
  end
end
