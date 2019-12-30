const HYPER = ['ctrl', 'alt', 'cmd', 'shift'];
const pipe = (...fns) => (x) => fns.reduce((v, f) => f(v), x);
const areNumbers = ns => !ns.some(Number.isNaN);

const HIST_LEN = 20;
const history = new Array(HIST_LEN);
history.add = v => { history.pop(); history.splice(0, 0, v) };

const move = (getCoords) => {
  const screen = Screen.main();
  const screenFrame = screen.flippedVisibleFrame();
  const window = Window.focused();

  if (window) {
    const windowFrame = window.frame();
    const {
      x,
      y,
      w,
      h,
    } = getCoords({ window, screenFrame, screen, windowFrame });

    if (!areNumbers([x, y, w, h])) return console.log('not numbers', {x, y, w, h});

    window.setFrame({
      x,
      y,
      width: w,
      height: h,
    });
  }
};

const mod1 = (key, fn) => {
  Key.on(key, HYPER, () => {
    fn();
    return history.add(key);
  });
};

const useRepeats = (key) => {
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
const useThirds = pipe(useRepeats, thirds);
const useToggle = pipe(useRepeats, n => !!(n%2));

const scale = (windowFrame, screenFrame, nextScreenFrame) => {
  const xProp = windowFrame.width / screenFrame.width;
  const yProp = windowFrame.height / screenFrame.height;

  // proportions of screen start to window start of the window lengths
  const xStartProp = (windowFrame.x - screenFrame.x) / screenFrame.width;
  const yStartProp = (windowFrame.y - screenFrame.y) / screenFrame.height;

  const x = nextScreenFrame.x + nextScreenFrame.width*xStartProp;
  const y = nextScreenFrame.y + nextScreenFrame.height*yStartProp;

  return {
    w: xProp * nextScreenFrame.width,
    h: yProp * nextScreenFrame.height,
    x,
    y,
  };
};

// v-center to maximise
mod1('m', () => {
  const repeats = useRepeats('m');

  if (repeats === 0) {
    // move to middle third
    return move(({ screenFrame, windowFrame }) => ({
      x: screenFrame.x + (screenFrame.width * 1/3),
      y: windowFrame.y,
      w: screenFrame.width * (1/3),
      h: windowFrame.height,
    }));
  }

  const toggle = repeats % 2 === 1;

  // v-maximise
  if (toggle) return move(({ screenFrame }) => ({
    x: screenFrame.x + (screenFrame.width * 1/3),
    y: screenFrame.y,
    w: screenFrame.width * (1/3),
    h: screenFrame.height,
  }));

  // maximise
  return move(({ screenFrame }) => ({
    x: screenFrame.x,
    y: screenFrame.y,
    w: screenFrame.width,
    h: screenFrame.height,
  }));
});

mod1('b', () => {
  move(({ screenFrame, screen, windowFrame }) => scale(
    windowFrame,
    screenFrame,
    screen.previous().flippedVisibleFrame(),
  ));
});

mod1('e', () => {
  move(({ screenFrame, screen, windowFrame }) => scale(
    windowFrame,
    screenFrame,
    screen.next().flippedVisibleFrame(),
  ));
});


mod1('h', () => {
  const mult = 1 - useThirds('h');

  move(({ screenFrame }) => ({
    x: screenFrame.x,
    y: screenFrame.y,
    w: screenFrame.width * mult,
    h: screenFrame.height,
  }));
});

mod1('l', () => {
  const mult = useThirds('l');

  move(({ screenFrame }) => ({
    x: screenFrame.x + (mult * screenFrame.width),
    y: screenFrame.y,
    w: screenFrame.width * (1-mult),
    h: screenFrame.height,
  }));
});

mod1('j', () => {
  const mult = 0.5;

  move(({ screenFrame, windowFrame }) => ({
    x: windowFrame.x,
    y: screenFrame.y + (mult * screenFrame.height),
    w: windowFrame.width,
    h: screenFrame.height * mult,
  }));
});

mod1('k', () => {
  const mult = 0.5;

  move(({ screenFrame, windowFrame }) => ({
    x: windowFrame.x,
    y: screenFrame.y,
    w: windowFrame.width,
    h: screenFrame.height * mult,
  }));
});
