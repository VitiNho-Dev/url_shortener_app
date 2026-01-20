import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener_app/app/home/controllers/home_controller.dart';
import 'package:url_shortener_app/app/home/controllers/home_state.dart';
import 'package:url_shortener_app/app/home/views/widgets/custom_text_field_widget.dart';
import 'package:url_shortener_app/app/home/views/widgets/custom_text_result_widget.dart';

import '../models/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get _controller => widget.controller;

  late final TextEditingController _textEditingController;
  String _urlShortener = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _controller.addListener(_getUrlShortener);
  }

  void _getUrlShortener() {
    final state = _controller.value;
    if (state is HomeSuccess) {
      setState(() {
        _urlShortener = state.urlShorteners.url;
      });
    }
  }

  void _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Texto copiado para a área de transferência!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _controller.removeListener(_getUrlShortener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            children: [
              SizedBox(height: 120),
              CustomTextFieldWidget(
                textEditingController: _textEditingController,
              ),
              CustomTextResultWidget(
                text: _urlShortener,
                onPressed: () => _copyToClipboard(_urlShortener),
              ),
              FilledButton(
                onPressed: () {
                  _controller.sendUrl(_textEditingController.text);
                },
                child: Text('Encurtar URL'),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
