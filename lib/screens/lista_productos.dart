import 'package:flutter/material.dart';
import '../models/producto.dart';
import 'editar_producto.dart';
import 'agregar_producto.dart';

class ListaProductosPage extends StatefulWidget {
  const ListaProductosPage({super.key});

  @override
  State<ListaProductosPage> createState() => _ListaProductosPageState();
}

class _ListaProductosPageState extends State<ListaProductosPage> {
  List<Producto> productos = [
    Producto(
      id: 1,
      nombre: 'iPhone 15 Pro',
      descripcion: 'Smartphone de alta gama de Apple con chip A17 Pro.',
      categoria: 'Celulares',
      proveedor: 'Apple Inc.',
      codigoBarras: 'AAPL-IP15-001',
      precio: 5899.00,
      stock: 10,
    ),
    Producto(
      id: 2,
      nombre: 'Samsung Galaxy S24',
      descripcion: 'Celular Android con cámara de 200MP y pantalla AMOLED.',
      categoria: 'Celulares',
      proveedor: 'Samsung Electronics',
      codigoBarras: 'SMSNG-S24-002',
      precio: 4799.00,
      stock: 15,
    ),
    Producto(
      id: 3,
      nombre: 'MacBook Air M2',
      descripcion: 'Laptop ligera con chip M2, ideal para productividad.',
      categoria: 'Computadoras',
      proveedor: 'Apple Inc.',
      codigoBarras: 'AAPL-MBA2-003',
      precio: 6399.00,
      stock: 8,
    ),
    Producto(
      id: 4,
      nombre: 'AirPods Pro',
      descripcion: 'Auriculares inalámbricos con cancelación activa de ruido.',
      categoria: 'Accesorios',
      proveedor: 'Apple Inc.',
      codigoBarras: 'AAPL-AIRP-004',
      precio: 1249.00,
      stock: 20,
    ),
    Producto(
      id: 5,
      nombre: 'iPad Air',
      descripcion: 'Tablet de Apple con chip M1 y pantalla Liquid Retina.',
      categoria: 'Tablets',
      proveedor: 'Apple Inc.',
      codigoBarras: 'AAPL-IPAD-005',
      precio: 3299.00,
      stock: 12,
    ),
  ];

  void _editarProducto(Producto producto, int index) async {
    final Producto? productoEditado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarProductoPage(producto: producto),
      ),
    );

    if (productoEditado != null) {
      setState(() {
        productos[index] = productoEditado;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto actualizado ✅')),
      );
    }
  }

  void _eliminarProducto(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Eliminar producto'),
        content: const Text('¿Estás seguro de eliminar este producto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                productos.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Producto eliminado 🗑️')),
              );
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: const Text(
          'Inventario de Productos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 4,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final p = productos[index];
          return Card(
            elevation: 4,
            shadowColor: Colors.teal.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade100,
                child: Text(
                  p.nombre.substring(0, 1),
                  style: const TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                p.nombre,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.descripcion,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '💰 S/ ${p.precio.toStringAsFixed(2)}   |   🧾 Stock: ${p.stock}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon:
                        const Icon(Icons.edit, color: Colors.teal, size: 26),
                    onPressed: () => _editarProducto(p, index),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.delete, color: Colors.redAccent, size: 26),
                    onPressed: () => _eliminarProducto(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () async {
          final Producto? nuevoProducto = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgregarProductoPage()),
          );

          if (nuevoProducto != null) {
            setState(() {
              productos.add(nuevoProducto);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Producto agregado ✅')),
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Agregar producto"),
      ),
    );
  }
}
