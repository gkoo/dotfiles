/* globals slate */

// Push the window against an edge of the screen.
// @direction: the direction to push
// @width: desired window width represented as a fraction.
var push = function(direction, width) {
  var config = { direction: direction };

  config.style = 'bar-resize:screenSizeX*' + width;

  return slate.operation('push', config);
},

// Move the window to a desired screen.
// @screen: screen to move to. Defaults to screen 0.
// @width: desired window width represented as a fraction. Defaults to 1 (full-screen).
throww = function(screen, width) {
  var config = { screen: screen || '0' };

  width = width || '1';
  config.width = 'screenSizeX*' + width;

  return slate.operation('throw', config);
},

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

slate.bind('1:ctrl;cmd', function(win) {
  if (slate.screenCount > 1) {
    win.doOperation(throww('0', '1/2'));
  }
  win.doOperation(push('left', '1/2'));
});

slate.bind('2:ctrl;cmd', function(win) {
  if (slate.screenCount > 1) {
    win.doOperation(throww('0', '1/2'));
  }
  win.doOperation(push('right', '1/2'));
});

slate.bind('3:ctrl;cmd', function(win) {
  win.doOperation(throww('1', '1/2'));
  win.doOperation(push('left', '1/2'));
});

slate.bind('4:ctrl;cmd', function(win) {
  win.doOperation(throww('1', '1/2'));
  win.doOperation(push('right', '1/2'));
});

slate.bind('left:ctrl;cmd', function(win) {
  if (slate.screenCount > 1) {
    // Two-screen setup
    win.doOperation(throww('0'));
  }
  else {
    // Single-screen setup
    win.doOperation(push('left', '2/3'));
  }
});

slate.bind('right:ctrl;cmd', function(win) {
  if (appOperations(win)) {
    return;
  }
  else if (slate.screenCount > 1) {
    // Two-screen setup
    win.doOperation(throww('1'));
  }
  else {
    // Single-screen setup
    win.doOperation(push('right', '2/3'));
  }
});

slate.bind('up:ctrl;cmd', function(win) {
  // Only used for single-screen.
  win.doOperation(throww('0'));
});
