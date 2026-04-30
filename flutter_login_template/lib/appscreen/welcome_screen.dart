import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/get_started/get_started_service.dart';
import '../services/get_started/get_started_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = true;
  late Future<GetStartedModel> _data;

  @override
  void initState() {
    super.initState();

    // ambil data API
    _data = GetStartedService().fetchData();

    // delay biar tetap ada efek loading 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<GetStartedModel>(
          future: _data,
          builder: (context, snapshot) {
            
            // 🔄 Loading
            if (_isLoading || snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            }

            // ❌ Error
            if (snapshot.hasError) {
              return ErrorInfo(
                title: "Error",
                description: "Gagal mengambil data dari server",
                press: () {},
              );
            }

            // ✅ Data dari API
            final data = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // 🖼️ Gambar dari API (fallback ke SVG kalau gagal)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        data.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return SvgPicture.string(
                            paymentProcessIllistration,
                            fit: BoxFit.scaleDown,
                          );
                        },
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // 📝 Title & Description dari API
                  ErrorInfo(
                    title: data.title,
                    description: data.description,
                    button: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: const Text("CONTINUE"),
                    ),
                    press: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: Text((btnText ?? "Retry").toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

const paymentProcessIllistration = '''
<svg width="1080" height="1080" viewBox="0 0 1080 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M590.84 242.27H877.06C880.922 242.27 884.625 243.804 887.355 246.535C890.086 249.265 891.62 252.968 891.62 256.83V543C891.62 546.862 890.086 550.565 887.355 553.295C884.625 556.026 880.922 557.56 877.06 557.56H805.37C744.62 557.56 686.358 533.431 643.397 490.479C600.435 447.527 576.293 389.27 576.28 328.52V256.83C576.28 252.968 577.814 249.265 580.545 246.535C583.275 243.804 586.978 242.27 590.84 242.27Z" fill="#E5E5E5"/>
</svg>
'''; 