const HYPER = ['ctrl', 'alt', 'cmd', 'shift'];
const pipe = (...fns) => (x) => fns.reduce((v, f) => f(v), x);

const HIST_LEN = 20;
const history = new Array(HIST_LEN);
history.add = v => { history.pop(); history.splice(0, 0, v) };

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

const hyper = (key, fn) => {
  Key.on(key, HYPER, () => {
    fn();
    console.log(JSON.stringify(history));
    return history.add(key);
  });
};

const repeats = (key) => {
  const h = history.join("");
  const start = new RegExp(`^(${key}*)`);
  const [, keys] = h.match(start);
  const repeats = keys.length;
  return repeats;
};
const thirds = n => {
  switch(n % 3) {
    case 0: return 2/3;
    case 1: return 1/2;
    case 2: return 1/3;
    default: return 1/2;
  }
};
const getThirds = pipe(repeats, thirds);

hyper('m', () => {
  const [last] = history;
  console.log(last);
  if (last === 'm') return move((window, screen) => ({
    x: screen.x,
    y: screen.y,
    w: screen.width,
    h: screen.height,
  }));

  return move((window, screen) => ({
    x: screen.x + (screen.width / 2) - (window.frame().width / 2),
    y: screen.y + (screen.height / 2) - (window.frame().height / 2),
  }));
});

hyper('h', () => {
  const mult = 1 - getThirds('h');

  move((window, screen) => ({
    x: screen.x,
    y: screen.y,
    w: screen.width * mult,
    h: screen.height,
  }));
});

hyper('l', () => {
  const mult = getThirds('l');

  move((window, screen) => ({
    x: screen.x + (mult * screen.width),
    y: screen.y,
    w: screen.width * (1-mult),
    h: screen.height,
  }));
});

hyper('j', () => {
  move((window, screen) => ({
    x: window.frame().x,
    y: screen.y + (screen.height / 2),
    w: window.width,
    h: screen.height / 2,
  }));
});

hyper('k', () => {
  move((window, screen) => ({
    x: window.frame().x,
    y: screen.y,
    w: window.width,
    h: screen.height / 2,
  }));
});
