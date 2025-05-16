import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../home.dart';
import '../blocs/get_info/get_info_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<InformationModel> offlineData = [];

  @override
  void initState() {
    super.initState();
    _loadOfflineData();
  }

  Future<void> _loadOfflineData() async {
    final box = await Hive.openBox('characterBox');
    final cachedList =
        box.values
            .map((e) => InformationModel.fromMap(Map<String, dynamic>.from(e)))
            .toList();
    setState(() {
      offlineData = cachedList;
    });
  }

  Future<bool> _hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasInternetConnection(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final hasInternet = snapshot.data!;
        if (!hasInternet && offlineData.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No internet and no cached data")),
          );
        }
        if (!hasInternet && offlineData.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Rick and Morty (Offline)'),
              backgroundColor: Colors.indigo.shade700,
              centerTitle: true,
              elevation: 4,
            ),
            backgroundColor: Colors.grey[100],
            body: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              itemCount: offlineData.length,
              itemBuilder: (context, index) {
                final character = offlineData[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailsScreen(character),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: CachedNetworkImageProvider(
                        character.image,
                      ),
                    ),
                    title: Text(
                      character.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Status: ${character.status}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create:
                  (context) => Dio(
                    BaseOptions(baseUrl: "https://rickandmortyapi.com/api"),
                  ),
            ),
            RepositoryProvider(
              create: (context) => HomeRemoteSource(client: context.read()),
            ),
            RepositoryProvider<HomeRepository>(
              create:
                  (context) => HomRepositoryImpl(
                    remote: context.read<HomeRemoteSource>(),
                  ),
            ),
            BlocProvider(
              create:
                  (context) =>
                      GetInfoBloc(repository: context.read())
                        ..add(GetInfoEventStart()),
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Rick and Morty'),
              backgroundColor: Colors.amber,
              centerTitle: true,
              elevation: 4,
            ),
            backgroundColor: Colors.grey[100],
            body: BlocBuilder<GetInfoBloc, GetInfoState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text("Initial state")),
                  inPrepare:
                      () => const Center(child: CircularProgressIndicator()),
                  failure:
                      (error) => Center(child: Text("Error: ${error.message}")),
                  success:
                      (characters) => ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        itemCount: characters.length,
                        itemBuilder: (context, index) {
                          final character = characters[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailsScreen(character),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: CachedNetworkImageProvider(
                                  character.image,
                                ),
                              ),
                              title: Text(
                                character.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                'Status: ${character.status}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
