import 'dart:async';

import 'package:company/services/company_services.dart';
import 'package:flutter/material.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({super.key});

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  final CompanyService _companyList = CompanyService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company List'),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: _companyList.getCompanyList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, String> company = snapshot.data!;
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final key = company.keys.elementAt(index);
                            final item = company[key];
                            return ListTile(
                              title: Text(item!),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error : ${snapshot.error}'),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
