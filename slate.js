/* globals slate */

// When resizing a window to take up a part of the screen,
// determine whether to resize to half-screen (for larger monitors)
// or 2/3 screen (for smaller laptop display).
var getPartialWidthFraction = function(screenId) {
  var screen = slate.screenForRef(screenId);
  return (screen.rect().width > 1500) ? '1/2' : '2/3';
},

// Push the window against an edge of the screen.
// @direction: the direction to push
// @width: desired window width represented as a fraction.
push = function(direction) {
  var config = { direction: direction },
      width = getPartialWidthFraction(slate.screen().id());

  config.style = 'bar-resize:screenSizeX*' + width;
  return slate.operation('push', config);
},

// Move the window to a desired screen.
// @screen: screen to move to.
// @isPartial: boolean flag indicating whether the window should be full-screen. Defaults to true.
throww = function(screenId, isPartial) {
  var config = {
    screen: screenId,
    height: 'screenSizeY'
  },
  width;

  isPartial = (isPartial === undefined) ? true : isPartial;
  width = isPartial ? getPartialWidthFraction(screenId) : '1';

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
},

isAdium = function(win) {
  return win.app().name() === 'Adium';
};

slate.bind('1:ctrl;cmd', function(win) {
  if (isAdium(win)) {
    return;
  }
  if (slate.screenCount() > 1) {
    win.doOperation(throww('0'));
  }
  win.doOperation(push('left'));
});

slate.bind('2:ctrl;cmd', function(win) {
  if (isAdium(win)) {
    return;
  }
  if (slate.screenCount() > 1) {
    win.doOperation(throww('0'));
  }
  win.doOperation(push('right'));
});

slate.bind('3:ctrl;cmd', function(win) {
  if (isAdium(win)) {
    return;
  }
  win.doOperation(throww('1'));
  win.doOperation(push('left'));
});

slate.bind('4:ctrl;cmd', function(win) {
  if (isAdium(win)) {
    return;
  }
  win.doOperation(throww('1'));
  win.doOperation(push('right'));
});

slate.bind('left:ctrl;cmd', function(win) {
  if (isAdium(win)) {
    return;
  }
  if (slate.screenCount() > 1) {
    // Two-screen setup
    win.doOperation(throww('0', false));
  }
  else {
    // Single-screen setup
    win.doOperation(push('left'));
  }
});

slate.bind('right:ctrl;cmd', function(win) {
  if (appOperations(win)) {
    return;
  }
  else if (!isAdium(win)) {
    if (slate.screenCount() > 1) {
      // Two-screen setup
      win.doOperation(throww('1', false));
    }
    else {
      // Single-screen setup
      win.doOperation(push('right'));
    }
  }
});

slate.bind('up:ctrl;cmd', function(win) {
  if (isAdium(win)) {
    return;
  }
  // Only used for single-screen.
  win.doOperation(throww('0', false));
});
