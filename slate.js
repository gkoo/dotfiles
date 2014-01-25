/* globals slate */

var pushRight = slate.operation('push', {
  'direction' : 'right',
  'style' : 'bar-resize:screenSizeX/2'
}),

pushLeft = slate.operation('push', {
  'direction' : 'left',
  'style' : 'bar-resize:screenSizeX/2'
}),

halfThrow0 = slate.operation('throw', {
  'screen': '0',
  'width' : 'screenSizeX/2',
  'height' : 'screenSizeY'
}),

halfThrow1 = slate.operation('throw', {
  'screen': '1',
  'width' : 'screenSizeX/2',
  'height' : 'screenSizeY'
}),

throw0 = slate.operation('throw', {
  'screen': '0',
  'width' : 'screenSizeX',
  'height' : 'screenSizeY'
}),

throw1 = slate.operation('throw', {
  'screen': '1',
  'width' : 'screenSizeX',
  'height' : 'screenSizeY'
}),

fullscreen = slate.operation('move', {
  'x' : 'screenOriginX',
  'y' : 'screenOriginY',
  'width' : 'screenSizeX',
  'height' : 'screenSizeY'
}),

adiumPush = slate.operation('push', {
  'direction': 'right'
}),

// Special-case windows
appOperations = function(win) {
  var appName = win.app().name();
  if (appName === 'Adium' && win.title() === 'Contacts') {
    // Adium Contacts list
    win.doOperation(adiumPush);
    return true;
  }
  return false;
};

// Two-monitor set-up
slate.bind('1:ctrl;cmd', function(win) {
  win.doOperation(halfThrow0);
  win.doOperation(pushLeft);
});
slate.bind('2:ctrl;cmd', function(win) {
  win.doOperation(halfThrow0);
  win.doOperation(pushRight);
});
slate.bind('3:ctrl;cmd', function(win) {
  win.doOperation(halfThrow1);
  win.doOperation(pushLeft);
});
slate.bind('4:ctrl;cmd', function(win) {
  win.doOperation(halfThrow1);
  win.doOperation(pushRight);
});
slate.bind('left:ctrl;cmd', function(win) {
  win.doOperation(throw0);
});
slate.bind('right:ctrl;cmd', function(win) {
  if (appOperations(win)) { return; }
  win.doOperation(throw1);
});
