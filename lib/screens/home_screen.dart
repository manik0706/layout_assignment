import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../providers/ui_provider.dart';
import '../widgets/stats_card.dart';
import '../widgets/input_section.dart';
import '../widgets/instructions_card.dart';
import '../widgets/box_layout.dart';
import '../widgets/reset_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Box Layout'),
        actions: [
          Consumer<UIProvider>(
            builder: (context, uiProvider, child) {
              return IconButton(
                icon: Icon(uiProvider.showStats ? Icons.visibility_off : Icons.visibility),
                onPressed: uiProvider.toggleStats,
              );
            },
          ),
          Consumer<UIProvider>(
            builder: (context, uiProvider, child) {
              return IconButton(
                icon: Icon(uiProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: uiProvider.toggleDarkMode,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context.watch<UIProvider>().isDarkMode
                ? [Colors.grey[900]!, Colors.grey[800]!]
                : [Colors.deepPurple[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats Card
                        Consumer<UIProvider>(
                          builder: (context, uiProvider, child) {
                            if (uiProvider.showStats) {
                              return Column(
                                children: [
                                  StatsCard(),
                                  SizedBox(height: 16),
                                ],
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                        
                        // Input Section
                        InputSection(),
                        SizedBox(height: 16),

                        // Instructions
                        Consumer<GameProvider>(
                          builder: (context, gameProvider, child) {
                            if (gameProvider.hasBoxes) {
                              return Column(
                                children: [
                                  InstructionsCard(),
                                  SizedBox(height: 16),
                                ],
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),

                        // Box Layout
                        Consumer<GameProvider>(
                          builder: (context, gameProvider, child) {
                            if (gameProvider.hasBoxes) {
                              return Column(
                                children: [
                                  Flexible(
                                    child: BoxLayout(screenWidth: constraints.maxWidth),
                                  ),
                                  SizedBox(height: 20),
                                  ResetButton(),
                                  SizedBox(height: 20),
                                ],
                              );
                            }
                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
