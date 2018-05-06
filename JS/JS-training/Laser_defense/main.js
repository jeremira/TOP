$(function()  {

  //TODO add check pour les missiles qui vont en dessous de la ville

  var canvas = $('#game')[0];
  var ctx = canvas.getContext('2d');
  var hudcanvas = $('#hud')[0];
  var hud = hudcanvas.getContext('2d');

  
 //
 //
 //
 //
 //

 // Constructor for Defense Missile unit
 var Defense = function(x,y){
    this.x = x;
    this.y = y;
    this.radius = 0;
    this.opacity = 1;
  };

  Defense.prototype.getOlder = function() {
    this.radius = this.radius + 1;
  };

  Defense.prototype.fadeOut = function() {
    this.opacity = this.opacity - 0.2;
  };

  Defense.prototype.drawIt = function() {
    ctx.beginPath();
    ctx.moveTo(this.X, this.Y);
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI, false);
    ctx.fillStyle = 'rgba(226, 156, 64, '+this.opacity+')';
    ctx.fill();
  };

// 
// 
//
//
//
//
//
 // Constructor for Ennemies Missile unit
  var Missile = function(x,y){
    this.originX = x;
    this.originY = y;
    this.x = x;
    this.y = y;
    this.vitX = 0;
    this.vitY = 0;
  };

  Missile.prototype.moveIt = function() {
    this.x = this.x + this.vitX;
    this.y = this.y + this.vitY;
  };

  Missile.prototype.setYvit = function(vitMax) {
    var vit  = Math.random() * vitMax ;   
    this.vitY = vit + 0.1;
  };

  Missile.prototype.setXvit = function() {
    var toggle = Math.round(Math.random());
    var vitMax = 0
    if(toggle === 0) { vitMax = (800 - this.originX) / (500 / this.vitY); 
    } else {
      vitMax = (this.originX / (500 / this.vitY)) * -1;
    }; 
    this.vitX = Math.random() *  vitMax ;    
  };

  Missile.prototype.drawIt = function() {
    ctx.beginPath();
    ctx.moveTo(this.originX, this.originY);
    ctx.lineTo(this.x , this.y);
    ctx.strokeStyle = 'white';
    ctx.lineWidth = 2;
    ctx.stroke();
  };

// 
// 
//
//
//
//
//
 // Constructor for Ciry unit
 var Appartement = function(x,y){
    this.x = x;
    this.y = y;
    this.opacity = 1;
    this.destroyInProgress = false;
  };

  Appartement.prototype.drawIt = function() {
    ctx.beginPath();
    ctx.arc(this.x, this.y, 5, 0, 2 * Math.PI, false);
    ctx.fillStyle = 'rgba(198, 198, 179, '+this.opacity+')';
    ctx.fill();
  };
// 
// ctx.fillStyle = 'rgba(255, 255, 255, '+this.opacity+')';
//
//
//
//
//

  var game = {
    missiles : [],
    city: [],
    defenseLaunched: [],
    laser : 10,
    population : 0,
    score : 0,
    level: 1,

    init() {  //create missile
      for( var i=0 ; i<200 ; i++) {
        //       Math.random() * (max - min) + min;
        var x  = Math.random() * (750 - 50) + 50;
        x = Math.floor(x)
        var missile = new Missile(x,0);
        missile.setYvit(game.level);
        missile.setXvit();
        //console.log(missile.vitX + " " + missile.vitY )
        this.missiles.push(missile);
      };
            //create city
      for( var x=10 ; x<790 ; x = x +11) {
        var stairs = Math.round(Math.random()*12) + 1;
        building = [];
        for( var k =0 ; k<stairs ; k++) { 
          var appartement = new Appartement(x, 500 -(k*8+11) );
          building.push( appartement );
        };
        this.city.push(building);
      };

          //turn on click event listener
      $('#game').on('click', function(e) {
        var x = e.pageX - $(this).offset().left;
        var y = e.pageY - $(this).offset().top; 
        game.launchDefense(x,y);
      });
    },

    collision(circleA, circleB) {// return true if collision occured, circle arg expect [centerX,centerB,radius]
      var xA = circleA[0];
      var yA = circleA[1];
      var rA = circleA[2];
      var xB = circleB[0];
      var yB = circleB[1];
      var rB = circleB[2];
      // urra for pyta, anyway to do ² more nicely ? check math pow()
      var xDistCarre      = (xB - xA) * (xB - xA);
      var yDistCarre      = (yB - yA) * (yB - yA);
      var centerDistCarre = xDistCarre + yDistCarre;

      if ( centerDistCarre <= (rA + rB)*(rA + rB) ) {
        return true
      }  else {
        return false
      };
    },

    launchDefense(x,y) { //create a new defense missile
      if (this.laser > 0) {
        this.defenseLaunched.push( new Defense(x,y) );
        this.laser--;
      };
    },

    updateCity() {
      for( var i = 0 ; i < this.city.length ; i++) {
        var building = this.city[i];
        for( var j = 0 ; j < building.length ; j++ ) {
          var appartement = building[j];
          if (appartement.destroyInProgress) {
            appartement.opacity = appartement.opacity - 0.10;
          };
          if (appartement.opacity < 0) {
            this.city[i].splice(j,1);
          };
        };
      };
    },

    updateDefense() {
      for ( var i = 0 ; i<this.defenseLaunched.length ; i++ ) {
        defense = this.defenseLaunched[i];     
        if (defense.radius > 35) { 
          this.defenseLaunched.splice( i , 1 ); //remove element          
        } else if (defense.radius > 30) {
          defense.getOlder();
          defense.fadeOut();
        } else {
          defense.getOlder();
        };
      };
    },

    updateMissiles() {  //update missiles values after a move
      for ( var i = 0 ; i<this.missiles.length ; i++ ) {
        this.missiles[i].moveIt();
      };
    },


    drawDefense() {
      for( var i = 0 ; i<this.defenseLaunched.length ; i++) {
        this.defenseLaunched[i].drawIt();
      }
    },

    drawMissiles() { //draw missile
      for ( var i = 0 ; i<this.missiles.length ; i++ ) {
        this.missiles[i].drawIt();
      };
    },

    drawCity() {//draw city
      for( var i = 0 ; i < this.city.length ; i++) {
        var building = this.city[i];
        for( var j = 0 ; j < building.length ; j++ ) {
          var appartement = building[j];
          appartement.drawIt();
        };
      };
    },

    checkCollision() {
     // check missile / city
        var appart;
        var explodedAppart;
        var building;
        var missile;
        var laser;
        for( var i=0 ; i< this.missiles.length ; i++ ) {
          missile = this.missiles[i];
          if (missile.y > 495) { 
            this.defenseLaunched.push( new Defense(missile.x, missile.y) );
            this.missiles.splice(i,1);
          };
          for( var b=0 ; b<this.city.length ; b++ ) {
            building = this.city[b];
            for( var a=0 ; a<this.city[b].length ; a++ ) {
              appart = building[a];
              if (this.collision([appart.x, appart.y, 5] , [missile.x, missile.y, 2] ) ) {
                  this.defenseLaunched.push( new Defense(missile.x, missile.y) );
                  this.missiles.splice(i,1);
              };
            };
          };
        };
        // check missile / explosion
        for( var l=0 ; l < this.defenseLaunched.length ; l++ ) {
          laser = this.defenseLaunched[l];
          for( var m=0 ; m<this.missiles.length ; m++ ) {
            missile = this.missiles[m];
            if (this.collision([missile.x, missile.y, 2] , [laser.x, laser.y, laser.radius])) {
              this.defenseLaunched.push(new Defense(missile.x, missile.y));
              this.missiles.splice(m,1);
          };
        }; 
        //check city / explosion  
        for( e=0 ; e< this.defenseLaunched.length ; e++ ) {
          laser = this.defenseLaunched[e];
          for( b=0 ; b<this.city.length ; b++ ) {
            building = this.city[b];
            for( a=0 ; a<building.length ; a++ ) {
              appart = building[a];
              if (this.collision([appart.x, appart.y, 5] , [laser.x, laser.y, laser.radius] ) ) {
                //delete appartement
                for(var w = a ; w<building.length ; w++) {
                  explodedAppart = building[w];
                  explodedAppart.destroyInProgress = true;
                };
              };
            };
          };
        };
      };
    },

    updateData() {
      var population = 0;
        for( var b=0 ; b<this.city.length ; b++ ) {
          for( var a=0 ; a<this.city[b].length ; a++ ) {
            population = population + 100  
          };
        };
      this.population = population;
    },

    drawBoard() {  
      ctx.fillStyle = 'rgba(22, 45, 84, 1)';
      ctx.fillRect(0,0,800,500);
      ctx.fillStyle = 'rgba(191, 171, 124, 1)';
      ctx.fillRect(0,490,800,10);
      //HUD update
      hud.fillStyle = 'rgba(191, 171, 124, 1)';
      hud.fillRect(0,0,800,25);
      hud.font = '16px Arial';
      hud.fillStyle = 'black';
      var hudText = "!!!* Laser defense remaining : " + this.laser + " *!!!       -- Population alive : " + this.population;
      hud.fillText(hudText, 150, 20);

    }    
  };
// 
// 
// 

// Init level
game.init();
// Main game loop
setInterval( function() {
    game.drawBoard();
    game.updateData();

    game.updateMissiles();
    game.updateDefense();
    game.updateCity();

    game.checkCollision();

    game.drawMissiles();
    game.drawDefense();
    game.drawCity();
  }
  , 20);

});/*Jquerry ready function ending*/