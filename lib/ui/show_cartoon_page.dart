import 'package:flutter/material.dart';
import 'package:rickyshit/model/btn_cartoon_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowCartoonPage extends StatefulWidget {
  final BtnCartoonModel btnCartoonModel;
  const ShowCartoonPage({super.key, required this.btnCartoonModel});

  @override
  State<ShowCartoonPage> createState() => _ShowCartoonPageState();
}

class _ShowCartoonPageState extends State<ShowCartoonPage> {
  Future<void> _launchURL() async {
    final Uri url = Uri.parse(widget.btnCartoonModel.url);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load URL ${widget.btnCartoonModel.url}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Cartoon Details'),
        backgroundColor: const Color.fromARGB(255, 10, 119, 13),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.btnCartoonModel.image, height: 200),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _launchURL,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Opeb Cartoon Resource'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
