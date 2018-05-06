/*TODO : Add possibilities to choose difficulties*/
        /*brush css to have a retro look*/

$(function()  {

/*Constructor for block unit*/
  var Block = function(coord){
    this.id = ("0" + coord[0]).slice(-2) + ("0" + coord[1]).slice(-2); /*id : 0102 pour coord: [1,2]*/
    this.coord = coord;
    this.bombed = false;
    this.revealed = false;
  };
  
  Block.prototype.countNearBomb = function() {
    let bombCounter = 0;

    this.adjacentBlock().forEach( function(block) { 
      if (block.bombed) { bombCounter = bombCounter + 1 ;};
    });
    return bombCounter;
  };

  Block.prototype.adjacentBlock = function() { /*TODO : solution to avoid those ugly repetition ?*/
    let adjacentBlock = [];
    let x,y,blockToAdd;

      y= this.coord[1] +1;
    x= this.coord[0] - 1;
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;
    x= this.coord[0];
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;
    x= this.coord[0] +1;
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;

      y= this.coord[1];
    x= this.coord[0] -1;
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;
    x= this.coord[0] +1;
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;

      y= this.coord[1] -1;
    x= this.coord[0] - 1;
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;
    x= this.coord[0];
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;
    x= this.coord[0] +1;
    blockToAdd = demineur.isAnExistingBlock([x,y]);
    if ( blockToAdd ) { adjacentBlock.push( blockToAdd ); } ;

    return adjacentBlock;
  };

/*Main game object*/
  var demineur = {
    grid : [],
    timer: 0,

    initialize() {
      /*delete all div and clean the grid*/
      this.grid = [];
      $('#container').children().remove();
      /*create grid array populate with block object*/
      for (y=0 ; y<9 ; y++) {
        for (x=0 ; x<9 ; x++) {
          this.grid.push( new Block([x,y]) );
        };
      };
      /*place 8 bomb on the board*/
      for ( let i = 0 ; i<8 ; i++) {
        this.placeOneBomb();
      };
      /*render the grid*/
      this.renderGrid();
      /*turn off right click context menu for grid*/
      $('#container').contextmenu(function() {
         return false;
      });
      /*turn on click event*/
      $('#new_game').on('click', function(event) {
        demineur.initialize();
      });

      $('span').on('mousedown', function(event) {
        event.preventDefault();
        switch(event.which) {
          case 1 :
            demineur.checkClickedBlock(event);
            break;
          case 3 :
            demineur.placeFlag(event);
            break;
          default:
            console.log("Error, swich case invalid");
        };        
      });
      /*launch timer*/
      this.timer = 0;
      this.startTimer();
    },

    renderGrid() { /*render initial grid with cache*/
      this.grid.forEach(function(block){
        let value;
        if (block.bombed) { value = "X" ; } else { value = block.countNearBomb() ; };
        $('#container').append("<div id=block" + block.id + ">" + value + "</div>");
        $('#block'+block.id).append("<span id=cache" + block.id +"></span>");
      });
    },

    placeOneBomb() { /*Place 1 bomb on the board randomly*/
      let randomCoord = [Math.floor(Math.random() * 9) , Math.floor(Math.random() * 9) ];
      let blockToCheck = this.isAnExistingBlock(randomCoord);
      if (blockToCheck.bombed) { this.placeOneBomb(); } else { blockToCheck.bombed = true; };
    },

    isAnExistingBlock(blockToCheck) { /*return the block object wich have the coord pass as an arg*/
      let foundBlock = this.grid.find( function(block) {
                        if (block.coord[0] === blockToCheck[0] && block.coord[1] === blockToCheck[1]) { ;return block; };
                        });
      if (foundBlock) {return foundBlock } else {return false};
    },

    checkClickedBlock(event) {
     let $block = $(event.target);
     let id = event.target.id.slice(-4);
     let coord = [parseInt(id.slice(0,2)),parseInt(id.slice(-2))];
     let block = this.isAnExistingBlock(coord);

     if (!block.bombed) { this.revealBlocks(block); };
     this.gameOverCheck(block);
    },

    revealBlocks(block) {
      $('#cache' + block.id).hide(); /*hide block*/
      block.revealed = true;
      /*recursive exit condition*/
      if (block.countNearBomb() !=0 ) { return } 
      /*recursive block*/
      let toBeCheck = [];
        block.adjacentBlock().forEach( function(b) {
          if (!b.revealed) { toBeCheck.push(b) };
        });
        toBeCheck.forEach( function(b) {
          demineur.revealBlocks(b);
        });
    },

    placeFlag(event) {
      let $span = $(event.target);
      $span.append('<p>F</p>');
    },

    gameOverCheck(block) {
      if(block.bombed) {
        $('#block' + block.id).css("background-color", "red");
        alert("!!! BOUM !!!");
        this.stopTimer();
        $('span').hide();
      } else if (this.hasWinned()) {
        alert("!!! Sucess !!!");
        this.stopTimer();
        $('span').hide();
      };
    },

    hasWinned() {
      let notRevealedBlock = [];
      this.grid.forEach(function(b) {
        if (!b.revealed) { notRevealedBlock.push(b) } ;
      });
      if (notRevealedBlock.length === 8) {return true} else {return false};
    },

    startTimer() {
      $('#time').html('<h2>'+this.timer+'</h2>')
      this.timer = this.timer + 1
      RUNNINGTIMER = setTimeout( function() { demineur.startTimer() }, 1000);
    },

    stopTimer() {
      clearTimeout(RUNNINGTIMER);
    },

  };/*end of Demineur object*/

  demineur.initialize();

});/*Jquerry ready function ending*/