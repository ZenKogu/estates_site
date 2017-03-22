ymaps.ready(function(){
  var myMap = new ymaps.Map('yamap', {
      center:    [55.754663, 37.756657],
      zoom:      16,
      controls:  ['smallMapDefaultSet']
    }, {searchControlProvider: 'yandex#search'}),
    myPlacemark = new ymaps.Placemark(myMap.getCenter(), {}, { // Опции. Необходимо указать данный тип макета.
      iconLayout:      'default#image', // Своё изображение иконки метки.
      iconImageHref:   'img/yamap.png', // Размеры метки.
      iconImageSize:   [84, 53],        // Смещение левого верхнего угла иконки относительно её "ножки" (точки привязки).
      iconImageOffset: [-60, -50]
    });
  myMap.geoObjects.add(myPlacemark);
});
