// ignore_for_file: use_build_context_synchronously

import 'package:explore_hive/core/models/item.dart';
import 'package:explore_hive/ui/home/providers/write_item_view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WriteItemSheet extends HookConsumerWidget {
  const WriteItemSheet({super.key,this.item});
  
  final Item? item;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = ref.watch(writeItemViewModelProvider);
    if(item != null){
      model.init(item!);
    }
    final formKey = useRef(GlobalKey<FormState>());
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Form(
          key: formKey.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${model.isEditing ? "Edit": "Create"} Item",
                style: style.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                "Title",
                style: style.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: model.item.title,
                onSaved: (value) => model.item.title = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
                decoration: const InputDecoration(),
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: style.titleMedium,
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: model.item.description,
                onSaved: (value) => model.item.description = value!,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              model.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : MaterialButton(
                      color: scheme.primaryContainer,
                      textColor: scheme.onPrimaryContainer,
                      onPressed: () async {
                        if (formKey.value.currentState!.validate()) {
                          formKey.value.currentState!.save();
                          try {
                            await model.write();
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Save"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
