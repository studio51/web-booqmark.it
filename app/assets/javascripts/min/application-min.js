$(".bmk-container").hover(function(){var t,n;t=$(this),n=t.data("id"),console.log(n),$("#bmk-actions-"+n).toggleClass("hidden")}),$(".content-head-actions a").click(function(t){return t.preventDefault(),$.ajax({url:$(this).data("url")+".json",type:"GET",success:function(t){$(".content-data").html(t)}}),!1});