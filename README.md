# package-resolve

[issues]: https://github.com/CliffS/package-resolve

## Simple way to get the package.json for any installed package.

This finds the `package.json` for any package installed in `node_modules`
so that if can be accessed by the running server.

It can also find the `main` key and a `style` key as well as
returning the `package.json` as an object or the css as a
string.

This package uses native Promises throughout.

## Install

    npm install package-resolve

## Example

The example is based on having installed bootstrap.  It does
not need to have been `require`d.

```javascript
Pack = require('package-resolve');
pack = new Pack('bootstrap');

pack.package()
.then (file) =>
  // file contains the path of the package.json file
.catch (err) =>
  // err contains a descriptive error such as "File not found"

```

## Usage

### new

```javascript
Pack = require('package-resolve');
pack = new Pack(<package to find>);
```

This should be passed the name of the package to find as listed under
`dependencies` in our `package.json`.

### package

```javascript
pack.package()
.then (file) =>
  // file contains the path of the package.json file
.catch (err) =>
  // err contains a descriptive error such as "File not found"
```

This returns a Promise that resolves to the full path of the `package.json`
file for this dependency.

### resolve

```javascript
pack.resolve()
.then (file) =>
  // file contains the path of the `main` file in the package.json
.catch (err) =>
  console.error(err);
```

### style

```javascript
pack.style()
.then (file) =>
  // file contains the path of the file referred to in the style key
.catch (err) =>
  console.error(err);
```

### readPackage

```javascript
pack.readPackage()
.then (obj) =>
  // obj contains the contents of package.json as an object
.catch (err) =>
  console.error(err);
```

### readStyle

```javascript
pack.readPackage()
.then (css) =>
  // css contains the css as a string
.catch (err) =>
  console.error(err);
```

## Problems

Any issues or comments would be appreciated at [Github][issues]

Pull requests are welcome.
