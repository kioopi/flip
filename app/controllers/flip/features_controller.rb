module Flip
  class FeaturesController < ApplicationController

    def index
      @p = FeaturesPresenter.new(FeatureSet.instance)
    end
  end
end
