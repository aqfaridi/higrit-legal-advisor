# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ajax:success', 'a.cvote', (status,data,xhr)->
  # the `data` parameter is the decoded JSON object
  temp = "+" + data.pcount
  temp2 = "-" + data.ncount

  $(".question-vote-result[data-id=#{data.id}]").text temp
  $(".question-vote-result2[data-id=#{data.id}]").text temp2


  $a = $(this)
  href = $a.attr 'href'
  res = href.split("/")


  if (res[res.length-1] == "clike")
	  $(".cvote[data-id=#{data.id}] i[class*=fa-thumbs-o-down]").remove();
	  $(".cvote[data-id=#{data.id}] i[class*=fa-thumbs-o-up]").removeClass('fa-thumbs-o-up').addClass('fa-thumbs-o-down');
	  $a.attr 'href', $a.data('toggle-href')
	  $a.data 'toggle-href', href
	  
  else if (res[res.length-1] == "cdislike")
	  $(".cvote[data-id=#{data.id}] i[class*=fa-thumbs-o-up]").remove();
	  $(".cvote[data-id=#{data.id}] i[class*=fa-thumbs-o-down]").removeClass('fa-thumbs-o-down').addClass('fa-thumbs-o-up');
	  $a.attr 'href', $a.data('toggle-href')
	  $a.data 'toggle-href', href

return  
