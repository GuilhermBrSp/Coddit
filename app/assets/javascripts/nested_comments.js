$(document).on('turbolinks:load', function() {

  // Comments comment reply form toggle //
  $(".reply-button").click(function() {
    $(this).parent('span').siblings('.reply-collapse').toggle('collapse');
  });



  // Comments comment show comments toggle //
  $(".comments-button").click(function() {
    $(this).first().parent('span').parent('div').siblings('.panel-collapse').toggle('collapse');
  });



  $('.expand-button').on('click', function() {
    var $this = $(this),
      $parent = typeof $this.data('parent') !== 'undefined' ? $($this.data('parent')) : undefined;
    if ($parent === undefined) {
      /* Just toggle my  */
      $this.find('.glyphicon').toggleClass('glyphicon-plus glyphicon-minus');
      return true;
    }

    /* Open element will be close if parent !== undefined */
    var currentIcon = $this.find('.glyphicon');
    currentIcon.toggleClass('glyphicon-plus glyphicon-minus');
    $parent.find('.glyphicon').not(currentIcon).removeClass('glyphicon-minus').addClass('glyphicon-plus');

  });


  // ...
});
