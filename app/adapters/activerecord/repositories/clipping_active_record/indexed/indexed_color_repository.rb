class ClippingActiveRecord
  class IndexedColorRepository < Repository

    def save(entity)
      entity.validate!
      record = from_entity(entity)
      populate_color_index(entity, record)
      record.save!
      entity.id = record.id
      entity
    rescue ActiveRecord::RecordInvalid => ex
      raise Incollage::Validateable::BusinessObjectIsInvalidError.new(ex.message)
    end

    def find_for_collage(opts, colors, count)
      order = colors.map{|c| color_index_attribute(c).to_s + ' desc' } * ?,
      to_entities query(opts).order(order).limit(count)
    end

    protected

    def populate_color_index(entity, record)
      Incollage::Holder.for_standard_colors.added_colors.each do |color|
        record.public_send "color_#{color.id}=", calculate_score(color.hex_value, entity.picture.histogram)
      end
    end

    def calculate_score(color, histogram)
      Incollage::Service.for_color_matcher.score(histogram.scores, [color]) * 10_000
    end

    def color_index_attribute(hex_value)
      id = Incollage::Holder.for_standard_colors.added_colors.find do |x|
        x.hex_value.upcase == hex_value.upcase
      end.id
      "color_#{id}"
    end
  end
end
