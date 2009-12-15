module ElanDesign
  module Formtastic
    module Autocomplete
      
      protected

      def autocomplete_input(method, options)
        html_options = options.delete(:input_html) || {}
        association = @object.class.reflect_on_association(method)
        if [:has_many, :has_and_belongs_to_many].include?(association.macro)
          self.label(method, options_for_label(options).merge(:for => "#{@object_name}_#{method}_autocomplete")) +
          autocomplete_existing_entries(method, options) + 
          autocomplete_multi_field(association, options)
        else
          self.label(method, options_for_label(options).merge(:for => "#{@object_name}_#{method}_autocomplete")) +
          autocomplete_single_field(association, options)
        end
      end

      def autocomplete_existing_entries(method, options)
        label = options[:label_method] || detect_label_method(object.send(method))
        value = options[:value_method] || :id
        remove_link = options[:remove_link] || 'Remove'
        id_stub = "selected_#{@object_name}_#{method}"
        template.content_tag(:ul, :id => id_stub, :class => 'auto_complete_selections') do
          object.send(method).map { |selection|
            template.content_tag(:li, 
              template.hidden_field_tag("#{@object_name}[#{method.to_s.singularize}_ids][]", selection.send(value), :id => nil) + 
              selection.send(label) + 
              template.link_to_function(remove_link, "$('#{id_stub}_#{selection.send(value)}').remove()"), 
              :id => "#{id_stub}_#{selection.send(value)}"
            )
          }.join()
        end
      end

      def autocomplete_indicator(method, options)
        return '' unless options[:indicator]
        template.image_tag(options[:indicator], :alt => 'Working', :id => "#{@object_name}_#{method}_indicator", :class => 'indicator', :style => 'display: none')
      end

      def autocomplete_single_field(association, options)
        method = association.name
        label = options[:label_method] || detect_label_method(object.send(method).to_a)
        value = options[:value_method] || :id
        current_value = object.send(method).nil? ? '' : object.send(method).send(label)
        input_name = "#{@object_name}_#{generate_association_input_name(method)}"
        template.text_field_tag("#{@object_name}_#{method}_autocomplete", current_value, :id => "#{@object_name}_#{method}_autocomplete", :autocomplete => :off, :class => 'autocomplete') +
        hidden_field(association.association_foreign_key()) +
        #autocomplete_indicator(method, options) +
        #template.content_tag(:div, "", :id => "#{@object_name}_#{method}_results", :class => 'auto_complete') +
        template.javascript_tag(<<-EOT
$("input##{@object_name}_#{method}_autocomplete").autocomplete({
  ajax: "/#{method.to_s.pluralize}/autocomplete",
  timeout: 500,
  threshold: 2,
  match: function(typed) {
    this.typed = typed;
    this.pre_match = this.text;
    this.match = this.post_match = '';
    var match_at = this.text.search(new RegExp(typed, "i"));
    if (match_at != -1) {
      this.pre_match = this.text.slice(0,match_at);
      this.match = this.text.slice(match_at,match_at + typed.length);
      this.post_match = this.text.slice(match_at + typed.length);
      return true;
    }
    return false;
  },
  insertText: function(obj) { $('##{@object_name}_#{method}_id').val(obj.id); return obj.text; },
  templateText: "<li><%= pre_match %><span class='matching' ><%= match %></span><%= post_match %></li>"
})
EOT
  )

      end

      def autocomplete_multi_field(association, options)
        method = association.name
        label = options[:label_method] || detect_label_method(object.send(method))
        value = options[:value_method] || :id
        remove_link = options[:remove_link] || 'Remove'

        template.text_field_tag("q", '', :id => "#{@object_name}_#{method}_autocomplete") +
        autocomplete_indicator(method, options) +
        template.content_tag(:div, "", :id => "#{@object_name}_#{method}_results", :class => 'auto_complete') +
        template.javascript_tag(<<-EOT
  new Ajax.Autocompleter('#{@object_name}_#{method}_autocomplete', '#{@object_name}_#{method}_results', '#{options[:url]}', {
    updateElement: function(li) {
      item_id = li.id.replace('result_', '');
      li_id = 'selected_#{@object_name}_#{method}_' + item_id;
      if($(li_id) == null) 
      {
        list_id = 'selected_#{@object_name}_#{method}';
        input = new Element('input', {type: 'hidden', name: '#{@object_name}[#{method.to_s.singularize}_ids][]', value: item_id});
        rem = '$(\\\'' + li_id + '\\\').remove(); return false;'
        remove_link = new Element('a', {href: '#', onclick: rem}).update('#{remove_link}');
        item = new Element('li', {id: li_id}).update(input).insert(li.innerHTML).insert(remove_link);
        $(list_id).insert(item);
      }
      else 
      {
        new Effect.Highlight(li_id)
      }
      $('#{@object_name}_#{method}_autocomplete').value = '';
    }#{", 
    indicator: '#{@object_name}_#{method}_indicator'" if options[:indicator]}
  })
  EOT
  ) 
      end
   
      
    end
  end
end