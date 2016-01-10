# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Rails creates this event, when the link_to(remote: true)
# successfully executes

$(document).on 'ajax:success', 'a.vote', (status,data,xhr)->
  # the `data` parameter is the decoded JSON object
  temp = "+" + data.pcount
  temp2 = "-" + data.ncount

  $(".single-question-vote-result[data-id=#{data.id}]").text temp
  $(".single-question-vote-result2[data-id=#{data.id}]").text temp2


  $a = $(this)
  href = $a.attr 'href'
  res = href.split("/")


  if (res[res.length-1] == "like")
	  $(".vote[data-id=#{data.id}] i[class*=fa-thumbs-down]").remove();
	  $(".vote[data-id=#{data.id}] i[class*=fa-thumbs-up]").removeClass('fa-thumbs-up').addClass('fa-thumbs-down');
	  $a.attr 'href', $a.data('toggle-href')
	  $a.data 'toggle-href', href
	  
  else if (res[res.length-1] == "dislike")
	  $(".vote[data-id=#{data.id}] i[class*=fa-thumbs-up]").remove();
	  $(".vote[data-id=#{data.id}] i[class*=fa-thumbs-down]").removeClass('fa-thumbs-down').addClass('fa-thumbs-up');
	  $a.attr 'href', $a.data('toggle-href')
	  $a.data 'toggle-href', href

return  

