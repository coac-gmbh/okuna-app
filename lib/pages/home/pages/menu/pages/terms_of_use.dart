import 'package:Okuna/services/httpie.dart';
import 'package:Okuna/widgets/markdown.dart';
import 'package:Okuna/widgets/nav_bars/themed_nav_bar.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/widgets/progress_indicator.dart';
import 'package:Okuna/widgets/theming/primary_color_container.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OBTermsOfUsePage extends StatefulWidget {
  @override
  OBTermsOfUsePageState createState() {
    return OBTermsOfUsePageState();
  }
}

class OBTermsOfUsePageState extends State {
  String _guidelinesText;
  bool _needsBootstrap;

  CancelableOperation _getGuidelinesOperation;

  @override
  void initState() {
    super.initState();
    _needsBootstrap = true;
    _guidelinesText = '';
  }

  @override
  void dispose() {
    super.dispose();
    if (_getGuidelinesOperation != null) _getGuidelinesOperation.cancel();
  }

  void _bootstrap() async {
    OpenbookProviderState openbookProvider = OpenbookProvider.of(context);
    _getGuidelinesOperation = CancelableOperation.fromFuture(
        openbookProvider.documentsService.getTermsOfUse());

    String guidelines = await _getGuidelinesOperation.value;
    _setGuidelinesText(guidelines);
  }

  @override
  Widget build(BuildContext context) {
    if (_needsBootstrap) {
      _bootstrap();
      _needsBootstrap = false;
    }

    return CupertinoPageScaffold(
      navigationBar: OBThemedNavigationBar(
        title: 'Terms of use',
      ),
      child: OBPrimaryColorContainer(
        child: Column(
          children: <Widget>[
            Container(),
            // TODO:
            // Expanded(
            //   child: _guidelinesText.isNotEmpty
            //       ? OBMarkdown(
            //           data: _guidelinesText,
            //         )
            //       : Padding(
            //           padding: const EdgeInsets.all(20),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [OBProgressIndicator()],
            //           ),
            //         ),
            // )
          ],
        ),
      ),
    );
  }

  void _setGuidelinesText(String guidelinesText) {
    setState(() {
      _guidelinesText = guidelinesText;
    });
  }
}
