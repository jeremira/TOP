// ************************************
//              BARCHART
// ************************************



var data = [ 16, 68, 20, 30, 54 ];
//get a reference to the canvas 
var canvas = document.getElementById('canvas1'); 
//get a reference to the drawing context 
var c = canvas.getContext('2d'); 
//draw 
c.fillStyle = "white";
c.fillRect(0,0,500,500);
//draw data 
c.fillStyle = "blue";
for(var i in data) { 
  var dp = data[i];  
  c.fillRect(40 + i*100, 460-dp*5, 50, dp*5);
};
// draw axis line
c.fillStyle = "black";
c.lineWidth = 2.0;
c.beginPath();
c.moveTo(30,10);
c.lineTo(30,460);
c.lineTo(490,460);
c.stroke();
// draw text and vertical/horizontakl stroke
c.fillStyle = "black";
for(var i=0;i<6;i++) {
  c.fillText((5-i)*20+"",4,i*80+60);
  c.beginPath();
  c.moveTo(25,i*80+60);
  c.lineTo(30,i*80+60);
  c.stroke();
};
var labels = ["JAN","FEB","MAR","APR","MAY"]; 
for(var i=0;i<5;i++){
  c.fillText(labels[i], 50+ i*100, 475);
};




// ************************************
//              PIECHART
// ************************************



data = [100,68,20,30,100];
canvas = document.getElementById('canvas2');
c = canvas.getContext('2d');
//draw background
c.fillStyle = "white";
c.fillRect(0,0,500,500);
//a list of colors
var colors = [ "orange", "green", "blue", "yellow", "teal"]; 
//calculate total of all data
var total = 0;
for(var i in data) {
  total += data[i];
};
//draw pie data
var prevAngle = 0;
for(var i in data) {
  var fraction = data[i]/total;
  var angle = prevAngle + fraction*Math.PI*2;

  var grad = c.createRadialGradient(250,250,10,250,250,100);
  grad.addColorStop(0,"white");
  grad.addColorStop(1,colors[i]);
  c.fillStyle = grad;

  c.beginPath();
  c.moveTo(250,250);
  c.arc(250,250,100,prevAngle, angle, false);
  c.lineTo(250,250);
  c.fill();
  c.strokeStyle = "black";
  c.stroke();
  prevAngle = angle;
};
//draw centered legend text
c.fillStyle = "black";
c.font = "24pt sans-serif";
c.fillText("Awsome Data 2017", 250- c.measureText("Awsome Data 2017").width/2,400);


