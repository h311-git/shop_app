import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/product_provider.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/addProduct';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _imageNode = FocusNode();
  final _imageController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String id;
  bool _isInit = true;
  var _formData = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  @override
  void initState() {
    _imageNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final String id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {
        _formData = Provider.of<Products>(context, listen: false).findByID(id);
        _imageController.text = _formData.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void dispose() {
    _imageNode.removeListener(_updateImage);
    _imageNode.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final result = _key.currentState.validate();
    if (!result) {
      return;
    }
    _key.currentState.save();
    final product = Provider.of<Products>(context, listen: false);
    if (_formData.id == null) {
      product.addProduct(_formData);
    } else {
      product.updateProduct(_formData.id, _formData);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData.title,
                //title
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onSaved: (newValue) => _formData = Product(
                  id: _formData.id,
                  title: newValue,
                  description: '',
                  price: 0,
                  imageUrl: '',
                  isFavorite: _formData.isFavorite,
                ),
                validator: (value) =>
                    value.isEmpty ? "Please provide a title" : null,
              ),
              TextFormField(
                //price
                initialValue:
                    _formData.id == null ? '' : _formData.price.toString(),
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onSaved: (newValue) => _formData = Product(
                  id: _formData.id,
                  title: _formData.title,
                  description: '',
                  price: double.parse(newValue),
                  imageUrl: '',
                  isFavorite: _formData.isFavorite,
                ),
                validator: (value) {
                  try {
                    var test = double.parse(value);
                    if (test < 0) {
                      return "Please provide a number greate than zero";
                    }
                    return null;
                  } catch (e) {
                    return "Please Provide a number!";
                  }
                },
              ),
              TextFormField(
                //description
                initialValue: _formData.description,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (newValue) => _formData = Product(
                  id: _formData.id,
                  title: _formData.title,
                  description: newValue,
                  price: _formData.price,
                  imageUrl: '',
                  isFavorite: _formData.isFavorite,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please provide a description";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 15, left: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                    child: _imageController.text.isEmpty
                        ? Text("Enter a URL")
                        : FittedBox(
                            child: Image.network(
                              _imageController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        //URL
                        decoration: InputDecoration(labelText: "Image URL"),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageController,
                        focusNode: _imageNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (newValue) => _formData = Product(
                          id: _formData.id,
                          title: _formData.title,
                          description: _formData.description,
                          price: _formData.price,
                          imageUrl: newValue,
                          isFavorite: _formData.isFavorite,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please provide a URL";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
