function Rating(fieldSelector) {
  this.$ratingField = $(fieldSelector);
}

Rating.prototype.bindEvents = function() {
  this.$ratingField.on("change", this.sendAjaxRequest());
}

Rating.prototype.sendAjaxRequest = function() {
  var _this = this;
  return function() {
    var __this = this;
    $.ajax({
      url: window.location.href,
      dataType: "json",
      data: { rating: this.value, product_id: $(this).data('product-id') } })
      .success(function( data ) {
        $($(`span [data-product-id=${data.product_id}]`)[1]).html(`Average rating ${data.average_rating}`);
      });
  }
}

$(function() {
  var rating = new Rating("select.product_rating");
  rating.bindEvents();
});
