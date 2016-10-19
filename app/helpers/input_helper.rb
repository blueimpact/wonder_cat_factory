module InputHelper
  include FormHelper

  def input form, name
    form_group(form, name) do
      form.text_field(name, class: 'form-control')
    end
  end

  def input_number form, name
    form_group(form, name) do
      form.number_field(name, class: 'form-control')
    end
  end

  def input_password form, name
    form_group(form, name) do
      form.password_field(name, class: 'form-control')
    end
  end

  def input_hidden form, name
    form_group(form, name) do
      form.hidden_field(name, class: 'form-control')
    end
  end

  def input_text form, name, options = { rows: 2 }
    form_group(form, name) do
      form.text_area(name, { class: 'form-control' }.merge(options))
    end
  end

  def input_select form, name, choices
    form_group(form, name) do
      form.select(name, choices, {}, class: 'form-control')
    end
  end

  def static object, name, &proc
    without_feedback do
      with_label object, name, tag_name: :p, class: 'form-control-static' do
        proc ? capture(&proc) : object[name]
      end
    end
  end

  def labelless &proc
    without_feedback do
      without_label do
        capture(&proc)
      end
    end
  end
end
