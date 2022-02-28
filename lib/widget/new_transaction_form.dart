import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionForm extends StatefulWidget {
  final Function _addTransaction;

  const NewTransactionForm(this._addTransaction);

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _titleFocus = FocusNode();
  final _amountFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _timeFocus = FocusNode();

  //bool _autoValidateToggle = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  _NewTransactionFormState() {
    //_autoValidateToggle = false;
    _selectedDate = DateTime.now();
    _selectedTime = null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900, 1),
      lastDate: today,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.value =
            TextEditingValue(text: DateFormat('d/M/y').format(pickedDate));
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.value = TextEditingValue(
            text: DateFormat.jm().format(
          DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          ),
        ));
      });
    }
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final txnTitle = _titleController.text;
      final txnAmount = double.parse(_amountController.text);
      final txnDateTime = DateTime(_selectedDate!.year, _selectedDate!.month,
          _selectedDate!.day, _selectedTime!.hour, _selectedTime!.minute);

      widget._addTransaction(
        txnTitle,
        txnAmount,
        txnDateTime,
      );
      Navigator.of(context).pop();
    } else {
      //_autoValidateToggle = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            const SizedBox(
              height: 15.0,
            ),

            // Title TextField
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                prefixIcon: Icon(Icons.title),
                hintText: "Enter a title",
              ),
              validator: (value) {
                if (value!.isEmpty) return "Title cannot be empty";
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: _titleFocus,
              onFieldSubmitted: (_) =>
                  _fieldFocusChange(context, _titleFocus, _amountFocus),
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 20.0,
            ),

            // Amount TextField
            TextFormField(
              focusNode: _amountFocus,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                prefixIcon: Icon(Icons.local_atm),
                hintText: "Enter the amount",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                RegExp regex = RegExp('[0-9]+(.[0-9]+)?');
                if (!regex.hasMatch(value!) || double.tryParse(value) == null) {
                  return "Please enter valid amount";
                }
                return null;
              },
              controller: _amountController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),

            const SizedBox(
              height: 20.0,
            ),

            // Date and Time Textfield
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Date TextField
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateController,
                        focusNode: _dateFocus,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          labelText: 'Date',
                          hintText: 'Date of Transaction',
                          prefixIcon: Icon(Icons.calendar_today),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) return "Please select a date";
                          return null;
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10.0,
                ),
                // Time TextField
                Flexible(
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _timeController,
                        focusNode: _timeFocus,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                          labelText: 'Time',
                          hintText: 'Time of Transaction',
                          prefixIcon: Icon(Icons.schedule),
                          suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) return "Please select a date";
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20.0,
            ),

            // Add Transaction Button
            SizedBox(
              width: double.infinity,
              height: 55.0,
              child: RaisedButton.icon(
                icon: const Icon(Icons.check),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                label: const Text(
                  'ADD TRANSACTION',
                  style: TextStyle(
                    fontFamily: "GoogleRegular",
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                textColor: Colors.white,
                color: Colors.green[700],
                onPressed: _onSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
