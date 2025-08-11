import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      fromUser: false,
      text: 'Hi! Ask anything: timing advice or a supportive step.',
    )
  ];
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(fromUser: true, text: text));
      _messages.add(_fakeAstroReply(text));
      _controller.clear();
    });
  }

  _ChatMessage _fakeAstroReply(String text) {
    if (text.toLowerCase().contains('manager')) {
      return _ChatMessage(
        fromUser: false,
        text:
            'I hear you. A small step: outline 3 talking points. Right-time: Tue 2:20–3:00 PM — Guru hora, waxing Moon. Why? supportive for clear conversations.',
      );
    }
    if (text.toLowerCase().contains('breakup')) {
      return const _ChatMessage(
        fromUser: false,
        text:
            'That sounds heavy. Gentle plan: evening gratitude journal in Venus hora. I\'ve added a reminder in Plan.',
      );
    }
    if (text.toLowerCase().contains('moon')) {
      return const _ChatMessage(
        fromUser: false,
        text:
            'Today the Moon favors clarity and soft reflection. Tip: 2-min breath before key tasks.',
      );
    }
    return const _ChatMessage(
      fromUser: false,
      text:
          'I\'m here. Ask about timing for a task or how to support your mood today.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('Chat', style: Theme.of(context).textTheme.headlineSmall),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                  tooltip: 'Why? explanations',
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                return Align(
                  alignment:
                      m.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: m.fromUser
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
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Ask: timing, support, or your Moon today',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                      onPressed: _handleSend, child: const Text('Send')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final bool fromUser;
  final String text;
  const _ChatMessage({required this.fromUser, required this.text});
}
