# NotificationNanny — flowrange fork

This is [flowrange's fork](https://github.com/flowrange/NotificationNanny) of
[chessper53/NotificationNanny](https://github.com/chessper53/NotificationNanny),
with a fix for dismissing notifications on **French-language macOS**.

## What this fork changes

Upstream's notification dismissal code matches the English accessibility action
names `Close` and `Clear All`. On French macOS, Notification Center exposes
`Fermer` and `Tout effacer` instead. The custom toast could disappear while its
native notification stayed behind, causing old notifications to reappear later.

This fork:

- Resolves close actions using Notification Center's own translations and passes
  the exact accessibility action token back to macOS. English actions remain
  supported; the same lookup also recognizes translations installed by macOS.
- Remembers a dismissed custom toast even if the native close attempt fails, so
  a later refresh does not recreate it while the same native banner remains.
- Includes regression tests for French and English action names, unrelated
  actions, and dismissed-toast bookkeeping.

The close-action fix was verified on French macOS: the test notification was
removed from both the screen and Notification Center's delivered-notification
history. It depends on Notification Center's internal localization resources,
which Apple can change in a macOS update.

## Build this fork

```sh
git clone https://github.com/flowrange/NotificationNanny.git
cd NotificationNanny
./scripts/build-app.sh
```

The resulting app is `build/NotificationNanny.app`. Use macOS and the build setup
described in [the architecture guide](docs/ARCHITECTURE.md), which recommends full
Xcode; Command Line Tools compatibility depends on the SDK and compiler version.
Launch the app and grant Accessibility access when requested. Replacing an
existing build requires renewing that permission.

Run the regression tests with `./scripts/test.sh`.

There is no binary release of this fork yet. Upstream downloads and Homebrew
packages do not include this fork's patch. An upstream update can replace a
locally installed patched build.

For general features, screenshots, usage instructions, and upstream releases,
see the [original NotificationNanny project](https://github.com/chessper53/NotificationNanny).

## Contributors

- [chessper53](https://github.com/chessper53) and the
  [upstream contributors](https://github.com/chessper53/NotificationNanny/graphs/contributors)
  — original application and ongoing upstream development.
- [flowrange](https://github.com/flowrange) — fork maintenance, bug reproduction,
  and validation on French macOS.
- [Codex](https://github.com/openai/codex), OpenAI's AI coding assistant —
  diagnosis, implementation, regression tests, and fork documentation.

## License

Released under the [MIT License](LICENSE).
