var Tables = {
  viewAsList: function() {
    $('#table_list_link').hide();
    $('#table_diagram_link').show();
    $('#table_list').show();
    $('#table_diagram').hide();
  },

  viewAsDiagram: function() {
    $('#table_list_link').show();
    $('#table_diagram_link').hide();
    $('#table_list').hide();
    $('#table_diagram').show();
  },

  getCurrentPositions: function() {
    current_positions = "";
    $('.draggable-table').each(
      function(index, element) {
        current_positions += "&tables_attributes[" + $(element).attr('id') + "][top]=" + $(element).position().top;
        current_positions += "&tables_attributes[" + $(element).attr('id') + "][left]=" + $(element).position().left;
      }
    );
    return current_positions;
  },

  updatePositions: function() {
    $.ajax({
          type: "POST",
          url: '/tables/update',
          data: "_method='PUT'" + Tables.getCurrentPositions(),
          dataType: "script"
    });
  },

  openEditor: function() {
    $('.draggable-table .handle').show();
    $('.draggable-table').draggable({containment: '#table_diagram'});
    $('#edit_diagram_link').hide();
    $('#save_diagram_button').show();
  },

  closeEditor: function() {
    $('.draggable-table .handle').hide();
    $('#edit_diagram_link').show();
    $('#save_diagram_button').hide();
    $('.draggable-table').draggable('destroy');
  }
}