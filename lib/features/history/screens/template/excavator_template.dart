import 'package:flutter/material.dart';

class ExcavatorTemplate extends StatelessWidget {
  final String date;
  final String entry;
  final String role;

  const ExcavatorTemplate({
    super.key,
    required this.date,
    required this.entry,
    required this.role
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Excavator',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow('Model Unit', 'XYZ Model'),
                    _buildDetailRow('No Unit', '123'),
                    _buildDetailRow('Tanggal', date),
                    _buildDetailRow('Shift', 'Pagi'),
                    _buildDetailRow('Nama Operator', 'John Doe'),
                    _buildDetailRow('Jam', '08:00 - 12:00'),
                    _buildDetailRow('HM Awal', '1000'),
                    _buildDetailRow('HM Akhir', '1200'),
                  ],
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    _buildTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 90.0, left: 90.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TimesheetHistoryScreen(role: role),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF304FFE),
                  textStyle: const TextStyle(
                    fontSize: 18,
                  ),
                  foregroundColor: Colors.white,
                  elevation: 5,
                ),
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          DataColumn(label: Text('NO')),
          DataColumn(label: Text('PIC')),
          DataColumn(label: Text('ITEM YANG HARUS DIPERIKSA')),
          DataColumn(label: Text('KODE BAHAYA')),
          DataColumn(label: Text('KONDISI')),
          DataColumn(label: Text('CATATAN/TEMUAN')),
          DataColumn(label: Text('COMMENT/JAWABAN')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('A.')),
            DataCell(Text('')),
            DataCell(Text('Pemeriksaan Keliling Unit / Diluar Kabin')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Opr')),
            DataCell(Text('Kondisi Underacarriage')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('2')),
            DataCell(Text('Opr')),
            DataCell(Text('Kerusakan akibat insiden ***)')),
            DataCell(Text('AA')),
            DataCell(Text('Rusak')),
            DataCell(Text('Catatan 2')),
            DataCell(Text('Komentar 2')),
          ]),
          DataRow(cells: [
            DataCell(Text('3')),
            DataCell(Text('Opr')),
            DataCell(Text('Kebocoran oli gear box / oli PTO')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('4')),
            DataCell(Text('Opr')),
            DataCell(Text('Level oli swing & kebocoran')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('5')),
            DataCell(Text('Opr')),
            DataCell(Text('Level oli hydraulic & kebocoran')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('6')),
            DataCell(Text('Opr')),
            DataCell(Text('Fuel drain / Buang air dari tanki BBC')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('7')),
            DataCell(Text('Opr')),
            DataCell(Text('BBC minimum 25% dari Cap. Tangki')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('8')),
            DataCell(Text('Opr')),
            DataCell(Text('Buang air dalam tanki udara')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('9')),
            DataCell(Text('Opr')),
            DataCell(Text('Kebersihan accessories safety & Alat')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('10')),
            DataCell(Text('Opr')),
            DataCell(Text('Kebocoran2 bila ada (oli, solar, grease)')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('11')),
            DataCell(Text('Opr')),
            DataCell(Text('Back travel (Big Digger)')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('12')),
            DataCell(Text('Opr')),
            DataCell(Text('Lock pin Bucket')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('13')),
            DataCell(Text('Opr')),
            DataCell(Text('Lock pin tooth & ketajaman kuku')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('14')),
            DataCell(Text('Opr')),
            DataCell(Text('Kebersihan aki / battery')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('B.')),
            DataCell(Text('')),
            DataCell(Text('Pemeriksaan Di Dalam Kabin')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Opr')),
            DataCell(Text('Air conditioner (AC)')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('2')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi steering / kemudi')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('3')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi seat belt / sabuk pengaman')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('4')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi semua lampu')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('5')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi Rotary lamp')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('6')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi mirror / spion')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('7')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi wiper dan air wiper')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('8')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi horn / klakson')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('9')),
            DataCell(Text('Opr')),
            DataCell(Text('Fire Extinguiser / APAR')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),

          DataRow(cells: [
            DataCell(Text('10')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi kontrol panel')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('11')),
            DataCell(Text('Opr')),
            DataCell(Text('Fungsi radio komunikasi')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('12')),
            DataCell(Text('Opr')),
            DataCell(Text('Kebersihan ruang kabin')),
            DataCell(Text('A')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('C.')),
            DataCell(Text('')),
            DataCell(Text('Pemeriksaan Di Ruang Mesin')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('Opr')),
            DataCell(Text('Air Radiator')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
          DataRow(cells: [
            DataCell(Text('2')),
            DataCell(Text('Opr')),
            DataCell(Text('Oil Engine / Oli Mesin')),
            DataCell(Text('AA')),
            DataCell(Text('Baik')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]),
        ],
      ),
    );
  }
}

class TimesheetHistoryScreen extends StatelessWidget {
  final String role;
  const TimesheetHistoryScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timesheet History'),
        backgroundColor: const Color(0xFF304FFE),
        elevation: 5,
        shadowColor: Colors.black,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400
        ),
        toolbarHeight: 45,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 69,
              height: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Location',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow('PIT', 'XYZ Model'),
                        _buildDetailRow('Disposal', '123'),
                        _buildDetailRow('Lokasi', 'Top Soil'),
                        _buildDetailRow('Pengisian Fuel :', ''),
                        _buildDetailRow('HM', '08:00 - 12:00'),
                        _buildDetailRow('Fuel', '1000 (Liter)'),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildTable(),
                        if (role == 'foreman') ...[
                          const SizedBox(height: 12),
                          const Text(
                            'Catatan/Temuan:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Tambahkan catatan...',
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    // function submit
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF304FFE),
                                    textStyle: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    foregroundColor: Colors.white,
                                    elevation: 5,
                                  ),
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('TIME')),
          DataColumn(label: Text('MATERIAL')),
          DataColumn(label: Text('REMARK')),
          DataColumn(label: Text('')),
          DataColumn(label: Text('')),
          DataColumn(label: Text('KODE')),
          DataColumn(label: Text('')),
          DataColumn(label: Text('')),
        ],
        rows: const [
          DataRow(
              cells: [
                DataCell(Text('7:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('8:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('9:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('10:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('11:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('12:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('13:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('14:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('15:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('16:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('17:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('18:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
          DataRow(
              cells: [
                DataCell(Text('19:00')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ]
          ),
        ],
      ),
    );
  }
}

