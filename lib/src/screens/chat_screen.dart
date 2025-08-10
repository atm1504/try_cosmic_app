import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final List<_Message> messages = [];

  void _send(String text) {
    setState(() {
      messages.add(_Message(role: 'user', text: text));
      messages.add(_Message(
        role: 'assistant',
        text:
            'Hear you → That’s tough. Normalize → Anyone would feel wobbly. Plan → One small step: draft a boundary. Right‑time → 2:20–3:00 is clear of Rahu. Why → Moon waxing, Mercury hour.',
      ));
    });
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      bottomNavigationBar: const BottomNav(current: 3),
      body: Column(
        children: [
          Wrap(
            spacing: 8,
            children: [
              _quick('Timing'),
              _quick('Boundaries'),
              _quick('Sleep'),
              _quick('Courage'),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final m = messages[i];
                final isUser = m.role == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(m.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(hintText: 'Ask anything…'),
                    onSubmitted: (v) => _send(v),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _send(controller.text),
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _quick(String text) {
    return ActionChip(label: Text(text), onPressed: () => _send(text));
  }
}

class _Message {
  _Message({required this.role, required this.text});
  final String role;
  final String text;
}
