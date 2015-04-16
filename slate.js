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
      width = '1/2';
      //width = getPartialWidthFraction(slate.screen().id());

  if (direction === 'left' || direction === 'right') {
    config.style = 'bar-resize:screenSizeX*' + width;
  }
  else {
    config.style = 'bar-resize:screenSizeY/2';
  }
  return slate.operation('push', config);
},

moveQuadrant = function(win, quadrant) {
  //win.doOperation(slate.operation('resize', config));
  var op;
  if (quadrant === 0) {
    op = slate.operation('move', {
      x: 'screenOriginX',
      y: 'screenOriginY',
      width: 'screenSizeX/2',
      height: 'screenSizeY/2'
    });
  }
  if (quadrant === 1) {
    op = slate.operation('move', {
      x: 'screenSizeX/2',
      y: 'screenOriginY',
      width: 'screenSizeX/2',
      height: 'screenSizeY/2'
    });
  }
  if (quadrant === 2) {
    op = slate.operation('move', {
      x: 'screenOriginX',
      y: 'screenSizeY/2',
      width: 'screenSizeX/2',
      height: 'screenSizeY/2'
    });
  }
  if (quadrant === 3) {
    op = slate.operation('move', {
      x: 'screenSizeX/2',
      y: 'screenSizeY/2',
      width: 'screenSizeX/2',
      height: 'screenSizeY/2'
    });
  }
  win.doOperation(op);
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

// Special-case windows
appOperations = function(win) {
  var appName = win.app().name();
  if (appName === 'Adium' || appName === 'Twitter') {
    win.doOperation(slate.operation('push', { 'direction': 'right' }));
    return true;
  }
  return false;
},

shouldntResize = function(win) {
  var appName = win.app().name();
  return appName === 'Adium' || appName === 'Twitter';
};

// 50% resizes
//slate.bind('1:ctrl;cmd', function(win) {
slate.bind('1:ctrl;cmd', function(win) {
  if (shouldntResize(win)) {
    return;
  }
  if (slate.screenCount() > 1) {
    win.doOperation(throww('0'));
  }
  win.doOperation(push('left'));
});

slate.bind('2:ctrl;cmd', function(win) {
  if (shouldntResize(win)) {
    return;
  }
  if (slate.screenCount() > 1) {
    win.doOperation(throww('0'));
  }
  win.doOperation(push('right'));
});

slate.bind('3:ctrl;cmd', function(win) {
  if (shouldntResize(win)) {
    return;
  }
  win.doOperation(throww('1'));
  win.doOperation(push('left'));
});

slate.bind('4:ctrl;cmd', function(win) {
  if (shouldntResize(win)) {
    return;
  }
  win.doOperation(throww('1'));
  win.doOperation(push('right'));
});

// 25% resizes
slate.bind('1:ctrl', function(win) {
  moveQuadrant(win, 0);
});
slate.bind('2:ctrl', function(win) {
  moveQuadrant(win, 1);
});
slate.bind('3:ctrl', function(win) {
  moveQuadrant(win, 2);
});
slate.bind('4:ctrl', function(win) {
  moveQuadrant(win, 3);
});

slate.bind('left:ctrl;cmd', function(win) {
  if (shouldntResize(win)) {
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
  else if (!shouldntResize(win)) {
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
  if (shouldntResize(win)) {
    return;
  }
  // Only used for single-screen.
  win.doOperation(throww('0', false));
});
