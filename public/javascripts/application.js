// This sets up the proper header for rails to understand the request type,
// and therefore properly respond to js requests (via respond_to block, for example)

function open_modal(element) {
  //Get the window height and width
  var winH = $(window).height();
  var winW = $(window).width();

  //Set the popup window to center
  $('#' + element + '.modal').css('top', winH/2-$('#' + element + '.modal').height()/2);
  $('#' + element + '.modal').css('left', winW/2-$('#' + element + '.modal').width()/2);

  //Show the popup window
  $('#' + element + '.modal').show();
}