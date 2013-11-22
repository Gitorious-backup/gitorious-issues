this.gts = this.gts || {};

this.gts.expandableTextarea = (function() {

  return function(textarea) {
    $el = $(textarea);

    $el.on('focus', function(e) {
      $(this).removeClass('gts-textarea-expandable');
    });

    $el.on('blur', function(e) {
      if (this.value) return;
      $(this).addClass('gts-textarea-expandable');
    });
  };

}());

gts.app.feature('expandable-textarea', gts.expandableTextarea, {
  elements: ['gts-textarea-expandable']
});
