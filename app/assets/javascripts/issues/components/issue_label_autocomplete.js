this.gts.issueLabelAutocomplete = (function() {

  return function(input, labels_json) {
    var labels = $.parseJSON(labels_json);

    var $input = $(input);
    var $list  = $input.parents('.issue-label-widget').find('.issue-labels');

    function createButton(item) {
      var value, label;

      value = item.id;
      label = item.label;
      color = item.color;

      var $li = $('<li/>');

      $li.append(
        $('<button class="btn btn-mini"></button>')
          .css({ backgroundColor: color })
          .val(value).html('<i class="icon-remove icon-white"></i>'+label)
      );

      $li.append(
        $('<input type="hidden" name="label_ids[]"/>').val(value)
      );

      return $li;
    }

    function appendLabel(item) {
      $list.append(createButton(item));
    }

    function findLabel() {
      var name = $input.val();
      return cull.first(function(el) { return el.label == name }, labels);
    }

    function onConfirm() {
      var item = $input.data('item');
      if (!item) item = findLabel();
      if (item) {
        appendLabel(item);
        $input.val('');
      }
    }

    $input.next('a[data-behavior="add-label"]').click(function(e) {
      e.preventDefault();
      onConfirm();
    });

    $input.keydown(function(e) {
      if (e.which == 13) {
        e.preventDefault();
        onConfirm();
      }
    });

    $input.autocomplete({
      source: labels,
      position: { my : "right top", at: "right bottom" },
      select: function(e, ui) {
        var item = ui.item;
        $input.val(item.label);
        $input.data('item', item);
        e.preventDefault();
      }
    });

    $list.on('click', 'button', function(e) {
      e.preventDefault();
      $(this).parent().remove();
    });
  };

}());
