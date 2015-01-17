$(document).on 'peek:render', (event, requestId, data) ->
  title = []
  title.push("Gets[HIT]: #{data.context.memcached.get_hits}")
  title.push("Gets[MISS]: #{data.context.memcached.get_misses}")
  title.push("Sets: #{data.context.memcached.sets}")

  $('#peek-memcached-tooltip')
    .attr('title', title.join('<br>'))
    .tipsy
      html: true
      gravity: $.fn.tipsy.autoNS
