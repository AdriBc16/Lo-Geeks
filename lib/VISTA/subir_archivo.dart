import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SubirArchivo extends StatefulWidget {
  const SubirArchivo({super.key});

  @override
  State<SubirArchivo> createState() => _SubirArchivoState();
}

class _SubirArchivoState extends State<SubirArchivo> {
  String? _fileName;
  PlatformFile? _pickedFile;
  bool _isUploading = false;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _pickedFile = result.files.first;
          _fileName = _pickedFile!.name;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar archivo: $e')),
      );
    }
  }

  void _uploadFile() {
    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona un archivo primero')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    // Simular proceso de subida
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo $_fileName subido exitosamente')),
      );

      // Opcional: resetear la selección después de subir
      setState(() {
        _fileName = null;
        _pickedFile = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subir Archivo',
          style: TextStyle(color: Color(0xFF97A5EC)),
        ),
        backgroundColor: const Color(0xFF141F25),
        iconTheme: const IconThemeData(color: Color(0xFF97A5EC)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Fondo
          Container(
            color: const Color(0xFF141F25),
            width: double.infinity,
            height: double.infinity,
          ),

          // Patrón de fondo
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icono principal
                Icon(
                  Icons.cloud_upload,
                  size: 80,
                  color: Color(0xFF97A5EC),
                ),
                const SizedBox(height: 30),

                // Título
                const Text(
                  "Subir Archivo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Descripción
                const Text(
                  "Selecciona un archivo desde tu dispositivo para subirlo a la nube",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                // Botón para seleccionar archivo
                ElevatedButton(
                  onPressed: _pickFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEFB9C8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Seleccionar Archivo",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Información del archivo seleccionado
                if (_fileName != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B252D),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file, color: Colors.white),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _fileName!,
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 30),

                // Botón para subir archivo
                ElevatedButton(
                  onPressed: _isUploading ? null : _uploadFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5C8D),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: _isUploading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Subir Archivo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}