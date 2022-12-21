import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menurestoran/cubit/resep_makanan_cubit.dart';
import 'package:menurestoran/screen/detail_resep_makanan_screen.dart';

class ResepMakananScreen extends StatefulWidget {
  const ResepMakananScreen({Key? key}) : super(key: key);

  @override
  State<ResepMakananScreen> createState() => _ResepMakananScreenState();
}

class _ResepMakananScreenState extends State<ResepMakananScreen> {
  // Tambahkan cubit->ResepMakananCubit di screen->ResepMakananScreen
  final ResepMakananCubit resepMakananCubit = ResepMakananCubit();

  // Tambahkan initState
  @override
  void initState() {
    // Panggil getDataResepMakanan yang ada di ResepMakananCubit
    resepMakananCubit.getDataResepMakanan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Center(child: Text('')),
            Text('Resep Makanan'),
          ],
        ),
      ),
      body: BlocBuilder<ResepMakananCubit, ResepMakananState>(
        bloc: resepMakananCubit,
        builder: (context, state) {
          if (state is ResepMakananInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: resepMakananCubit.resepMakananModel.results?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                          width: 160,
                          height: 60,
                          child: ClipRect(
                            child: Image.asset(
                              "images/resepmakanan.jpeg",
                            ),
                          ))),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailResepMakananScreen(
                            keyResepMakanan: resepMakananCubit
                                .resepMakananModel.results?[index].key!,
                            titleResepMakanan: resepMakananCubit
                                .resepMakananModel.results?[index].title!,
                            thumbResepMakanan: resepMakananCubit
                                .resepMakananModel.results?[index].thumb!,
                          );
                        },
                      ),
                    );
                  },
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  title: Text(
                    resepMakananCubit.resepMakananModel.results![index].title!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(resepMakananCubit
                            .resepMakananModel.results![index].serving!),
                        Text(resepMakananCubit
                            .resepMakananModel.results![index].times!),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
