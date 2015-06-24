module ApplicationHelper
  def display_errors (model:, text:)
    return _render(model, text) if model.errors.any?
    ''
  end

  private

  def _render(model, text)
    "#{_message(model, text)} #{_errors(model, text)}".html_safe
  end

  def _message(model, text)
    content_tag(:h2, "#{text}")
  end

  def _errors(model, text)
    content_tag :ul do
      model.errors.full_messages.map do |m|
        concat(content_tag(:li, "#{m}"))
      end
    end
  end
end
