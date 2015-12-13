class Incollage::Repository::ClippingInMemoryRepository < Incollage::Repository::InMemoryBase

  def find_for_collage(opts, colors, count)
    find_all(opts).sort_by{|cl|
      -Incollage::Service.for_color_matcher.score(cl.picture.histogram.scores, colors)
    }[0...count]
  end

  def most_recent(opts)
    recent_query(opts).first
  end

  def most_preceding(opts)
    preceding_query(opts).first
  end

  protected

  def preceding_query(opts)
    query(opts).sort_by(&:external_id)
  end

  def recent_query(opts)
    preceding_query(opts).reverse
  end

end
