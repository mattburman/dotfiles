# to be run manually, for now

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-binstall
cargo binstall cargo-watch
cargo binstall cargo-nextest --secure
