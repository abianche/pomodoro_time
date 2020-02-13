import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class VersionTile extends StatelessWidget {
  const VersionTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(
        child: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, packageInfo) {
            if (packageInfo == null ||
                !packageInfo.hasData ||
                packageInfo.hasError) {
              return Text(
                '© Alessio Bianchetti',
                textScaleFactor: 0.8,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              );
            }

            PackageInfo data = packageInfo.data;

            return GestureDetector(
              child: Text(
                'Version ${data.version}-${data.buildNumber} © Alessio Bianchetti',
                textScaleFactor: 0.8,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: FlutterLogo(size: 32.0),
                  applicationVersion: '${data.version}-${data.buildNumber}',
                  applicationName: "Pomodoro Time",
                  applicationLegalese: "© Alessio Bianchetti",
                );
              },
            );
          },
        ),
      ),
    );
  }
}
