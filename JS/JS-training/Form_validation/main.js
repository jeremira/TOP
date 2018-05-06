$(function() {

  $('form').validate({

  	rules: {
  	  email: { required: true },
  	  confirm_email: { required: true , equalTo: "email" },
  	  password: {required: true , minlength: 6},
  	  confirm_password: { required: true , equalTo: "password" }
   	}	

  });

});