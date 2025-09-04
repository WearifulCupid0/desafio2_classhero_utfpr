import 'package:flutter/material.dart';

// Um modelo de dados para representar um evento
class Evento {
  String nome;
  String data;
  String local;

  Evento({required this.nome, required this.data, required this.local});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Eventos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EventoScreen(),
    );
  }
}

class EventoScreen extends StatefulWidget {
  const EventoScreen({super.key});

  @override
  State<EventoScreen> createState() => _EventoScreenState();
}

class _EventoScreenState extends State<EventoScreen> {
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _localController = TextEditingController();

  // Lista para armazenar os eventos cadastrados
  final List<Evento> _eventos = [];

  // Método para adicionar um novo evento
  void _adicionarEvento() {
    setState(() {
      // Cria um novo objeto Evento com os dados dos controladores
      final novoEvento = Evento(
        nome: _nomeController.text,
        data: _dataController.text,
        local: _localController.text,
      );

      // Adiciona o novo evento à lista
      _eventos.add(novoEvento);

      // Limpa os campos de texto
      _nomeController.clear();
      _dataController.clear();
      _localController.clear();
    });
  }

  @override
  void dispose() {
    // Libera os controladores quando o widget é descartado
    _nomeController.dispose();
    _dataController.dispose();
    _localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Eventos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Campos de texto para nome, data e local
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome do Evento'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(labelText: 'Data'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _localController,
              decoration: const InputDecoration(labelText: 'Local'),
            ),
            const SizedBox(height: 20),
            // Botão para adicionar o evento
            ElevatedButton(
              onPressed: _adicionarEvento,
              child: const Text('Adicionar Evento'),
            ),
            const SizedBox(height: 30),
            // Título para a lista de eventos
            const Text(
              'Eventos Cadastrados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Lista para exibir os eventos
            Expanded(
              child: ListView.builder(
                itemCount: _eventos.length,
                itemBuilder: (context, index) {
                  final evento = _eventos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(evento.nome),
                      subtitle: Text('Data: ${evento.data} - Local: ${evento.local}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}