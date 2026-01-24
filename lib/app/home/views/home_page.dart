import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener_app/app/home/controllers/home_controller.dart';
import 'package:url_shortener_app/app/home/controllers/home_state.dart';
import 'package:url_shortener_app/app/home/views/widgets/custom_text_field_widget.dart';
import 'package:url_shortener_app/app/home/views/widgets/list_url_shortners_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _controller.getAllShortenedUrl();
    _controller.addListener(_showError);
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

  void _showError() {
    final state = _controller.value;

    if (state is HomeFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error.toString()),
        ),
      );

      _controller.getAllShortenedUrl();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _controller.removeListener(_showError);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Encurtador de URL'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFieldWidget(
                textEditingController: _textEditingController,
              ),
              FilledButton(
                onPressed: () {
                  _controller.sendUrl(_textEditingController.text);
                  _textEditingController.clear();
                },
                child: Text('ENCURTAR'),
              ),
              SizedBox(height: 24),
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, state, _) => switch (state) {
                  HomeInitial() => SizedBox.shrink(),
                  HomeLoading() => Center(
                    child: CircularProgressIndicator(),
                  ),
                  HomeFailure() => SizedBox.shrink(),
                  HomeSuccess(model: final data) => ListUrlShortnersWidget(
                    data: data,
                    onCopyText: _copyToClipboard,
                    onDelete: (value) {
                      _controller.deleteShortenedUrl(value);
                    },
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
