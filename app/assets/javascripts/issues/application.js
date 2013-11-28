//= require_tree ./components
//

this.gts = this.gts || {};

gts.app.feature('expandable-textarea', gts.expandableTextarea, {
  elements: ['gts-textarea-expandable']
});

gts.app.feature('delete-links', gts.deleteLinks, {
  elements: ['gts-delete-links']
});

gts.app.feature('issue-assignee-autocomplete', gts.issueAssigneeAutocomplete, {
  elements: ['gts-issue-assignee-candidate'],
  depends: ['issue-assignee-candidates']
});

gts.app.feature('issue-label-autocomplete', gts.issueLabelAutocomplete, {
  elements: ['gts-issue-label'],
  depends: ['project-labels']
});

gts.app.feature('issue-filters', gts.issueFilters, {
  elements: ['gts-issue-filters']
});

$(function() {
  $('.gts-date-picker').datepicker();
});
