import 'package:flutter/material.dart';
import '../models/producto.dart';

class EditarProductoPage extends StatefulWidget {
  final Producto producto;

  const EditarProductoPage({super.key, required this.producto});

  @override
  State<EditarProductoPage> createState() => _EditarProductoPageState();
}

class _EditarProductoPageState extends State<EditarProductoPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _categoriaController;
  late TextEditingController _proveedorController;
  late TextEditingController _codigoBarrasController;
  late TextEditingController _precioController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.producto.nombre);
    _descripcionController = TextEditingController(text: widget.producto.descripcion);
    _categoriaController = TextEditingController(text: widget.producto.categoria);
    _proveedorController = TextEditingController(text: widget.producto.proveedor);
    _codigoBarrasController = TextEditingController(text: widget.producto.codigoBarras);
    _precioController = TextEditingController(text: widget.producto.precio.toString());
    _stockController = TextEditingController(text: widget.producto.stock.toString());
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _categoriaController.dispose();
    _proveedorController.dispose();
    _codigoBarrasController.dispose();
    _precioController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      final productoEditado = Producto(
        id: widget.producto.id,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        categoria: _categoriaController.text,
        proveedor: _proveedorController.text,
        codigoBarras: _codigoBarrasController.text,
        precio: double.tryParse(_precioController.text) ?? 0.0,
        stock: int.tryParse(_stockController.text) ?? 0,
      );

      Navigator.pop(context, productoEditado);
    }
  }

  InputDecoration _inputDecor(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.blueGrey),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueGrey, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Editar Producto', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey,
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: _inputDecor('Nombre', Icons.label),
                    validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descripcionController,
                    decoration: _inputDecor('Descripción', Icons.description),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _categoriaController,
                    decoration: _inputDecor('Categoría', Icons.category),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _proveedorController,
                    decoration: _inputDecor('Proveedor', Icons.store),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _codigoBarrasController,
                    decoration: _inputDecor('Código de Barras', Icons.qr_code),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _precioController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecor('Precio', Icons.attach_money),
                    validator: (value) =>
                        value == null || double.tryParse(value) == null ? 'Ingrese un número válido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecor('Stock', Icons.inventory),
                    validator: (value) =>
                        value == null || int.tryParse(value) == null ? 'Ingrese un número válido' : null,
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton.icon(
                    onPressed: _guardarCambios,
                    icon: const Icon(Icons.save, color: Colors.white),
                    label: const Text('Guardar Cambios', style: TextStyle(fontSize: 16, color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
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
}
