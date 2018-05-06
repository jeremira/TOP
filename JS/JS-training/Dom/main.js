$(function()  {

	var contentNews = "<p>Such news ! Very mildy interest ! Must continue reading !</p>";
	var contentMenu = "<p>Tortilla ! Such good. Burger, hum...cheezy such cheese</p>";
	var contentInfo = "<p> Not far, very convenient. Such proximity</p>";
	var contentLega = "<p> What ?</p>";
	var allSpan = $('span');

	var updateContent = function(clickedSpan, content) {
		/*change color of the span */
		allSpan.css( "background-color", "#959595");
		allSpan.css( "color", "white");
		clickedSpan.css("background-color","#D2D2D2");
		clickedSpan.css("color","#959595");
		/* update content */
		$('p').remove();
		$('#content').append(content);
	};
	
	/* Update at first load, news page */
	updateContent( allSpan.eq(0), contentNews );

	/* Update on click */

	allSpan.click(function() {

		var clickedSpan = $(this);
		
		switch (clickedSpan.text() ) {
			case allSpan.eq(0).text() :
				updateContent(clickedSpan,contentNews);
				break;
			case allSpan.eq(1).text() :
				updateContent(clickedSpan,contentMenu);
				break;
			case allSpan.eq(2).text() :
				updateContent(clickedSpan,contentInfo);
				break;
			case allSpan.eq(3).text() :
				updateContent(clickedSpan,contentLega);
				break;
			default :
				console.log("Error case default") ;
				break;
		};
	});
});