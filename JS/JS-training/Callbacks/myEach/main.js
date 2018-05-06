
$(function()  {

var myEach = function(array, cb) {
	array.forEach(function(element) {
  	  cb(element);
	});
};

var myMap = function(array, cb) {
	let result = [];
	myEach(array, function(e){
		result.push( cb(e) );
	});
	return result;
};



myEach([1,2,3,4], function(e){console.log(e+1)});
var bar = myMap([1,2,3,4], function(e){return e*2});
console.log(bar);

});/*Jquerry ready function ending*/
