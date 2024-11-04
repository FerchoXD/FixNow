import 'package:flutter/material.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  _SchedulesScreenState createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  final Map<String, String> _schedule = {
    'Lunes': '8 am - 5 pm',
    'Martes': '8 am - 5 pm',
    'Miércoles': '8 am - 5 pm',
    'Jueves': 'No laboral',
    'Viernes': '8 am - 5 pm',
    'Sábado': '8 am - 5 pm',
    'Domingo': 'No laboral',
  };

  final Map<String, bool> _isNonWorkingDay = {
    'Lunes': false,
    'Martes': false,
    'Miércoles': false,
    'Jueves': true,
    'Viernes': false,
    'Sábado': false,
    'Domingo': true,
  };

  String? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: Text(
                  'Configura tu disponibilidad',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                height: screenHeight * 0.5,
                child: ListView.builder(
                  itemCount: _schedule.keys.length,
                  itemBuilder: (context, index) {
                    String day = _schedule.keys.elementAt(index);
                    bool isSelected = _selectedDay == day && !_isNonWorkingDay[day]!;
                    bool isNonWorkingDay = _isNonWorkingDay[day] ?? false;

                    return GestureDetector(
                      onTap: () {
                        if (!isNonWorkingDay) {
                          setState(() {
                            _selectedDay = day;
                          });
                          _selectTimeRange(context, day);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          border: Border(
                            left: BorderSide(
                              color: isSelected
                                  ? Colors.blue
                                  : (isNonWorkingDay ? Colors.grey : Colors.blue),
                              width: screenWidth * 0.02,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: devicePixelRatio * 5,
                              offset: Offset(0, devicePixelRatio * 1.5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            day,
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: isNonWorkingDay ? Colors.grey : Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            _schedule[day]!,
                            style: TextStyle(
                              color: isNonWorkingDay ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "No laboral",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.03,
                                  color: isNonWorkingDay ? Colors.grey : Colors.black,
                                ),
                              ),
                              Checkbox(
                                value: isNonWorkingDay,
                                onChanged: (value) {
                                  if (value != null && value == true && !_canMarkAsNonWorkingDay(day)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Debe haber al menos un día laboral.'),
                                      ),
                                    );
                                    return;
                                  }
                                  setState(() {
                                    _isNonWorkingDay[day] = value ?? false;
                                    _schedule[day] = (value ?? false) ? 'No laboral' : '8 am - 5 pm';
                                    if (value == true) {
                                      _selectedDay = null; // Eliminar el foco si es "No laboral"
                                    }
                                  });
                                },
                              ),
                              Icon(
                                Icons.touch_app_outlined,
                                color: isSelected ? Colors.blue : Colors.grey,
                                size: screenWidth * 0.06,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para mostrar el selector de tiempo
  Future<void> _selectTimeRange(BuildContext context, String day) async {
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    );

    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 17, minute: 0),
      );

      if (endTime != null) {
        setState(() {
          _schedule[day] =
              '${startTime.format(context)} - ${endTime.format(context)}';
          _isNonWorkingDay[day] = false;
        });
      }
    }
  }

  // Validación para asegurar que al menos un día permanezca como laboral
  bool _canMarkAsNonWorkingDay(String day) {
    int workingDaysCount = _isNonWorkingDay.values.where((isNonWorking) => !isNonWorking).length;
    return workingDaysCount > 1;
  }
}
