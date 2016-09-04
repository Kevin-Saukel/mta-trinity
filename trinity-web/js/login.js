var inAction = false;

$(document).ready(function () {
   $('.tab-panel .tab-list a').on('click', function (e) {
		if ( inAction == false ) {
			inAction = true;
			var currentAttrValue = jQuery(this).attr('redirection');

			$('.tab-panel ' + currentAttrValue).siblings().slideUp(400);
			$('.tab-panel ' + currentAttrValue).delay(400).slideDown(400);
			
			setTimeout(function() {inAction=false;},800);

			$(this).parent('li').addClass('active').siblings().removeClass('active');

			e.preventDefault();
		}
    });
});
