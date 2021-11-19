# KWin TypeScript Template
A template for creating KWin scripts in typescript, because the official docs [here](https://develop.kde.org/docs/plasma/kwin/) and [here](https://develop.kde.org/docs/plasma/kwin/api/) aren't *quite* perfect.

It uses [my type declarations](https://github.com/RubixDev/kwin-types), that I created based mainly by looking through [KWin's source code](https://github.com/KDE/kwin) and the docs mentioned above.

## Usage
### Setup
#### Step 1
Clone the repo:
```bash
git clone https://github.com/RubixDev/kwin-typescript-template.git
```

#### Step 2
Edit the following things in the `package.json`
- `name`
- `displayName`
- `version`
- `description`
- `author`

and if you really want, also the `license`.

#### Step 3
Edit the `metadata.desktop` file. For convenience you can run `npm run update-metadata` to copy the the information from the `package.json` automatically. However you still have to edit these properties manually:
- `X-KDE-PluginInfo-Email`
- `X-KDE-PluginInfo-License`

#### Step 4
Run `npm i` to install the required dependencies.

#### Step 5
Write your script in the `contents/src/main.ts` file. You can also add more files and import them with the typical `import { stuff } from 'elsewhere'` syntax.

There are a few global properties and functions:
- Functions (refer to the JSDoc for more information)
  - `print()`
  - `readConfig()`
  - `callDBus()`
  - `registerShortcut()`
  - `registerScreenEdge()`
  - `unregisterScreenEdge()`
  - `registerTouchScreenEdge()`
  - `unregisterTouchScreenEdge()`
  - `registerUserActionsMenu()`
  - `assert()`
  - `assertTrue()`
  - `assertFalse()`
  - `assertNull()`
  - `assertNotNull()`
  - `assertEquals()`
- `workspace`: An instance of `KWin.QtScriptWorkspaceWrapper`
- `options`: An instance of `KWin.Options`
- `KWin`: has the following properties, that provide access to the properties of the `KWin.WorkspaceWrapper.ClientAreaOption` and `KWin.WorkspaceWrapper.ElectricBorder` enums:
  - `PlacementArea`
  - `MovementArea`
  - `MaximizeArea`
  - `MaximizeFullArea`
  - `FullScreenArea`
  - `WorkArea`
  - `FullArea`
  - `ScreenArea`
  - `ElectricTop`
  - `ElectricTopRight`
  - `ElectricRight`
  - `ElectricBottomRight`
  - `ElectricBottom`
  - `ElectricBottomLeft`
  - `ElectricLeft`
  - `ElectricTopLeft`
  - `ELECTRIC_COUNT`
  - `ElectricNone`
- `QTimer`: A class, for calling a function repeatedly with an interval, or just once with a delay.

Keep in mind async/await won't work. It seems like any call to `setTimeout()` or similar functions results in an internal error and cancels further execution of that scope.

### NPM Scripts
#### lint
Checks the source files for errors using `tsc`

#### compile
Compiles the TypeScript source files to a single `main.js` without checking for errors

#### package
Packages the compiled script to a single `.kwinscript` file. Use the `.pkgignore` file to specify files and folders of the root level to exclude

#### install
Installs the packaged script to your system

#### run
Enables the installed script and starts it. The output can be seen via `journalctl -f`

#### publish
Executes these scripts:
1. `lint`
2. `compile`
3. `package`

#### start
Executes these scripts:
1. `lint`
2. `compile`
3. `package`
4. `install`
5. `run`

#### uninstall
Fully stops and removes the installed script from your system

#### update-metadata
Copies following information from the `package.json` to the `metadata.desktop`
