class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  if Rails.env.test?
    def cache_dir
      Rails.root.join('tmp/uploads/cache')
    end

    def store_dir
      Rails.root.join(
        'tmp/uploads',
        model.class.to_s.underscore,
        mounted_as.to_s,
        model.id.to_s
      )
    end
  else
    def store_dir
      File.join(
        'system',
        model.model_name.singular,
        mounted_as.to_s,
        model.id.to_s
      )
    end
  end

  version :rect do
    process resize_to_fill: Settings.pictures.image.rect.size.values
  end

  version :thumb do
    process resize_to_fill: Settings.pictures.image.thumb.size.values
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
