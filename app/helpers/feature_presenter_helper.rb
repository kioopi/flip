# Access to feature-flipping configuration.
module FeaturePresenterHelper
  def button_form(form)
    form_tag(form[:url], method: form[:method]) do
      btn = form[:button]
      button_tag(btn[:label], type: 'submit', name: 'commit', value: btn[:value])
    end
  end
end
