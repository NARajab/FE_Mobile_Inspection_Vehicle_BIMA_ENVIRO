import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:myapp/features/history/services/p2h_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:myapp/features/history/screens/template/timesheet_template.dart';
import 'package:myapp/features/home/services/p2h_foreman_services.dart';

class ExcavatorTemplate extends StatefulWidget {
  final int p2hId;
  final String role;

  const ExcavatorTemplate({
    super.key,
    required this.p2hId,
    required this.role
  });

  @override
  _ExcavatorTemplateState createState() => _ExcavatorTemplateState();
}

class _ExcavatorTemplateState extends State<ExcavatorTemplate> {
  final P2hHistoryServices _p2hHistoryServices = P2hHistoryServices();
  final ForemanServices _foremanServices = ForemanServices();
  late Future<Map<String, dynamic>> _p2hData;
  late Future<String> _operatorName;

  @override
  void initState() {
    super.initState();
    _p2hData = _p2hHistoryServices.getP2hById(widget.p2hId);
    _operatorName = _getOperatorName();
  }

  Future<String> _getOperatorName() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);
      final operatorName = decodedToken['name'] ?? 'Unknown';
      return operatorName;
    }

    return 'Unknown';
  }

  void _showFlushbar(BuildContext context) {
    Flushbar(
      message: "Timesheet tidak ditemukan",
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
    ).show(context);
  }

  Future<void> _validateForeman() async {
    try {
      await _foremanServices.foremanValidation(widget.p2hId);
      Flushbar(
        title: 'Success',
        message: 'Validation successful',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
      ).show(context);
    } catch (e) {
      Flushbar(
        title: 'Error',
        message: 'Failed to validate: $e',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _p2hData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No data available'));
        } else {
          final data = snapshot.data!;
          final pph = data['Pph'] as Map<String, dynamic>;
          final vehicle = pph['Vehicle'] as Map<String, dynamic>;

          // Extract the conditions
          final conditions = {
            'AroundUnit': pph['AroundUnit'] as Map<String, dynamic>,
            'MachineRoom': pph['MachineRoom'] as Map<String, dynamic>,
            'InTheCabin': pph['InTheCabin'] as Map<String, dynamic>
          };

          return FutureBuilder<String>(
            future: _operatorName,
            builder: (context, operatorSnapshot) {
              if (operatorSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (operatorSnapshot.hasError) {
                return Center(child: Text('Error: ${operatorSnapshot.error}'));
              } else if (!operatorSnapshot.hasData) {
                return const Center(child: Text('No operator name available'));
              } else {
                final operatorName = operatorSnapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
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
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                _buildDetailRow(
                                    'Model Unit', vehicle['type'] ?? 'Unknown'),
                                _buildDetailRow(
                                    'No Unit', pph['nou'] ?? 'Unknown'),
                                _buildDetailRow(
                                    'Tanggal', pph['date'] ?? 'Unknown'),
                                _buildDetailRow(
                                    'Shift', pph['shift'] ?? 'Unknown'),
                                _buildDetailRow('Nama Operator', operatorName),
                                _buildDetailRow(
                                    'Jam', pph['time'] ?? 'Unknown'),
                                _buildDetailRow(
                                    'HM Awal', pph['earlyhm'] ?? 'Unknown'),
                                _buildDetailRow(
                                    'HM Akhir', pph['endhm'] ?? 'Unknown'),
                              ],
                            ),
                          ),
                          const Divider(height: 0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 1000,
                              child: SfDataGrid(
                                source: _DataGridSource(_buildTableData(pph)),
                                columnWidthMode: ColumnWidthMode.fill,
                                columns: [
                                  GridColumn(
                                    columnName: 'No',
                                    width: 70,
                                    label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'NO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'PIC',
                                    width: 50,
                                    label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'PIC',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Item',
                                    width: 270,
                                    label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'ITEM YANG HARUS DIPERIKSA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Kode',
                                    width: 90,
                                    label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'KODE BAHAYA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GridColumn(
                                    columnName: 'Kondisi',
                                    width: 90,
                                    label: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'KONDISI',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.role == 'Forman') ...[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _validateForeman();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF304FFE),
                                            textStyle: const TextStyle(fontSize: 18),
                                            foregroundColor: Colors.white,
                                            elevation: 5,
                                          ),
                                          child: const Text('Validation'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, right: 90.0, left: 90.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              var idLocation = pph['idLocation'];
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => TimesheetTemplate(idLocation: idLocation),
                              //   ),
                              // );
                              if (idLocation != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TimesheetTemplate(idLocation: idLocation),
                                  ),
                                );
                              } else {
                                _showFlushbar(context);
                              }
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
            },
          );
        }
      },
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

  List<DataGridRow> _buildTableData(Map<String, dynamic> pph) {
    final aroundUnit = pph['AroundUnit'] as Map<String, dynamic>;
    final machineRoom = pph['MachineRoom'] as Map<String, dynamic>;
    final inTheCabin = pph['InTheCabin'] as Map<String, dynamic>;

    return [
      const DataGridRow(cells: [
        DataGridCell<String>(columnName: 'No', value: 'A.'),
        DataGridCell<String>(columnName: 'PIC', value: ''),
        DataGridCell<String>(
            columnName: 'Item',
            value: 'Pemeriksaan Keliling Unit / Diluar Kabin'),
        DataGridCell<String>(columnName: 'Kode', value: ''),
        DataGridCell<String>(columnName: 'Kondisi', value: ''),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '1.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kondisi Underacarriage'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['ku'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '2.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kerusakan akibat insiden ***)'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['kai'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '3.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kebocoran oli gear box / oli PTO'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['kogb'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '4.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Level oli swing & kebocoran'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['los'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '5.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Level oli hydraulic & kebocoran'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['loh'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '6.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item',
            value: 'Fuel drain / Buangan air dari tanki BBC'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['fd'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '7.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'BBC minimum 25% dari Cap. Tangki'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['bbcmin'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '8.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Buang air dalam tanki udara'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['badtu'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '9.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kebersihan accessories safety & Alat'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['kasa'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '10.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kebocoran2 bila ada (oli, solar, grease)'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['kba'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '11.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Back travel (Big Digger)'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['at'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '12.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Lock pin Bucket'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['lpb'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '13.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Lock pin tooth & ketajaman kuku'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['lptdkk'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '14.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kebersihan aki / battery'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: aroundUnit['ka'] == true ? 'Baik' : 'Rusak'),
      ]),
      const DataGridRow(cells: [
        DataGridCell<String>(columnName: 'No', value: 'B.'),
        DataGridCell<String>(columnName: 'PIC', value: ''),
        DataGridCell<String>(
            columnName: 'Item', value: 'Pemeriksaan di dalam kabin'),
        DataGridCell<String>(columnName: 'Kode', value: ''),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: ''),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '1.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Air conditioner (AC)'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['ac'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '2.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi steering / kemudi'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fs'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '3.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi seat belt / sabuk pengaman'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fsb'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '4.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi semua lampu'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fsl'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '5.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi Rotary lamp'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['frl'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '6.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi mirror / spion'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fm'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '7.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi wiper dan air wiper'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fwdaw'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '8.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi horn / klakson'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fh'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '9.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fire Extinguiser / APAR'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['feapar'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '10.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi kontrol panel'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['fkp'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '11.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Fungsi radio komunikasi'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['frk'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '12.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Kebersihan ruang kabin'),
        const DataGridCell<String>(columnName: 'Kode', value: 'A'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: inTheCabin['krk'] == true ? 'Baik' : 'Rusak'),
      ]),
      const DataGridRow(cells: [
        DataGridCell<String>(columnName: 'No', value: 'C.'),
        DataGridCell<String>(columnName: 'PIC', value: ''),
        DataGridCell<String>(
            columnName: 'Item', value: 'Pemeriksaan di ruang mesin'),
        DataGridCell<String>(columnName: 'Kode', value: ''),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: ''),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '1.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Air Radiator'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: machineRoom['ar'] == true ? 'Baik' : 'Rusak'),
      ]),
      DataGridRow(cells: [
        const DataGridCell<String>(columnName: 'No', value: '2.'),
        const DataGridCell<String>(columnName: 'PIC', value: 'Opr'),
        const DataGridCell<String>(
            columnName: 'Item', value: 'Oil Engine / Oli Mesin'),
        const DataGridCell<String>(columnName: 'Kode', value: 'AA'),
        DataGridCell<String>(
            columnName: 'Kondisi',
            value: machineRoom['oe'] == true ? 'Baik' : 'Rusak'),
      ]),
    ];
  }
}

class _DataGridSource extends DataGridSource {
  _DataGridSource(this._dataGridRows);

  List<DataGridRow> _dataGridRows;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final kondisi = row.getCells()[4].value as String;
    final kondisiColor = (kondisi == null || kondisi.isEmpty)
        ? Colors.transparent
        : (kondisi == 'Baik' ? Colors.green : Colors.red);

    return DataGridRowAdapter(
      cells: [
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(row.getCells()[0].value.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(row.getCells()[1].value.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(row.getCells()[2].value.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(row.getCells()[3].value.toString()),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          color: kondisiColor,
          child: Text(
            row.getCells()[4].value.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
