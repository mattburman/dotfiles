const HYPER = ['ctrl', 'alt', 'cmd', 'shift'];

const move = (getCoords) => {
  var screen = Screen.main().flippedVisibleFrame();
  var window = Window.focused();

  if (window) {
    const {
      x = screen.x,
      y = screen.y,
      w = window.frame().width,
      h = window.frame().height,
    } = getCoords(window, screen);
    window.setTopLeft({ x, y });
    window.setSize({ width: w, height: h });
  }
};

Key.on('m', HYPER, () => {
  move((window, screen) => ({
    x: screen.x + (screen.width / 2) - (window.frame().width / 2),
    y: screen.y + (screen.height / 2) - (window.frame().height / 2),
  }));
});

Key.on('h', HYPER, () => {
  move((window, screen) => ({
    x: screen.x,
    y: screen.y,
    w: screen.width / 2,
    h: screen.height,
  }));
});

Key.on('l', HYPER, () => {
  move((window, screen) => ({
    x: screen.x + screen.width / 2,
    y: screen.y,
    w: screen.width / 2,
    h: screen.height,
  }));
});

Key.on('j', HYPER, () => {
  move((window, screen) => ({
    x: window.frame().x,
    y: screen.y + (screen.height / 2),
    w: window.width,
    h: screen.height / 2,
  }));
});

Key.on('k', HYPER, () => {
  move((window, screen) => ({
    x: window.frame().x,
    y: screen.y,
    w: window.width,
    h: screen.height / 2,
  }));
});
