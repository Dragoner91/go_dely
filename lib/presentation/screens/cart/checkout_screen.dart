import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: _Content(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _PlaceOrderButton()
                ],
              )),
        ),
      );
  }
}

class _PlaceOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: FilledButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFF5D9558))),
            onPressed: () {
              context.push("/checkout");
            },
            child: const Text(
              "Place Order",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            )),
      ),
    );
  }
}

class _Content extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //*Datos falsos
    final List<String> addresses = [
      "Calle 1, 123",
      "Calle 2, 456",
      "Calle 3, 789",
    ];
    final List<String> paymentMethods = [
      "Credit Card",
      "Debit Card",
      "Pago Movil",
      "Cash"
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          _Addresses(addresses: addresses,), //*mandarle las direcciones
          const _DatePicker(), //*implementar un provider para toda esta info
          _PaymentMethod(paymentMethods: paymentMethods,), //*pasarle los metodos
        ],
      )
    );
  }
}

class _Addresses extends StatelessWidget {

  final int selected = 0;
  final List<String> addresses;

  const _Addresses({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text("Shipping To", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(
            height: 330,
            child: ListView.builder(
              itemCount: addresses.length,
              shrinkWrap: true,
              itemBuilder: (context, index) { 
                bool isSelected;
                selected == index ? isSelected = true : isSelected = false;
                return _Address(selected: isSelected, address: addresses[index],);
                }, //*meterle una direccion
            ),
          ),
    
    
          //* agregar boton para nueva direccion y lo que involucre
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text("Add New Address", style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primaryColor.primary
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Address extends StatelessWidget {
  final bool selected;
  final String address;
  const _Address({required this.selected, required this.address});

  @override
  Widget build(BuildContext context) {

    final selectedColor = Theme.of(context).splashColor;
    final unselectedColor = Theme.of(context).scaffoldBackgroundColor;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: selected == true ? selectedColor : unselectedColor,
          border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.0,
              child: Checkbox(
                shape: const CircleBorder(),
                value: selected,
                onChanged: (value) {
                  //* implementar provider para el valor seleccionado y hacerlo persistente con sharedPreferences
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(address), //*arreglar esto cuando las direcciones reales esten listas
                  Text('${address}, ${address} ${address}'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                //* implementar editar direccion del usuario
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DatePicker extends StatefulWidget {
  const _DatePicker({super.key});

  @override
  __DatePickerState createState() => __DatePickerState();
}

class __DatePickerState extends State<_DatePicker> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final backgroundColor = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "Preferred Delivery Time",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: selectedDate != null ? backgroundColor.highlightColor : backgroundColor.canvasColor,
                    border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  decoration: BoxDecoration(
                    color: selectedTime != null ? backgroundColor.highlightColor : backgroundColor.canvasColor,
                    border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text(
                      selectedTime == null
                          ? 'Select Time'
                          : '${selectedTime!.hour}:${selectedTime!.minute}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod extends StatefulWidget {

  final List<String> paymentMethods;

  const _PaymentMethod({super.key, required this.paymentMethods});

  @override
  State<_PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<_PaymentMethod> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.paymentMethods.length,
            itemBuilder: (context, index) {
              return RadioListTile<String>(
                title: Text(widget.paymentMethods[index]),
                value: widget.paymentMethods[index],
                groupValue: selectedMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedMethod = value;
                  });
                },
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              );
            },
          ),
        ],
      ),
    );
  }
}