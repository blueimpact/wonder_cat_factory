module FormHelper
  attr_accessor :form_total_cols, :form_label_cols

  def initialize *args
    super
    @form_total_cols = 12
    @form_label_cols = 3
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

  def form_group form, name, options = {}, &proc
    with_feedback form, name, options do
      with_label form, name, options do
        capture(&proc)
      end
    end
  end

  def form_control options = {}, &proc
    tag_name = options.delete(:tag_name) || :div
    content_tag(tag_name, class: options[:class]) do
      concat capture(&proc)
      options[:append_proc].try :call
    end
  end

  def with_feedback form, name, options = {}, &proc
    group_class = ['form-group', 'has-feedback']
    group_class << 'has-error' if form.object.errors.key?(name)
    options[:append_proc] = proc do
      concat feedback_icon
      concat error_messages(form.object.errors.full_messages_for(name))
    end
    content_tag(:div, capture(&proc), class: group_class)
  end

  def without_feedback &proc
    content_tag(:div, capture(&proc), class: 'form-group')
  end

  def with_label form, name, options = {}, &proc
    options[:class] = [options[:class], content_cols_class].flatten
    concat label_tag_of(form, name)
    concat form_control(options, &proc)
  end

  def without_label options = {}, &proc
    options[:class] = [options[:class], content_cols_class_with_offset].flatten
    form_control options, &proc
  end

  def feedback_icon
    content_tag(:div, class: 'form-control-feedback') do
      content_tag(:i, nil, class: 'fa fa-lg')
    end
  end

  def error_messages messages
    content_tag(:div, class: 'help-block') do
      safe_join messages, tag(:br)
    end
  end

  private

  def label_tag_of form_or_object, name
    if form_or_object.respond_to?(:field_helpers?)
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

  def content_cols_class
    "col-md-#{form_content_cols}"
  end

  def content_cols_class_with_offset
    "col-md-offset-#{form_label_cols} #{content_cols_class}"
  end
end
