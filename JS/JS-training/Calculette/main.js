$(function()  {
	/*TODO : make a caculette object to contain everithing*/
	/* the calcul fonction dont handle math priority for multiplication*/
	/* only working for 2number and 1 operator */

	var calculus = "" ;

	var updateCalculus = function(calculus,newValue) {
		return calculus + newValue ; ;
	} ;

	var updateDisplay = function() {
		$( 'header' ).text(calculus) ;
	} ;

	var clearAll = function() {
		return "" ;
	} ;

	var calculOperatus = function(string) {
		console.log("Start a calcul");
		var calcul = string;
		const onlyNum = /^[0-9]+/;
		const notNum  = /[^0-9]+/;
		var reste;
		var num1;
		var num2;
		console.log(calcul);
		/*ex : 12+35-78 */
		num1 = calcul.match(onlyNum)[0]; /* 12 */
		if (num1 === calcul ) {
			return num1;
		} else {
		  reste = calcul.split(onlyNum)[1]; /* +35-78 */
		  operator = reste.match(notNum)[0]; /* + */
		  if (operator.length != 1) { return "ERROR : Operator not valid"} ; /* check for thing like +-+ */
		  reste = reste.slice(1); /* 35-78 */

		  if (reste === reste.match(onlyNum)[0]) {
		  	num2 = reste; 
		  } else {
		    num2 = calculOperatus(reste) /*recursive will handle the 35-78 */
		  } ;
		} ;
  
		return operatusCase(num1, num2, operator)
		/*return eval(calculus)*/ ;
	} ;

	var operatusCase = function(num1, num2, operator) {
		num1 = parseInt(num1, 10);
		num2 = parseInt(num2, 10);
		switch( operator ) {
			case '+' :
				return num1 + num2;
				break;
			case '-' :
				return num1 - num2;
				break;
			case '*' :
				return num1 * num2;
				break;
			case '/' :
				return num1 / num2;
				break;
			default :
				return 'ERROR : not an operator';
		} ;
	} ;

/* On click event */

	$( 'div' ).click(function() { 
		var newValue = $(this).text() ;
		calculus = updateCalculus(calculus,newValue) ;
		updateDisplay() ;
		}) ;

	$( '#clear').click(function() {
		calculus = clearAll() ;
		updateDisplay();
	}) ;

	$( '#egal').click(function() {
		 calculus = calculOperatus(calculus) ;
		 updateDisplay() ;
	}) ;

})