const fs = require('fs');
const path = require("path");

const appName = process.argv[2];

const configiOS = () => {
  const iosRootPath = `${ __dirname }/../../ios/`;
  const plistPath = `${ appName }/Info.plist`;
  const filePath = path.join(iosRootPath, plistPath);

  fs.readFile(filePath, 'utf-8', (readErr, file) => {
    if (readErr) {
      console.error('readFile:', readErr);
      return;
    }

    const zhCNString = /<string>zh_CN<\/string>/;
    if (zhCNString.test(file)) {
      console.log('Localizations is added!');
      return;
    }

    const searchValue = /(\t<key>CFBundleInfoDictionaryVersion<\/key>\n\t<string>6.0<\/string>)(\s{2})/;
    const replaceValue = '$1 \n\t<key>CFBundleLocalizations<\/key>\n\t<array>\n\t\t<string>zh_CN<\/string>\n\t\t<string>zh_TW<\/string>\n\t\t<string>en<\/string>\n\t<\/array>\n\t';
    const result = file.replace(searchValue, replaceValue);
    fs.writeFile(filePath, result, 'utf-8', (writeErr) => {
      if (writeErr) {
        console.error('writeFile:', writeErr);
        return;
      }
      console.log(`🎉 🎉 🎉, CFBundleLocalizations configuration is successful 👍 👍 👍!`);
    });
  });
};

configiOS();
