/*TODO : Pause (space key)*/


$(function()  {

  let snake = {

  		body : [], /*array of [x,y] div coord */
  		direction : 'right', /*can be right left up down*/
  		color : 'black',

  		move() { /*one move*/
  	      setTimeout(function () {

            if (grid.food.length === 0) { grid.placeNewFood() };
  			    snake.updatingBody(); 
            grid.checkGameOver() ? grid.endOfGame() : snake.move();
  		    } , grid.speed 
  		  );
  		},

      updatingBody() { /*update snake body array after a move and change color accordingly*/
        let head = snake.body[snake.body.length-1]; 
        switch(snake.direction) { /*push new case in the body*/
            case 'left' : 
              snake.body.push( [ head[0]-1 , head[1] ] );
              break;
            case 'up' : 
              snake.body.push( [ head[0] , head[1]-1 ] );
              break;
            case 'right' : 
              snake.body.push( [ head[0]+1 , head[1] ] );
              break;
            case 'down' : 
              snake.body.push( [ head[0] , head[1]+1 ] );
              break;
            default :
            break;
          }; 
          /*Update css Color for movement*/
          head = snake.body[snake.body.length-1];
          let headId = ("0" + head[0]).slice(-2) + ("0" + head[1]).slice(-2);
          grid.updateCaseColor(headId, snake.color);

          let queue = snake.body[0] /*delete queue only if no food eaten, result in longer body*/
          let queueId = ("0" + queue[0]).slice(-2) + ("0" + queue[1]).slice(-2);
          if ( head[0] === grid.food[0] && head[1] === grid.food[1] ) {
            grid.food = [] ;
            grid.point = grid.point + 100;
          }
          else {
            grid.updateCaseColor(queueId, grid.color);
            snake.body.shift();
          }
        
            
      },

  		changeSnakeDirection(direction) { /*change direction from key imput*/
  		  switch(direction) {
  		  	case 'ArrowLeft' : 
  		  	  snake.direction = 'left' ;
  		  	  break;
  		  	case 'ArrowUp' : 
  		  	  snake.direction = 'up' ;
  		  	  break;
  		  	case 'ArrowRight' : 
  		  	  snake.direction = 'right' ;
  		  	  break;
  		  	case 'ArrowDown' : 
  		  	  snake.direction = 'down' ;
  		  	  break;
  		  	default :
  		 	  break;
  		  }; 
  		  return snake.direction;
  		},


  };


	
  let grid = { 

  	color : 'white',
  	speed : 250,
    food : [],
    point : 0,

    initNewGame() {
      grid.rendering();
      snake.body.push( [20,20], [21,20], [22,20] );
      snake.move();
    },
  	
  	rendering() { /*create grid 300*400px : 30x10case x 40x10case */
      $('div').remove();
  	  for (let y=1; y<31; y++) {
  	    for (let x=1; x<41; x++) {
  	  	  /*format div id to a two digit xxyy  from 0101 to 4030*/
  	  	  $('#container').append('<div id=' + ("0" + x).slice(-2) +  ("0" + y).slice(-2) + '></div>'); 
  	    };
  	  };
      $('div').css("background-color", grid.color);
    },

    updateCaseColor(id,color) { /*Update case background color */
    	caseToUpdate = $('#' + id);
    	caseToUpdate.css("background-color", color);
    	return caseToUpdate;
    },

    isPartOfTheSnake(array) { /* check if array is in snake array*/
      for (let i=0;i<snake.body.length;i++) { 
          if ( snake.body[i][0] === array[0] && snake.body[i][1] === array[1] ) {
            return true ;
          };
      };
      return false ;
    },

    isPartOfTheSnakeMinusHead(array) { /*check if array is part of the snak not counting the head*/
      for (let i=0;i<snake.body.length-1;i++) { 
          if ( snake.body[i][0] === array[0] && snake.body[i][1] === array[1] ) {
            return true ;
          };
      };
      return false ;
    },

    placeNewFood() {
      grid.food = [ Math.floor((Math.random() * 40) +1) , Math.floor((Math.random() * 30) +1) ];
      while ( grid.isPartOfTheSnake(grid.food)) {
        grid.food = [ Math.floor((Math.random() * 40) +1) , Math.floor((Math.random() * 30) +1) ];
      };

      let foodId = ("0" + grid.food[0]).slice(-2) +  ("0" + grid.food[1]).slice(-2);
      let divFood = $('#' + foodId);
      $('#' + foodId).css("background-color", 'pink');
      grid.speed > 30 ? grid.speed = grid.speed - 10 : grid.speed = 20;
    },

    checkGameOver() {

      grid.point = (260 - grid.speed)/10 + grid.point;
      $('#infos').html('<h2>Points : ' + grid.point + '</h2>')
      let head = snake.body[snake.body.length-1];
      let autoEaten = grid.isPartOfTheSnakeMinusHead(head);

      if ( head[0]<1 || head[0]>40 || head[1]<1 || head[1]>30 || autoEaten) {
        return true;
      } else {
        return false;
      };
    },

    endOfGame() {
      alert('Game Over');
      grid.rendering();
    },

  };


/*===============================================
  ===============================================
  =============================================*/

  /*Listener for key input*/
  /*$('html').on( 'keydown',snake.changeSnakeDirection(event) ) ;*/
  $('html').on('keydown',function(event) {
  	event.preventDefault();
  	snake.changeSnakeDirection(event.key);
    }
  );

  /*launch game*/
  grid.initNewGame();


});/*Jquerry ready function ending*/