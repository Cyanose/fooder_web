import 'package:flutter/material.dart';
import 'package:fooder_web/screens/based.dart';
import 'package:fooder_web/models/product.dart';
import 'package:fooder_web/models/entry.dart';
import 'package:fooder_web/widgets/product.dart';


class EditEntryScreen extends BasedScreen {
  final Entry entry;

  const EditEntryScreen({super.key, required super.apiClient, required this.entry});

  @override
  State<EditEntryScreen> createState() => _EditEntryScreen();
}


class _EditEntryScreen extends State<EditEntryScreen> {
  final gramsController = TextEditingController();
  final productNameController = TextEditingController();
  List<Product> products = [];

  @override
  void dispose() {
    gramsController.dispose();
    productNameController.dispose();
    super.dispose();
  }

  void popMeDady() {
    Navigator.pop(context);
  }

  @override
  void initState () {
    super.initState();
    setState(() {
      gramsController.text = widget.entry.grams.toString();
      productNameController.text = widget.entry.product.name;
      products = [widget.entry.product];
    });
  }

  Future<void> _getProducts() async {
    var productsMap = await widget.apiClient.getProducts(productNameController.text);
    setState(() {
      products = (productsMap['products'] as List<dynamic>).map((e) => Product.fromJson(e as Map<String, dynamic>)).toList();
    });
  }

  void showError(String message)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<void> _saveEntry() async {
    if (products.length != 1) {
      showError("Pick product first");
      return;
    }

    try {
      double.parse(gramsController.text);
    } catch (e) {
      showError("Grams must be a number");
      return;
    }

    await widget.apiClient.updateEntry(
      widget.entry.id,
      grams: double.parse(gramsController.text),
      productId: products[0].id,
      mealId: widget.entry.mealId,
    );
    popMeDady();
  }

  Future<void> _deleteEntry() async {
    await widget.apiClient.deleteEntry(widget.entry.id);
    popMeDady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("🅵🅾🅾🅳🅴🆁"),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 720),
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Grams',
                ),
                controller: gramsController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product name',
                ),
                controller: productNameController,
                onChanged: (_) => _getProducts(),
              ),
              for (var product in products)
                ListTile(
                onTap: () {
                  setState(() {
                    products = [product];
                    });
                },
                title: ProductWidget(
                  product: product,
                ),
              ),
            ]
          )
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _deleteEntry,
            heroTag: null,
            child: const Icon(Icons.delete),
          ),
          FloatingActionButton(
            onPressed: _saveEntry,
            heroTag: null,
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }
}