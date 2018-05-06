$(function() { 


$('form').validate({

  rules: {
	email: "required",
	
    password: "required",
    password_again: {
      equalTo: "#password"
    }
  }

});




});/*Jquerry ready function ending*/