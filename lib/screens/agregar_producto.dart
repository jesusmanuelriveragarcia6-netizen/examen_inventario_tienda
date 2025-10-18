import 'package:flutter/material.dart';
import '../models/producto.dart';

class AgregarProductoPage extends StatefulWidget {
  const AgregarProductoPage({super.key});

  @override
  State<AgregarProductoPage> createState() => _AgregarProductoPageState();
}

class _AgregarProductoPageState extends State<AgregarProductoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _proveedorController = TextEditingController();
  final TextEditingController _codigoBarrasController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  void _guardarProducto() {
    if (_formKey.currentState!.validate()) {
      final nuevoProducto = Producto(
        id: DateTime.now().millisecondsSinceEpoch,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        categoria: _categoriaController.text,
        proveedor: _proveedorController.text,
        codigoBarras: _codigoBarrasController.text,
        precio: double.tryParse(_precioController.text) ?? 0.0,
        stock: int.tryParse(_stockController.text) ?? 0,
      );

      Navigator.pop(context, nuevoProducto);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('Agregar Producto'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade700,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shadowColor: Colors.black26,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Complete los datos del producto',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 20),
                  _campoTexto('Nombre', _nombreController, Icons.label),
                  _campoTexto('Descripción', _descripcionController, Icons.text_fields),
                  _campoTexto('Categoría', _categoriaController, Icons.category),
                  _campoTexto('Proveedor', _proveedorController, Icons.store),
                  _campoTexto('Código de Barras', _codigoBarrasController, Icons.qr_code),
                  _campoTexto('Precio', _precioController, Icons.attach_money,
                      tipo: TextInputType.number),
                  _campoTexto('Stock', _stockController, Icons.inventory,
                      tipo: TextInputType.number),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _guardarProducto,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text(
                      'Guardar Producto',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade700,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(String label, TextEditingController controller, IconData icon,
      {TextInputType tipo = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueGrey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade600, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: (v) =>
            v == null || v.isEmpty ? 'Campo obligatorio' : null,
      ),
    );
  }
}
