class CreateTableLanguagesVideos < ActiveRecord::Migration
  def change
    create_table :languages_videos, {:id => false} do |t|
      t.integer :language_id
      t.integer :video_id
    end
  end
end
