$(document).on('turbolinks:load', function() {

  // Comments comment reply form toggle //
  $(".reply-button").click(function() {
    $(this).parent('span').siblings('.reply-collapse').toggle('collapse');
  });



  // Comments comment show comments toggle //
  $(".comments-button").click(function() {
    $(this).first().parent('span').parent('div').siblings('.panel-collapse').toggle('collapse');
    if ($(this).attr('title') == 'Show Comments')
    {
      $(this).attr('title','Hide Comments')
      console.log('hide comments')
    }
    else
    {
      $(this).attr('title','Show Comments')

    }
  });



  // Slowly removing flash messages //
  $(document).ready(function(){
  setTimeout(function(){
    $('#flash').hide('slow', function(){ $('#flash').remove(); });
  }, 5000);
 })

 $('input.tokenize').tokenfield();





  // ...
});
