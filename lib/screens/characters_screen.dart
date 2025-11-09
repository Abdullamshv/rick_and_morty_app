import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/character_controller.dart';
import '../widgets/character_card.dart';
import '../widgets/loading_indicator.dart';
import '../theme/app_theme.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final CharacterController controller = Get.find<CharacterController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !controller.isLoading.value &&
        controller.hasNextPage.value) {
      controller.loadMoreCharacters();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Characters'),
        actions: [
          IconButton(
            icon: Icon(
              AppTheme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              AppTheme.toggleTheme();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.characters.isEmpty) {
          return const LoadingIndicator(message: 'Loading characters...');
        }

        if (controller.error.value.isNotEmpty &&
            controller.characters.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: ${controller.error.value}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshCharacters(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.characters.isEmpty) {
          return const Center(child: Text('No characters found'));
        }

        final characters = controller.characters;
        final hasNextPage = controller.hasNextPage.value;

        return RefreshIndicator(
          onRefresh: () async {
            controller.refreshCharacters();
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: characters.length + (hasNextPage ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == characters.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return CharacterCard(character: characters[index]);
            },
          ),
        );
      }),
    );
  }
}
