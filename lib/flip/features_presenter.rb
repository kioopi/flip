module Flip
  class FeaturesPresenter
    include Flip::Engine.routes.url_helpers

    def initialize(feature_set)
      @feature_set = feature_set
    end

    def strategies
      @feature_set.strategies + [system_strategy]
    end

    def definitions
      @feature_set.definitions
    end

    def label_and_css_for(definition, strategy=@feature_set)
      label_and_css(strategy, definition)
    end

    def forms(strategy, definition)
      if strategy.switchable?
        url = feature_strategy_path(definition.key, strategy.name.underscore)

        if strategy.knows?(definition)
           [form(url, onoff(strategy, definition, invert: true)), form(url, 'delete')]
        else
           [form(url, 'on'), form(url, 'off')]
        end
      else
        []
      end
    end

    private

    def system_strategy
      SystemStrategy.new(@feature_set)
    end

    class SystemStrategy
      def initialize(feature_set); @feature_set=feature_set; end;
      def display_name; I18n.t('flip.strategy.system.name'); end
      def description; I18n.t('flip.strategy.system.description'); end
      def knows?(definition) true; end;
      def on?(definition); @feature_set.default_for(definition); end;
      def switchable?; false; end;
    end

    def label_and_css(strategy, definition)
      state = strategy.knows?(definition) ? onoff(strategy, definition) : 'pass'

      [I18n.t("flip.state.#{state}"), state]
    end

    def onoff(onable, definition, options={})
      if options[:invert]
        onable.on?(definition) ? 'off' : 'on'
      else
        onable.on?(definition) ? 'on' : 'off'
      end
    end

    def form(url, type)
      {
        url: url,
        button: button_hash(type),
        method: type == 'delete' ? :delete : :put
      }
    end

    def button_hash(key)
      val = key
      val = (val == 'off' ? 'deactivate' : 'activate') if ['on', 'off'].include?(val)
      {
        label: I18n.t("flip.state.button.#{key}"),
        value: val
      }
    end
  end
end
