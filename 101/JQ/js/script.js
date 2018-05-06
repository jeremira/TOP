$(document).ready(function() {

//create default grid 4*4
	for(i=0 ; i<16 ; i++) {
		$('#wrapper').append("<div class='box'></div>") ;
	} ; 
$('.box').css( {"height":"160" , "width":"160"});

//Clear and create custom grid
$('#top').click(function(){
	var box_number = prompt("Side lenght ? (More than 200 is not advised !) ","4") ;
	var box_side = (640 / box_number) ;
	$('.box').remove();
	
	for(i=0 ; i<(box_number*box_number) ; i++) {
			$('#wrapper').append("<div class='box'></div>") ;
		} ;

	$('.box').css( {"height":box_side , "width":box_side});

}) ;



//Random color on mouse enter
$(document).on("mouseenter", ".box" , function(){
	$(this).css({'background-color':choose_color()}) ;

}) ;

//Restore default color, and reduce opacity by 10% on mouse leave
$(document).on("mouseleave", ".box" , function(){
	$(this).css({'background-color':'#a0a7b0'}) ;
	var opac = $(this).css('opacity') - 0.20 ;
	$(this).fadeTo(100 , opac) ;
	} ) ;

	 


var choose_color = function() { 
var hex = ["0" , "1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "0" , "a" , "b" , "c" , "d" , "e" , "f"] ;
var rand_color = "#" ;
	for ( i=0 ; i<6 ; i++ ) {
		rand_color += hex[Math.round(Math.random()*15)] ;
	}
	return rand_color ;
} ;







});