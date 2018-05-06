/*TODO : ajouter une div qui barre les trois case gagnantes*/
/* make it impossible to play twice the same case*/

$(function()  {

  let morpion = {

    grid : [],
    currentPlayer : "X",

    init() {
      this.currentPlayer = "X";
      this.grid = [0,1,2,3,4,5,6,7,8];
      /* append div, id : case0, case1..., case8 */
      $('div').remove();
      this.grid.forEach( function(e,i) {$('#container').append("<div id=case" + i + "></div>");} );
      /*turn on click event*/
      $('div').on('click', function() { morpion.play(this.id); } );
      
    },

    play(divId) {
        $('#'+divId).append("<span>" + this.currentPlayer + "</span>");
        this.grid[divId.slice(-1)] = this.currentPlayer;
        this.checkGameOver();
    },

    checkGameOver() {

      if (this.checkWin()) {
        alert(this.currentPlayer + " win !");
        this.init();
      } else if (this.checkEgalite()) {
        alert("Nobody win !");
        this.init();
      } else {
        this.currentPlayer === "X"? this.currentPlayer = "0" : this.currentPlayer = "X";
      };

    },

    checkEgalite() {
      let check = 0
      this.grid.forEach( function(e,i) {
        if ( Number.isInteger(e) ) { check = 1 };
      });
      console.log(check);
      if (check === 0 ) { return true ;} else { return false ;};
    },

    checkWin() {
      const grid = this.grid;
      /*win horizontal*/
      if ( grid[0] === grid[1] && grid[0] === grid[2]) { return true ;} ;
      if ( grid[3] === grid[4] && grid[3] === grid[5]) { return true ;} ;
      if ( grid[6] === grid[7] && grid[6] === grid[8]) { return true ;} ;
      /*win vertical*/
      if ( grid[0] === grid[3] && grid[0] === grid[6]) { return true ;} ;
      if ( grid[1] === grid[4] && grid[1] === grid[7]) { return true ;} ;
      if ( grid[2] === grid[5] && grid[2] === grid[8]) { return true ;} ;
      /*win diagonal*/
      if ( grid[0] === grid[4] && grid[0] === grid[8]) { return true ;} ;
      if ( grid[6] === grid[4] && grid[6] === grid[2]) { return true ;} ;

      return false;
    }

  };




$('#newgame').on('click', morpion.init() );
morpion.init();

});/*Jquerry ready function ending*/