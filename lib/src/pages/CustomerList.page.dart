import 'dart:io';
import 'package:banking_app/src/models/Customer.dart';
import 'package:banking_app/src/services/Customer.service.dart';
import 'package:banking_app/src/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/src/pages/CustomerDetail.Page.dart';

CustomerService ws = new CustomerService();
Utils util = new Utils();

class CustomerListPage extends StatefulWidget {
  const CustomerListPage();
  @override
  _AppPageState createState() => new _AppPageState();
}

class _AppPageState extends State<CustomerListPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery;
  List<Customer> list;
  List<Customer> listBase;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      updateSearchQuery(null);
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Customers'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    if (newQuery != null && newQuery.trim().length > 2) {
      List<Customer> _data = this
          .listBase
          .where((i) => (i.firstName + " " + i.lastName)
              .toLowerCase()
              .toString()
              .contains(newQuery.toLowerCase()))
          .toList();
      setState(() {
        this.list = _data;
        this.count = _data.length;
      });
    } else {
      setState(() {
        this.list = this.listBase;
        this.count = this.listBase.length;
      });
    }
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (this.list == null) {
      this._add();
    }
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        leading: _isSearching ? const BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
      ),
      body: listItems(),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          navigateToDetail(Customer.withId('', '', '', '', 0, '', ''));

          //Navigator.of(context).pushNamed("customer_add");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView listItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 5.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: util.getColor(),
              child: Text(this
                  .list[position]
                  .firstName
                  .substring(0, 1)
                  .toUpperCase()
                  .toString()),
            ),
            title: Text(this.list[position].firstName.toString() +
                " " +
                this.list[position].lastName.toString()),
            subtitle: Text("DNI : " +
                this.list[position].documentNumber.toString() +
                ", Email :" +
                this.list[position].email.toString()),
            onTap: () {
              debugPrint("Tapped on " + this.list[position].id.toString());
              navigateToDetail(this.list[position]);
            },
            //trailing: new PopupMenuButton(
            //    itemBuilder: (BuildContext context) {
            //      return this.getMenus(this.list[position]);
            //    },
            //    onSelected: (String value) => {
            //          Navigator.of(context).pushNamed(
            //            value,
            //            arguments: this.list[position],
            //          )
            //        }
            //),
          ),
        );
      },
    );
  }

  void _add() {
    list = List<Customer>();
    listBase = List<Customer>();
    var primseCustomer = ws.getCustomers();
    primseCustomer.then((response) {
      print(response.length);
      setState(() {
        count = response.length;
        listBase = response;
        list = response;
      });
    });
  }

  List<PopupMenuItem<String>> getMenus(Customer record) {
    List<PopupMenuItem<String>> list = List<PopupMenuItem<String>>();
    list.add(PopupMenuItem<String>(
      child: Text('Actualizar'),
      value: "customer_update",
    ));
    list.add(PopupMenuItem<String>(
      child: Text('Eliminar'),
      value: "customer_delete",
    ));
    return list;
  }

  void navigateToDetail(Customer customer) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerDetailPage(customer)),
    );
    if (result == true) {}
  }
}
