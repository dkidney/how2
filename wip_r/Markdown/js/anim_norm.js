(function($) {
    $(document).ready(function() {
	
	$('#anim_norm').scianimator({
	    'images': ['anim_dir/anim_norm1.png', 'anim_dir/anim_norm2.png', 'anim_dir/anim_norm3.png', 'anim_dir/anim_norm4.png', 'anim_dir/anim_norm5.png', 'anim_dir/anim_norm6.png', 'anim_dir/anim_norm7.png', 'anim_dir/anim_norm8.png', 'anim_dir/anim_norm9.png', 'anim_dir/anim_norm10.png'],
	    'width': 480,
	    'delay': 500,
	    'loopMode': 'loop'
	});
	$('#anim_norm').scianimator('play');
    });
})(jQuery);
