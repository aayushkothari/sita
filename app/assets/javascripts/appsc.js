var articlelist=new Array();
function toijson(elem) {
		var id = $(elem).attr("id");
       $.getJSON("http://query.yahooapis.com/v1/public/yql?q="+encodeURIComponent("SELECT * FROM feed WHERE url='http://news.google.co.in/news?pz=1&cf=all&ned=in&hl=en&output=rss"+id+"/index.rss'")+"&format=json",
          function(data) {
          		console.log(data);
              var id = data.query.results.item;
              console.log(id);
              var pageno=["one","two","three","four","five","six","seven","eight"];
              
              for(var i=0; i<8; i++) {
             articlelist[i]=data.query.results.item[i].description;
             titlelist[i]=data.query.results.item[i].title;
              console.log(data.query.results.item[i].title);
  
              $('.book').append('<div class="'+pageno[i]+' page"><div class="pageContents">'+titlelist[i]+'<br>'+articlelist[i]);
              $('#titlelist').listview('refresh');
          }
          }
);
}

