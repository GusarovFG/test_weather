import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_weather/presentation/map_screen/map_bloc/map_bloc.dart';

class AddMarkerDialog extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController snippetController;
  final LatLng argument;

  const AddMarkerDialog(
      {super.key,
      required this.titleController,
      required this.snippetController,
      required this.argument});

  @override
  Widget build(BuildContext context) {
    final mapBloc = MapBloc();
    return BlocListener<MapBloc, MapBlocState>(
      bloc: mapBloc,
      listener: (context, state) {
        if (state.runtimeType == MapMarkAddingSuccess) {
          Navigator.pop(context);
        }
      },
      child: SimpleDialog(
        contentPadding: const EdgeInsets.all(15),
        title: const Text('Заполните информацию о месте'),
        children: [
          Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text(
                    'Название',
                    style: TextStyle(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: snippetController,
                decoration: const InputDecoration(
                  label: Text(
                    'Описание',
                    style: TextStyle(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        mapBloc.add(AddMarkerEvent(
                            titleController.text,
                            snippetController.text,
                            argument.latitude,
                            argument.longitude));
                      },
                      child: const Text('Сохранить'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Отмена'),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
