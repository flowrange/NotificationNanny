# NotificationNanny

## 🇫🇷 Français

Fork de [NotificationNanny](https://github.com/chessper53/NotificationNanny)
corrigeant la fermeture des notifications sur macOS en français. Consultez le
projet d’origine pour les fonctionnalités et l’utilisation.

L’application cherchait `Close` et `Clear All`, mais macOS renvoie `Fermer` et
`Tout effacer` en français : les notifications fermées pouvaient réapparaître.
Le correctif utilise les traductions du système pour les supprimer réellement,
y compris dans le Centre de notifications. Vérifié en français ; l’anglais reste
pris en charge.

### Compilation

Sur macOS, avec l’[environnement de compilation requis](docs/ARCHITECTURE.md)
(Xcode recommandé) :

```sh
git clone https://github.com/flowrange/NotificationNanny.git
cd NotificationNanny
./scripts/build-app.sh
```

Lancez `build/NotificationNanny.app` et accordez l’accès Accessibilité.
Cette autorisation peut devoir être renouvelée après remplacement de l’app.
Tests : `./scripts/test.sh`.

Pas de version précompilée pour ce fork. Les versions officielles et Homebrew
n’incluent pas ce correctif ; une mise à jour officielle peut le remplacer.

### Crédits

- [chessper53](https://github.com/chessper53) et les
  [contributeurs du projet d’origine](https://github.com/chessper53/NotificationNanny/graphs/contributors) : application d’origine.
- [flowrange](https://github.com/flowrange) : fork et validation sur macOS en français.
- [Codex](https://github.com/openai/codex), assistant d’OpenAI : diagnostic, correctif et tests.

Licence [MIT](LICENSE).

---

## 🇬🇧 English

A fork of [NotificationNanny](https://github.com/chessper53/NotificationNanny)
that fixes notification dismissal on French-language macOS. See the original
project for features and usage instructions.

The app looked for `Close` and `Clear All`, but French macOS returns `Fermer`
and `Tout effacer`, so dismissed notifications could reappear. This fix uses
the system’s translations to remove them from both the screen and Notification
Center. Verified in French; English remains supported.

### Build

On macOS, with the [required build environment](docs/ARCHITECTURE.md)
(Xcode recommended):

```sh
git clone https://github.com/flowrange/NotificationNanny.git
cd NotificationNanny
./scripts/build-app.sh
```

Launch `build/NotificationNanny.app` and grant Accessibility access.
You may need to renew this permission after replacing the app.
Tests: `./scripts/test.sh`.

No prebuilt release is available for this fork. Official and Homebrew builds
do not include this fix; an official update may overwrite it.

### Credits

- [chessper53](https://github.com/chessper53) and the
  [upstream contributors](https://github.com/chessper53/NotificationNanny/graphs/contributors): original application.
- [flowrange](https://github.com/flowrange): fork and validation on French macOS.
- [Codex](https://github.com/openai/codex), OpenAI’s coding assistant: diagnosis, fix, and tests.

[MIT License](LICENSE).
