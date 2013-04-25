require "mp3info"
class Audio < ActiveRecord::Base
  attr_accessible :album, :artist, :audio_content_type, :audio_name, :audio_size, :audio_updated_at, :title, :track, :tracknum,:audio

  has_attached_file :audio,
  :url => "public/attachments/:id/:filename",
  :path => "public/attachments/:id/:filename"
  validates_attachment_content_type :audio, content_type: [ 'audio/mpeg', 'audio/x-mpeg' ], message: "has to be in MP3 format"

  before_save :extract_audio_details


# Retrieves metadata for MP3s
def extract_audio_details
   path = audio.queued_for_write[:original].path
  open_opts = { :encoding => 'utf-8' }
  Mp3Info.open(path, open_opts) do |mp3|
	  self.title = mp3.tag.title 
	  self.album = mp3.tag.album
	  self.artist = mp3.tag.artist
	  self.track = mp3.tag.tracknum
  end
end

# Search MP3s by title,album and artist
def self.search(search)
  where('title LIKE :search_key OR artist LIKE :search_key OR album like :search_key ',{search_key: "%#{search}%"})
end

end
