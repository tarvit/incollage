require 'spec_helper'

describe ClippingActiveRecord::Repository do


  require app_root.join 'spec/core/support/base_repository_test'
  include BaseRepositoryTest

  before :each do
    @repo = ClippingActiveRecord::Repository.new
  end

  def new_entity(opts={})
    attrs = { user_id: 0, file_path: 'some_path', histogram: Incollage::Histogram.new(1 => '00ff00') }
    Incollage::Clipping.new(attrs.merge opts)
  end

  test_in_memory_base_repository


end
