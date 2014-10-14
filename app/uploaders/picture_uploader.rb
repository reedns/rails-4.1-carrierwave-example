class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  process scale: [300, 300]

  def scale(_width, _height)
    resize_to_fit(300, 300)
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
