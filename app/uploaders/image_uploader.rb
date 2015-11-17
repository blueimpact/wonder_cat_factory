class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.test?
    def cache_dir
      Rails.root.join('tmp/uploads/cache')
    end 
    def store_dir
      Rails.root.join('tmp/uploads', model.class.to_s.underscore, mounted_as.to_s, model.id.to_s)
    end
  else
    def store_dir
      ['system', model.model_name.singular, mounted_as.to_s, model.id.to_s].join('/')
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  version :rect do
    process resize_to_fill: Settings.pictures.image.rect.size.values
  end

  version :thumb do
    process resize_to_fill: Settings.pictures.image.thumb.size.values
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
