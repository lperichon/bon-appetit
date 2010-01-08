# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Given a number returns :odd or :even
  def odd_or_even(number)
    (number % 2)==1 ? :odd : :even
  end

  DISCOUNTS = {0.0 => 'No Discount', 0.5 => '50%', 1.0 => 'Free'}

  def discount_label(discount)
    DISCOUNTS[discount.to_f]
  end

  # Array of discount options for selects
  def discounts()
    DISCOUNTS.collect {|key, value| [value, key]}
  end

  # Helpers for contact nested forms
  def add_new_record_link(record, name, form_builder)
    name = name.to_s
    plural_name = name.pluralize
    link_to_function "add a new #{name}", :class => 'add' do |page|
      form_builder.semantic_fields_for plural_name, record.send(plural_name).build, :child_index => 'NEW_RECORD' do |p|
        html = "<fieldset class='inputs'><ol>#{render(:partial => plural_name + '/' + name, :locals => { :f => p })}</ol></fieldset>"
        page << "$('##{plural_name}').append('#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()));"
      end
    end
  end

  # remove link
  def remove_link_unless_new_record(fields)
    out = ''
    out << fields.hidden_field(:_delete) unless fields.object.new_record?
    out << link_to_function("remove", "$(this).parent().parent().hide(); $(this).siblings('input[type=hidden]')[0].value = 1;", :class => 'remove')
    out
  end

  # RJS conditional helpers
  def rjs_if_element_exists(e)
    page << "if($('##{e}').length){"
  end

  def rjs_unless_element_exists(e)
    page << "if(!$('##{e}').length){"
  end

  def rjs_elsif(e)
    page << "}else if($('#{e}').length){"
  end

  def rjs_else
    page << "}else{"
  end

  def rjs_end
    page << "}"
  end
end
