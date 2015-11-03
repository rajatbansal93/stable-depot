function SlideShow(listSelector) {
  this.$list = $(listSelector);
  this.$elements = this.$list.find('li');
  this.index = 0;
}

SlideShow.prototype.init = function() {
  this.$elements.hide();
  this.showCounter();
  this.showNextSlide();
};

SlideShow.prototype.showNextSlide = function() {
  var _this = this;
  this.$elements.eq(this.index).fadeIn(800, function() {
    $("#currentElement").text(_this.index + 1);
  }).delay(1000).fadeOut(800, function() {
      _this.incrementIndex();
      _this.showNextSlide.call(_this);
  });
};

SlideShow.prototype.showCounter = function() {
  $('<h2>', {
    html : "<span id='currentElement'>" + (this.index + 1) +
    "</span>"+ '/' + this.$elements.length,
    id: 'counter'
  }).insertAfter(this.$list);
};

SlideShow.prototype.incrementIndex = function() {
  this.index = (this.index == this.$elements.length - 1) ? 0 : this.index + 1;
};

SlideShow.prototype.moveSlideshowToTop = function() {
  $('body').prepend(this.$list);
};

$(function() {
  var foodSlideshow = new SlideShow('#slideshow');
  foodSlideshow.init();
});
