import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/gradient_background.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = 'Aarav';
  String tone = 'light';
  String birthDate = '1995-05-19';
  String birthTime = '14:22';
  String birthPlace = 'Patna, IN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF7C3AED),
                  Color(0xFFD946EF),
                  Color(0xFF06B6D4),
                ],
              ).createShader(rect),
              child: const Icon(Icons.auto_awesome, color: Colors.white),
            ),
            const SizedBox(width: 8),
            const Text('Welcome'),
          ],
        ),
      ),
      body: SafeArea(
        child: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Text(
                    'Personalize your guidance',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'A few details help us align timing and tone for you.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    onSaved: (v) => name = v?.trim() ?? name,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: tone,
                    items: const [
                      DropdownMenuItem(
                          value: 'classic', child: Text('Classic Vedic')),
                      DropdownMenuItem(value: 'light', child: Text('Light')),
                    ],
                    onChanged: (v) => setState(() => tone = v ?? 'light'),
                    decoration: const InputDecoration(labelText: 'Tone'),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: birthDate,
                    decoration: const InputDecoration(
                        labelText: 'Birth date (yyyy-MM-dd)'),
                    onSaved: (v) => birthDate = v?.trim() ?? birthDate,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: birthTime,
                    decoration:
                        const InputDecoration(labelText: 'Birth time (HH:mm)'),
                    onSaved: (v) => birthTime = v?.trim() ?? birthTime,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: birthPlace,
                    decoration: const InputDecoration(labelText: 'Birth place'),
                    onSaved: (v) => birthPlace = v?.trim() ?? birthPlace,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {
                      _formKey.currentState?.save();
                      context.go('/home');
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
