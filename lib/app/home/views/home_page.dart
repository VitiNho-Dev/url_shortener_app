import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_shortener_app/app/home/controllers/home_controller.dart';
import 'package:url_shortener_app/app/home/controllers/home_state.dart';
import 'package:url_shortener_app/app/home/views/widgets/custom_text_field_widget.dart';
import 'package:url_shortener_app/app/home/views/widgets/custom_text_result_widget.dart';
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
    _controller.getHistoricUrl();
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
                  HomeFailure() => Center(
                    child: Text(
                      'Não foi possível carregar o histórico de urls encurtada!',
                    ),
                  ),
                  HomeSuccess(:final data) => ListUrlShortnersWidget(
                    data: data,
                    onPressed: _copyToClipboard,
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
