module TimeScopes
  extend ActiveSupport::Concern

  included do
    scope :older_first, -> { order(created_at: :asc) }
    scope :newer_first, -> { order(created_at: :desc) }
    scope :updated_first, -> { order(update_at: :asc) }
    scope :outdated_first, -> { order(update_at: :desc) }
  end

  module ClassMethods
    def newest *args
      newer_first.first(*args)
    end

    def oldest *args
      older_first.first(*args)
    end

    def most_updated *args
      updated_first(*args)
    end

    def most_outdated *args
      outdated_first(*args)
    end
  end
end
