function DestroyLink(fieldSelector) {
  this.$destroylinks = $(fieldSelector);
}

DestroyLink.prototype.bindEvents = function() {
  this.$destroylinks.on("click", this.sendAjaxRequest());
}

DestroyLink.prototype.sendAjaxRequest = function() {
  var _this = this;
  return function() {
    var __this = this;
    $.ajax({
      url: "http://localhost:3000/images/" + $(this).data("image-id"),
      type: "delete",
      dataType: "json",
      data: { id: $(this).data("image_id") }
    })
      .success(function( ) {
        $(`[data-image-id=${$(__this).data("image-id")}]`).hide();
      });
  }
}

$(function() {
  var links = new DestroyLink("a.image_remove_links");
  links.bindEvents();
});
