import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  String apiMessage = "Checking API...";

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/images/splash-1.png"
    },
    {
      "text":
          "We help people conect with store \naround United State of America",
      "image": "assets/images/splash-2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash-3.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    checkAPI();
  }

  Future<void> checkAPI() async {
    try {
      String result = await ApiService.checkKelompok4();

      print(result);

      setState(() {
        apiMessage = result;
      });
    } catch (e) {
      print(e);

      setState(() {
        apiMessage = "API gagal terhubung";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      image: splashData[index]["image"],
                      text: splashData[index]["text"],
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

                      Text(
                        apiMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 25,
                      ),

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

  const SplashContent({
    super.key,
    this.text,
    this.image,
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
          text!, textAlign: TextAlign.center,
        ),

        const Spacer(flex: 2),

        Image.asset(
          image!, fit: BoxFit.contain,
          height: 265, width: 235),

      ],
    );
  }
}