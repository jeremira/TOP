/*TODO : get all image from a folder + function to update imagecontent*/
/* arrange design, lol*/

$(function()  {

  let slider = {

    currentImgIndex : 0,
    imageContent : ["01","02","03","04","05"],
   
    init() {
      for( i in this.imageContent ) {
        $('#slider').append("<img src='images/" + this.imageContent[i] + ".jpeg' id='" + this.imageContent[i] + "'>");
        $('#dotwrapper').append("<nav id=dot" + this.imageContent[i] +"></nav>")
      };
      this.toggleVisibility($('img'));
      this.toggleVisibility($('#01'));
      this.currentImgIndex = 0;
    },

    toggleVisibility(image) {/*tooglle hidden/visible visibility css*/
      /*add a check : is image a $object ?*/
      if(image.css('visibility') === "hidden") {
        image.css('visibility', 'visible');
      } else {
        image.css('visibility', 'hidden');
      };
      image.css('left', '0'); /*reset possition after toogle*/
    },

    slideImage(nextImageIndex, direction) {/*slide image left or right*/

      let currentImg = $('#' + this.imageContent[slider.currentImgIndex]);
      let nextImg ;

      switch(direction) {
        case "next":
          if (nextImageIndex>4) { nextImageIndex = 0; } ;
          nextImg    = $('#' + this.imageContent[nextImageIndex]);
          currentImg.animate( {left: [ "-=300", "swing" ]}, 1500, function() {slider.toggleVisibility(currentImg); } );
          nextImg.css('left', '300px').css('visibility', 'visible').animate( {left: [ "-=300", "swing" ]}, 1500 );
          break;
        case "prev":
          if (nextImageIndex<0) { nextImageIndex = 4; } ;
          nextImg    = $('#' + this.imageContent[nextImageIndex]);
          currentImg.animate( {left: [ "+=300", "swing" ]}, 1500, function() {slider.toggleVisibility(currentImg); } );
          nextImg.css('left', '-300px').css('visibility', 'visible').animate( {left: [ "+=300", "swing" ]}, 1500 );
          break;
        default:
          console.log("Debug error : slideImage function called with wrong argument (" + direction +")");
          break;
      };
      this.currentImgIndex = nextImageIndex;
    },

    dotSliding(dotId) {
      
      let nextImageIndex = this.imageContent.indexOf(dotId.slice(-2));
      let nextImg    = $('#' + dotId.slice(-2));
      let currentImg = $('#' + this.imageContent[slider.currentImgIndex]);

      if ( nextImageIndex > this.currentImgIndex ) {
        this.slideImage(nextImageIndex, "next");
      } else if (nextImageIndex < this.currentImgIndex) {
        this.slideImage(nextImageIndex, "prev");
      };
    }

  };


slider.init();
$('#next')    .on("click", function() { slider.slideImage(slider.currentImgIndex + 1 , "next"); });
$('#previous').on("click", function() { slider.slideImage(slider.currentImgIndex - 1 , "prev"); });
$('nav')      .on("click", function() { slider.dotSliding(this.id) });


});/*Jquerry ready function ending*/