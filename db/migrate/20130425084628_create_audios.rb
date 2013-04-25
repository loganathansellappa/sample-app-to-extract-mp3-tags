class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :artist
      t.string :title
      t.string :track
      t.string :album
      t.string :tracknum
      t.string :audio_file_size
      t.string :audio_file_name
      t.string :audio_content_type
      t.string :audio_updated_at

      t.timestamps
    end
  end
end
