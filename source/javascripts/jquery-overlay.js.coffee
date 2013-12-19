$ ->
	$('.ol-content').hide()

	$('.ol-trigger')
		.on 'click', (ev) ->
			ev.preventDefault()

			html = """
			<div id="ol-wrapper">
				<div id="ol-content">
					<div class="inner">
					</div>
				</div>
				<div id="ol-layer">
				</div>
			</div>
			"""

			wrapper = $(html)
			wrapper.find('#ol-content .inner').html($('.ol-content').html())

			wrapper.hide()
			$('body').append(wrapper)
			wrapper.fadeIn(200)

			wrapper.find('#ol-layer')
				.on 'click', (ev) ->
					wrapper.fadeOut(200, ->
					  wrapper.remove()
					)
