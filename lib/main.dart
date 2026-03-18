import 'package:flutter/material.dart';

void main() {
  runApp(const MiAppProductos());
}

class MiAppProductos extends StatelessWidget {
  const MiAppProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita la banda roja de debug
      title: 'Catálogo Moderno',
      theme: ThemeData(
        useMaterial3: true, // Habilita el diseño moderno de Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const PantallaProductos(),
    );
  }
}

class PantallaProductos extends StatelessWidget {
  const PantallaProductos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> productos = [
      {
        'titulo': '1 - Leche',
        'subtitulo': 'Bebida blanca y opaca producida por las hembras de los mamíferos.',
        'imageUrl': 'https://raw.githubusercontent.com/LiraRodriguezMaximiliano/imagenes-para-flutter-6I-11-02-26/refs/heads/main/L1.png', 
      },
      {
        'titulo': '2 - Queso',
        'subtitulo': 'Alimento sólido obtenido por maduración de la cuajada de la leche.',
        'imageUrl': 'https://raw.githubusercontent.com/LiraRodriguezMaximiliano/imagenes-para-flutter-6I-11-02-26/refs/heads/main/Queso.png',
      },
      {
        'titulo': '3 - Mantequilla',
        'subtitulo': 'Emulsión grasa obtenida principalmente del batido de la crema de leche.',
        'imageUrl': 'https://raw.githubusercontent.com/LiraRodriguezMaximiliano/imagenes-para-flutter-6I-11-02-26/refs/heads/main/Mantequilla.png',
      },
      {
        'titulo': '4 - Yogurt',
        'subtitulo': 'Producto lácteo obtenido por la fermentación de la leche.',
        'imageUrl': 'https://raw.githubusercontent.com/LiraRodriguezMaximiliano/imagenes-para-flutter-6I-11-02-26/refs/heads/main/Yogurt.png',
      },
      {
        'titulo': '5 - Jamón',
        'subtitulo': 'Producto cárnico curado, generalmente de la pata trasera del cerdo.',
        'imageUrl': 'https://raw.githubusercontent.com/LiraRodriguezMaximiliano/imagenes-para-flutter-6I-11-02-26/refs/heads/main/Jamon.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100], // Fondo de pantalla gris claro para que resalten las tarjetas
      appBar: AppBar(
        title: const Text(
          'Maximiliano Lira 6 I',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700], // Azul sólido y profesional
        elevation: 2,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return TarjetaProducto(
            titulo: producto['titulo']!,
            subtitulo: producto['subtitulo']!,
            imageUrl: producto['imageUrl']!,
          );
        },
      ),
    );
  }
}

class TarjetaProducto extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final String imageUrl;

  const TarjetaProducto({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        // MODIFICACIÓN PRINCIPAL AQUÍ:
        // Aumentamos la elevación (blurRadius y spreadRadius) y definimos más la sombra.
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12), // Sombra un poco más oscura y visible
            blurRadius: 16.0, // Más difuminada y extensa
            spreadRadius: 2.0, // Más amplia desde el centro
            offset: const Offset(0, 8), // Desplazamiento hacia abajo para dar altura
          ),
          // Opcional: Una segunda sombra interna muy sutil para dar más definición
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 2.0,
            offset: const Offset(0, -1), // Pequeña sombra interna hacia arriba
          ),
        ],
        // Opcional: Un borde muy fino para delimitar aún más
        // border: Border.all(color: Colors.grey[200]!, width: 1.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: IntrinsicHeight( // Ajusta el tamaño de la fila al contenido
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen a la izquierda
              SizedBox(
                width: 100,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => 
                      Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey)),
                ),
              ),
              // Contenido a la derecha
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        subtitulo,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    // Puedes añadir aquí un icono de carrito o similar
                    // children: [ ... , Icon(Icons.add_shopping_cart, color: Colors.blueAccent) ]
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