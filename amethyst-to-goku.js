#!/usr/bin/env node
// convert ~/.amethyst json to goku keybind format so we can bind with a single key rather than multiple

const json = require("./amethyst.json");

const keybinds = { mod1: [], mod2: [] };

// map amethyst.json key to karabiner/goku key_code.
const symbols = {
  ",": "comma",
  ".": "period",
  enter: "return_or_enter",
  space: "spacebar",
  left: "left_arrow",
  right: "right_arrow"
};

for (const [name, kb] of Object.entries(json)) {
  if (!kb.mod || !kb.key) continue; // not a keybind.

  keybinds[kb.mod].push({ name, key: symbols[kb.key] || kb.key });
}

const toGoku = (binds, shortcut) =>
  binds
    .map(kb => `       [:${kb.key} [:${shortcut}${kb.key}]] ;; ${kb.name}`)
    .join("\n");

// remove x=>x mappings
const notSelf = (xs, not) => xs.filter(x => x.key !== not);

const mod1 = toGoku(notSelf(keybinds.mod1, "a"), "!OS");

const mod2 = toGoku(notSelf(keybinds.mod2, "s"), "!OST");

console.log(`
    {:des "amethyst mod1 mode"
      :rules [:amethyst-mod1-mode
${mod1}
     ]
    }`);

console.log(`
    {:des "amethyst mod2 mode"
      :rules [:amethyst-mod2-mode
${mod2}
     ]
    }`);
