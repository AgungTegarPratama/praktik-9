import 'package:flutter/material.dart';
import '../services/splash/splash_service.dart';
import '../services/splash/splash_model.dart';
import '../services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  List<SplashModel> splashData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSplashData();
  }

  Future<void> loadSplashData() async {
    try {
      final data = await SplashService.fetchSplashData();

      setState(() {
        splashData = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [

              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: splashData.length,

                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },

                  itemBuilder: (context, index) {
                    return SplashContent(
                      image: splashData[index].imageUrl,
                      text: splashData[index].title,
                      desc: splashData[index].description,
                    );
                  },
                ),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? const Color(0xFFFF7643)
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFFF7643),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)),
                          ),
                        ),
                        child: const Text("Continue"),
                      ),

                      const Spacer(),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String? text;
  final String? image;
  final String? desc;

  const SplashContent({
    super.key,
    this.text,
    this.image,
    this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const Spacer(),

        const Text(
          "TOKOTO",
          style: TextStyle(
            fontSize: 32,
            color: Color(0xFFFF7643),
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          text ?? '',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        Text(
          desc ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),

        const Spacer(flex: 2),

        Image.network(
          image ?? '',
          height: 265,
          width: 235,
          fit: BoxFit.contain,
        ),

      ],
    );
  }
} 