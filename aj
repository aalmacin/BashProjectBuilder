#!/bin/sh
main() {
  echo "Enter project title"
  read title
  if [[ $title = '' ]]; then
    echo "Invalid title"
    exit
  fi
  case $1 in
    '')
      makeEasel
      ;;
  esac
}

makeEasel() {
  mkdir "$title"
  cd "$title"
  mkdir lib js data classes css less assets
  mkdir assets/images assets/sounds
  echo "
<!DOCTYPE html>
<html>
  <head>
  <title>$title</title>
  <script type='text/javascript' src='lib/easel.js'></script>
  <script type='text/javascript' src='lib/jquery.js'></script>
  <script type='text/javascript' src='js/main.js'></script>
  <link type='text/css' rel='stylesheet' href='css/main.css'></link>
  <link type='text/css' rel='stylesheet' href='css/reset.css'></link>
  </head>
  <body>
    <div id='main'>
      <h1>$title</h1>
      <canvas id='mainCanvas' width='500' height='500'></canvas>
    </div>
  </body>
</html>" > index.html
  touch README.md
  touch css/main.css
  touch less/main.less
  echo "
(function() {
  \$('head').append('<script type='text/javascript' src='classes/Game.js'></script>');
  var game = new Game('mainCanvas');
  createjs.Ticker.addEventListener('tick', function(e) {
    game.update();
  });
})();
  " > js/main.js
  echo "
var Game = function(canvasName) {
  this.initialize(canvasName);
}

var p = Game.prototype = new createjs.Stage();

Game.prototype.Stage_initialize = p.initialize;
Game.prototype.initialize = function(canvasName) {
  this.Stage_initialize(canvasName);

  this.autoClear = true;
}
  " > classes/Game.js
  curl 'http://code.createjs.com/createjs-2013.12.12.min.js' -o 'lib/easel.js'
  curl 'http://code.jquery.com/jquery-1.11.0.min.js' -o 'lib/jquery.js'
  curl 'http://meyerweb.com/eric/tools/css/reset/reset.css' -o 'css/reset.css'
  open index.html
}

main
