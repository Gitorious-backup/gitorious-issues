this.gts.expandableTextarea = (function() {
  var initialized = false;

  if (initialized) return;

  return function(textarea) {
    $el = $(textarea);

    $el.on('focus', function(e) {
      $(this).removeClass('gts-textarea-expandable');
    });

    $el.on('blur', function(e) {
      if (this.value) return;
      $(this).addClass('gts-textarea-expandable');
    });

    initialized = true;
  };

}());
