$(document).on('turbolinks:load', function() {
  //get rails temp data
  var backgroundData = $('.temp_information').data('temp');
  //load game only if game data are present
  if(typeof backgroundData !== "undefined" ) {
    waldoGame();
  };

  //Waldo Game Main function
  function waldoGame() {
    console.log("WaldoGame Initialized");
    //canva stuff
    var $canvas = $('#waldo-canvas');
    var $menu   = $('#context-menu');
    var c = $('#waldo-canvas')[0].getContext('2d');
    // will be popultaed with {id:X, name:X, url:xxx.jpg, locX: X, locY: Y} type obj
    var characterToFind = [];
    var characterFound = [];
    var clickCoordX;
    var clickCoordY;
     //ajax request
    $.ajax({
        url: window.location.href,
        dataType: 'json',
        method: 'GET',
    }).done(function(resp){
      console.log("Ajex succesfully respond")
      console.log(resp)
      for (var i=0 ; i<resp.length ; i++) {
        characterToFind.push(resp[i]);
        populateMenu(resp[i]);
      };
      activateClickEvent();
    }).fail(function(resp){
      console.log("Ajax request failed");
      console.log(resp);
      $menu.append(
          "<div> <p> Loading error ! </p> </div>"
        );
    });
    //draw background image
    var waldoBack = new Image();
    waldoBack.src = backgroundData.url;
    c.drawImage(waldoBack, 0, 0, 1200, 600);


////////Function declaration

    //Populate aside menu with a char to be found
  function populateMenu(obj) {
    console.log("Populating Menu...")
    console.log(obj);
      $menu.append(
        "<div class='char-btn' id='" + obj.id +"'> <img src='/assets/" + obj.url + "' width='35' height='35'> <h4>" + obj.name + "</h4> </div>"
      );
  };
    //Attach click event on menu button
  function activateClickEvent() {
    	$('.char-btn').on('click', function(e) {
    	//check if good char (this=la div)


      //si char.x == clickCoordX et char.y == clickCoordY
      //alors char found
    //  sinon "no char here"

     	 //maj of to find/found char
    	});
    };




    $canvas.on('click', function(e) {
      // get [x,y] of any click on canvas
      clickCoordX = e.pageX - $(this).offset().left;
      clickCoordY = e.pageY - $(this).offset().top;
      // update menu open location
      $menu.css("top",  clickCoordY);
      $menu.css("left", clickCoordX);
      //draw circle

      //open/close menu
      $menu.toggle();
    });



  };


});//$ready function ending
