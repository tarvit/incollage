class ClippingActiveRecord
  class IndexedColorRandomizedRepository < IndexedColorRepository
    attr_reader :randomization_level, :fault_tolerance_level

    DEFAULTS = {
        randomization_level: 5,
        fault_tolerance_level: 0.8,
    }
    def initialize(opts = {})
      options = opts.merge(DEFAULTS)
      @randomization_level, @fault_tolerance_level = options[:randomization_level], options[:fault_tolerance_level]
    end

    def find_for_collage(opts, colors, count)
      order = colors.map{|c| color_index_attribute(c).to_s + ' desc' } * ?,
      records = query(opts).order(order).limit(count*randomization_level)
      tolerant_reduce(records, colors, count)
    end

    private

    def tolerant_reduce(records, colors, count)
      rs = record_scores(records, colors)
      median_score = rs[count - 1].last
      allowed_score = median_score * fault_tolerance_level
      allowed_records = rs.select{|r| r.last >= allowed_score }.map(&:first)
      to_entities allowed_records.sort_by{rand}[0...count]
    end

    def record_scores(records, colors)
      records_with_scores = records.each_with_object([]) do |record, scores|
        score = record_score(record, colors)
        scores << [ record, score ]
      end
      records_with_scores.sort_by!{|rs| -rs.last }
    end

    def record_score(record, colors)
      colors.map do |c|
        record.send color_index_attribute(c)
      end.sum
    end
  end
end
