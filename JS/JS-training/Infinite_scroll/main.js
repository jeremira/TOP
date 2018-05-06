$(function() {
	$('#loading_indicator').hide();

	var $form  = $('form');
	var $input = $('#title');
	var movies;
	var movieRendered;

	$form.submit( function(e) {
		e.preventDefault();

		var searchRequest = $('#title').val();	
		
		$.ajax({
		  url: "http://www.omdbapi.com/?",
		  data: {type: 'movie', s: searchRequest },
		  type: "GET",
		  dataType: "json",
	    })
	    .done(function(answer){
	      console.log("Done!");
	      console.log(answer);

	      movies = answer['Search']

	      for ( var i = 0 ; i < 3 ; i++ ) {
	      	createDiv(movies[i]);
	      };
	      movieRendered = 3;

	    })
	    .fail(function(xhr, status, errorThrown){
	      console.log("Fail!");
	      console.log(errorThrown + "**"+status);
	      $('section').append("<div><h4>Sorry, something went wrong...</h4><p>"+errorThrown+"</p></div>");
	    })
	    .always(function(xhr, status){
	    	console.log("Request complet");
	    });

		
	} );


  $(document).scroll(function(e){
  	if (movieRendered > 10) { return } ;
  	movieRendered++;
   	createDiv(movies[movieRendered]);	    
  });


  $( "#loading_indicator" )
    .ajaxStart(function() {
        $( this ).show();
    })
    .ajaxStop(function() {
        $( this ).hide();
   });



  var createDiv = function(movieObject) {
  	$container = $('section');
  	content = "<div><img src =\"" + movieObject['Poster'] + "\"><h4>" + movieObject['Title'] +
  			  " - " + movieObject['Year'] + "</h4><p>ImdbID : " + movieObject['imdbID'] + "</p></div>";  
  	$container.append(content);
  };


  



}); //Jquerry end