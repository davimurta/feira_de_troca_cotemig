import 'package:flutter/material.dart';

class TicketsWallet extends StatefulWidget {
  const TicketsWallet({super.key});

  @override
  State<TicketsWallet> createState() => _TicketsWalletState();
}

class _TicketsWalletState extends State<TicketsWallet> {
  int _saldoTickets = 25; // Saldo em tickets (apenas números inteiros)
  
  // Histórico simples de transações
  final List<Map<String, dynamic>> _transacoes = [
    {
      'tipo': 'recebido',
      'valor': 5,
      'descricao': 'Vendeu: Livro de História',
      'data': '08/08',
    },
    {
      'tipo': 'gasto',
      'valor': -3,
      'descricao': 'Comprou: Caneta azul',
      'data': '08/08',
    },
    {
      'tipo': 'recebido',
      'valor': 8,
      'descricao': 'Vendeu: Calculadora',
      'data': '07/08',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF45b80b),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Meus Tickets'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card do Saldo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF45b80b),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Seus Tickets',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_saldoTickets',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'tickets',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Botões de Ação
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _lerQRCode,
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Ler QR Code'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF45b80b),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _mostrarQRCode,
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Meu QR'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF45b80b),
                      side: const BorderSide(color: Color(0xFF45b80b), width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Histórico
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Últimas transações',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF45b80b),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            Expanded(
              child: _transacoes.isEmpty 
                ? const Center(
                    child: Text(
                      'Nenhuma transação ainda',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _transacoes.length,
                    itemBuilder: (context, index) {
                      final transacao = _transacoes[index];
                      final isRecebido = transacao['tipo'] == 'recebido';
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isRecebido 
                                    ? const Color(0xFF45b80b).withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isRecebido ? Icons.add : Icons.remove,
                                color: isRecebido ? const Color(0xFF45b80b) : Colors.red,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transacao['descricao'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    transacao['data'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${isRecebido ? '+' : ''}${transacao['valor']}',
                              style: TextStyle(
                                color: isRecebido ? const Color(0xFF45b80b) : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
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

  void _lerQRCode() {
    // Simulando leitura de QR Code
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanner'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF45b80b), width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        size: 80,
                        color: Color(0xFF45b80b),
                      ),
                      SizedBox(height: 16),
                      Text('Aponte a câmera para o QR Code'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Simular transação recebida
                setState(() {
                  _saldoTickets += 3;
                  _transacoes.insert(0, {
                    'tipo': 'recebido',
                    'valor': 3,
                    'descricao': 'Recebido via QR Code',
                    'data': '08/08',
                  });
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('3 tickets recebidos!'),
                    backgroundColor: Color(0xFF45b80b),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF45b80b),
              ),
              child: const Text('Simular Leitura', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _mostrarQRCode() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Meu QR Code'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code,
                        size: 120,
                        color: Color(0xFF45b80b),
                      ),
                      Text('QR Code para receber'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Outros participantes podem escanear este código para te enviar tickets',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}