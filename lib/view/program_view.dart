import 'package:flutter/material.dart';
import 'package:innerbhakti/utils/app_color.dart';
import 'package:innerbhakti/utils/app_constants.dart';
import 'package:innerbhakti/widgets/circle_icon.dart';
import 'package:provider/provider.dart';
import 'package:innerbhakti/controller/program_controller.dart';
import 'package:innerbhakti/view/detail_view.dart';

class ProgramListScreen extends StatelessWidget {
  const ProgramListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProgramController>(context, listen: false).fetchPrograms();
    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 181, 135),
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // InnerBhakti Logo
                        Row(
                          children: [
                            Image.asset(
                              ImagePath
                                  .appLogo,
                              height: 28,
                              width: 28,
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              'InnerBhakti',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            buildCircleIcon(Icons.refresh, () {
                              Provider.of<ProgramController>(context,
                                      listen: false)
                                  .fetchPrograms();
                            }),
                            const SizedBox(width: 16),
                            buildCircleIcon(Icons.add, () {}),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    const Text(
                      'Prarthana Plans',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              
              Expanded(
                child: Consumer<ProgramController>(
                  builder: (context, controller, child) {
                    if (controller.isLoading) {
                     
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.programs.isEmpty) {
                 
                      return const Center(
                        child: Text(
                          'No programs available at the moment.',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.programs.length,
                        itemBuilder: (context, index) {
                          final program = controller.programs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsView(programId: program.id!),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: program.image.isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(program.image),
                                            fit: BoxFit.cover,
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                ImagePath.placeholder),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                         
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                         
                                Positioned(
                                  bottom: 16.0,
                                  left: 16.0,
                                  right: 16.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        program.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      const Text(
                                        '20 Days Plan',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: Container(
                                    padding: const EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          137, 101, 101, 101),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
