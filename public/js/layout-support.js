$(function() {
	var $form = $('#search_tools');
	/* Materials page. Left column tools checkbox engine */
	$form.on('click', '.steps', function(e) {
		e.preventDefault();
		var $clicked = $(e.target);
		var $parent = $clicked.parent();
		if ($clicked.hasClass('steps') || !$parent.hasClass('content')) {
			$(this).toggleClass('open');
		} else {
			var $input = $('#' + $clicked.attr('for'));
			var res = !$input.prop('checked');
			$input.prop('checked', res);
			$parent.parent().find('> input').prop('checked', !!$parent.find('> input:checked').length);
		}
	});

	/* Materials page. Left column tools radio engine */
	$form.on('click', '.radiogroup label', function(e) {
		e.preventDefault();
		$('.radiogroup input[type="radio"]').prop('checked', false);
		$('#' + $(e.target).attr('for')).prop('checked', true);
		$('.daterange input').val('');
	});
	$form.on('change', '.daterange input', function(e) {
		if (e.target.value.length) {
			$('.radiogroup input[type="radio"]').prop('checked', false);
		}
	});

	$("input.date" ).datepicker();


	$('.article__tools__tree').on('click', 'li', function(e) {
		// e.preventDefault();
		e.stopImmediatePropagation();
		var $clicked = $(e.target);
		$clicked.parent().toggleClass('open');
	});


	/* Video */
	// var videoControls = {
	//   parent: $(".video"),
	//   video: $(".video video:first"),
	//   playpause: $(".video__playpause"),
	//   togglePlayback: function() {
	//     (video.paused) ? video.play() : video.pause();
	//   }
	// };
	// var video = videoControls.video[0];

	// videoControls.playpause.click(function() {
	//   if (video.paused) {
	//     video.play();
	//   } else {
	//     video.pause();
	//   }
	//   videoControls.parent.toggleClass("paused");
	// });
	// videoControls.video.click(function() {
	//   videoControls.togglePlayback();
	// });
	// video.addEventListener("ended", function() {
	//   video.pause();
	//   videoControls.parent.toggleClass("paused");
	// });
	// video.addEventListener("play", function() {
	//   videoControls.parent.toggleClass("paused");
	// });
	// video.addEventListener("pause", function() {
	//   videoControls.parent.toggleClass("paused");
	// });

	$('.gallery__prev').on('click', function(){
		gallery 		= $(event.target).parents('.gallery__wrapper');
		active__slide 	= gallery.find('.gallery__slide.active');
		next 			= +active__slide.attr('data-slide') - 1;
		prev__slide		= gallery.find(".gallery__slide[data-slide='"+next+"']");
		if (prev__slide.length>0){
			gallery.find('.gallery__slide').removeClass('active').addClass('hidden');
			prev__slide.addClass('active').removeClass('hidden');
			gallery.find('.gallery__dots>button.active').removeClass('active');
			gallery.find(".gallery__dots>button[data-slide='"+next+"']").addClass('active');
		}
		else { 
			gallery.find('.gallery__slide').removeClass('active').addClass('hidden');
			gallery.find('.gallery__slide:last').addClass('active').removeClass('hidden');
			gallery.find('.gallery__dots>button.active').removeClass('active');
			gallery.find(".gallery__dots>button:last").addClass('active');
		};
	});


	$('.gallery__next').on('click', function(e) {
		gallery 		= $(event.target).parents('.gallery__wrapper');
		active__slide 	= gallery.find('.gallery__slide.active');
		next 			= +active__slide.attr('data-slide') + 1;
		next__slide		= gallery.find(".gallery__slide[data-slide='"+next+"']");
		if (next__slide.length>0){
			gallery.find('.gallery__slide').removeClass('active').addClass('hidden');
			next__slide.addClass('active').removeClass('hidden');
			gallery.find('.gallery__dots>button.active').removeClass('active');
			gallery.find(".gallery__dots>button[data-slide='"+next+"']").addClass('active');
		}
		else { 
			gallery.find('.gallery__slide').removeClass('active').addClass('hidden');
			gallery.find('.gallery__slide:eq(0)').addClass('active').removeClass('hidden');
			gallery.find('.gallery__dots>button.active').removeClass('active');
			gallery.find(".gallery__dots>button:eq(0)").addClass('active');
		};
	});


$('.img__preview').on('click', function(e){
	src1 = $(event.target).parents('.table__cell').find('img').attr('src');
	src2 = $(event.target).parents('.left').find('img').attr('src');
	$('.is-image').attr('src',src1||src2);
});

// $('figure.left').on('click', function(e){
// 	src = $(event.target).attr('src');
// 	$('.is-image').attr('src',src);
// })


});

