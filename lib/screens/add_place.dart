import 'dart:io';

import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/user_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  File? _selectedImage;
  PlaceLocation? _selectedLocation;


  void _savePlace() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(_selectedImage==null||_selectedLocation==null){
        return;
      }
      ref.read(userPlacesProvider.notifier).addPlace(_enteredTitle,_selectedImage!,_selectedLocation!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return 'Must be between 1 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredTitle = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ImageInput(onPickImage: (image){
                  _selectedImage=image;
                },),
                const SizedBox(height: 10,),
                LocationInput(onSelectLocation: (location){
                  _selectedLocation=location;
                },),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: _savePlace,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Add Place'),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
