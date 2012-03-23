;(function($){
  var options = {
        api_key: 'f687e67fd446b0752eab73c6d566a7e1'
      , format: 'json'
      , method: 'flickr.photos.getInfo'
      }
    , matcher = new RegExp('flickr.com/photos/[^/]+/([^/]+)')
    , url = 'http://api.flickr.com/services/rest/'

    , buildURL = function(photo) {
        return 'http://farm' + photo.farm + '.staticflickr.com/' + photo.server + '/' + photo.id + '_' + photo.secret + '.jpg';
      }
    , displayDialog = function(photo) {
        var img = document.createElement('img')
          , a = document.createElement('a')
          ;
        img.src = buildURL(photo);
        a.href  = photo.urls.url[0]._content;
        a.appendChild(img);

        ui.dialog(photo.title._content, a)
          .overlay()
          .closable()
          .show()
          ;
      }
    ;

  var getCache = function(key) {
        return JSON.parse(localStorage[key]);
      }
    , setCache = function(key, value) {
        localStorage[key] = JSON.stringify(value);
      }
    , inCache = function(key) {
        return key in localStorage;
      }
    ;


  $(function() {
    $('article a[href*="flickr.com"]')
      .addClass('flickrPhoto')
      .click(function(event) {
        event.preventDefault();

        var link = this
          , photo_id = this.href.match(matcher)[1];

        if ( inCache(link.href) )
        {
          displayDialog(getCache(link.href));
        }
        else
        {
          $.ajax({ type: 'GET'
            , url: url
            , dataType: 'jsonp'
            , jsonp: 'jsoncallback'
            , data: $.extend(options, {photo_id: photo_id})
            , success: function(data) {
                setCache(link.href, data.photo);
                displayDialog(data.photo);
              }
            });
        }
      });
  });
})(jQuery);
