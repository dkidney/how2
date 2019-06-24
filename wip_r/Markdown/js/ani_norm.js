(function($) {
    $(document).ready(function() {
	
	$('#ani_norm').scianimator({
	    'images': ['/ani_norm1.png', '/ani_norm2.png', '/ani_norm3.png', '/ani_norm4.png', '/ani_norm5.png', '/ani_norm6.png', '/ani_norm7.png', '/ani_norm8.png', '/ani_norm9.png', '/ani_norm10.png'],
	    'width': 480,
	    'delay': 500,
	    'loopMode': 'loop'
	});
	$('#ani_norm').scianimator('play');
    });
})(jQuery);
