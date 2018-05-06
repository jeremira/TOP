var can = document.getElementById("canvas");
var c = can.getContext('2d');
player.width = 46;
player.height = 46;

var ship_image;
var bomb_image;
var bullet_image;
loadResources();

function loadResources() {
  ship_image = new Image();
  ship_image.src = "images/Hunter1.png";
  bomb_image = new Image();
  bomb_image.src = "images/bomb.png";
  bullet_image = new Image();
  bullet_image.src = "images/bullets.png";
}

function mainLoop() {
  var c = can.getContext('2d');
  updateGame();
  updateBackground();
  updateEnemies();
  updatePlayer();
  
  updatePlayerBullets();
  updateEnemyBullets();
  checkCollisions();
  
  drawBackground(c);
  drawEnemies(c);
  drawPlayer(c);
  drawEnemyBullets(c);
  drawPlayerBullets(c);
  drawOverlay(c);
}
// =========== player ============
function firePlayerBullet() {
  //create a new bullet
  playerBullets.push({
    x: player.x,
    y: player.y - 5,
    width:10,
    height:10,
  });
}
function drawPlayer(c) {
    if(player.state == "dead") return;
    
    if(player.state == "hit") {
        c.fillStyle = "yellow";
        c.fillRect(player.x,player.y, player.width, player.height);
      return;
  }
  
  c.drawImage(ship_image,
        25,1, 23,23, 
        player.x, player.y, player.width, player.height
        );
}
function drawPlayerBullets(c) {
  //c.fillStyle = bullet_image;
  for(i in playerBullets) {
    var bullet = playerBullets[i];
    var count = Math.floor(bullet.counter/4);
    var xoff = (count%4)*24;
    //c.fillRect(bullet.x, bullet.y, bullet.width,bullet.height);
    console.log(bullet_image.src);
    c.drawImage(
         bullet_image,
         xoff+10,0+9,8,8,//src 
         10,10,20,20//dst 
         );
  }
}
// =========== background ============
function drawBackground(c) {
  c.fillStyle = "black";
  c.fillRect(0,0,can.width,can.height);
}
// =========== enemies ===============
function drawEnemies(c) {
    for(var i in enemies) {
        var enemy = enemies[i];
        if(enemy.state == "alive") {
            c.fillStyle = "green";
            c.fillRect(enemy.x,enemy.y,enemy.width,enemy.height);
        }
        if(enemy.state == "hit") {
            c.fillStyle = "purple";
            c.fillRect(enemy.x,enemy.y,enemy.width,enemy.height);
        }
        //this probably won't ever be called.
        if(enemy.state == "dead") {
            c.fillStyle = "black";
            c.fillRect(enemy.x,enemy.y,enemy.width,enemy.height);
        }
    }
}
function createEnemyBullet(enemy) {
    return {
        x:enemy.x,
        y:enemy.y+enemy.height,
        width:4,
        height:12,
        counter:0,
    }
}
function drawEnemyBullets(c) {
    for(var i in enemyBullets) {
        var bullet = enemyBullets[i];
        c.fillStyle = "yellow";
        c.fillRect(bullet.x, bullet.y , bullet.width, bullet.height);
    }
}
// =========== overlay ===============
function drawOverlay(c) {
    if(game.state == "over") {
        c.fillStyle = "white";
        c.font = "Bold 40pt Arial";
        c.fillText("GAME OVER",140,200);
        c.font = "14pt Arial";
        c.fillText("press space to play again", 190,250);
    }
    if(game.state == "won") {
        c.fillStyle = "white";
        c.font = "Bold 40pt Arial";
        c.fillText("SWARM DEFEATED",50,200);
        c.font = "14pt Arial";
        c.fillText("press space to play again", 190,250);
    }
}
doSetup();
setInterval(mainLoop,1000/30);