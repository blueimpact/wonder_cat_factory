module FormHelper
  attr_accessor :form_total_cols, :form_label_cols

  def initialize *args
    super
    @form_total_cols = 12
    @form_label_cols = 2
  end

  def form_content_cols
    form_total_cols - form_label_cols
  end

  def centered margin = 1, &proc
    content_tag(:div, class: 'row') do
      content_tag(:div,
                  class: "col-md-offset-#{margin} col-md-#{12 - margin * 2}") do
        capture(&proc)
      end
    end
  end

  def with_label form, name, options = {}, &proc
    tag_name = options.delete(:tag_name) || :div
    options[:class] = Array.wrap(options[:class])
    options[:class] << content_cols_class
    content_tag(:div, class: 'form-group') do
      concat label_tag_of(form, name)
      concat content_tag(tag_name, capture(&proc), options)
    end
  end

  def without_label options = {}, &proc
    tag_name = options.delete(:tag_name) || :div
    options[:class] = Array.wrap(options[:class])
    options[:class] << content_cols_class(with_offset: true)
    content_tag(:div, class: 'form-group') do
      content_tag(tag_name, capture(&proc), options)
    end
  end

  def input form, name
    with_label form, name do
      form.text_field(name, class: 'form-control')
    end
  end

  def input_number form, name
    with_label form, name do
      form.number_field(name, class: 'form-control')
    end
  end

  def input_password form, name
    with_label form, name do
      form.password_field(name, class: 'form-control')
    end
  end

  def input_text form, name
    with_label form, name do
      form.text_area(name, class: 'form-control', rows: 2)
    end
  end

  def input_select form, name, choices
    with_label form, name do
      form.select(name, choices, {}, class: 'form-control')
    end
  end

  def static object, name, &proc
    with_label(object, name,
               tag_name: :p,
               class: 'form-control-static') do
      proc ? capture(&proc) : object[name]
    end
  end

  private

  def label_tag_of form_or_object, name
    if form_or_object.respond_to?(:label)
      form_or_object.label(name, class: ['control-label', label_cols_class])
    else
      label_tag(:name, class: ['control-label', label_cols_class]) do
        form_or_object.class.human_attribute_name name
      end
    end
  end

  def label_cols_class
    "col-md-#{form_label_cols}"
  end

  def content_cols_class options = {}
    if options[:with_offset]
      "col-md-offset-#{form_label_cols} #{content_cols_class}"
    else
      "col-md-#{form_content_cols}"
    end
  end
end
