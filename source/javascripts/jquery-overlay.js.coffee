class OverlayBox
  @html = """
  <div id="ol-wrapper">
    <div id="ol-content">
      <div class="inner"></div>
    </div>
    <div id="ol-layer"></div>
  </div>
  """

  constructor: (options) ->
    defaultOptions =
      innerContent: '.ol-content'
      trigger: '.ol-trigger'

    @options = $.extend({}, defaultOptions, options)
    @hideInnerContent()
    @hideOverlayWrapper()

    $(@options.trigger)
      .on('click', @showOverlayBox)

  hideInnerContent: =>
    $(@options.innerContent).hide()

  hideOverlayWrapper: ->
    $(document).on 'overlay:closing', ->
      $('#ol-wrapper').fadeOut(300, -> $('#ol-wrapper').remove())

  showOverlayBox: (ev) =>
    ev.preventDefault()

    wrapper = $(OverlayBox.html)
    content = wrapper.find('#ol-content')
    wrapper.find('#ol-content .inner').html($(@options.innerContent).html())

    windowWidth   = $(window).width()
    windowHeight  = $(window).height()

    wrapper.hide()
    $('body').append(wrapper)

    wrapper.fadeIn(300)
    content.css('left', (windowWidth / 2) - (content.width() / 2))
    content.css('top', (windowHeight / 2) - (content.height() / 2))

    wrapper.find('#ol-layer')
      .on 'click', (ev) ->
        $(document).trigger('overlay:closing')

    $(document)
      .on 'keyup', (ev) ->
        $(document).trigger('overlay:closing') if ev.keyCode is 27

$ ->
  new OverlayBox(innerContent: '.content', trigger: '.trigger')
  new OverlayBox(innerContent: '.content-2', trigger: '.trigger-2')
