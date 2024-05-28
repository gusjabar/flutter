import 'dart:io';

import 'package:favorite_places_app/providers/user_places.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                ImageInput(
                  onSelectedImage: (File image) {
                    _selectedImage = image;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Place'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
