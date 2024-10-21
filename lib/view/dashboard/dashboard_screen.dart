import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboard/router.dart';
import 'package:onboard/utils/colors.dart';
import 'package:onboard/utils/common_methods.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: textWidget(text: 'Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            mediumSpace(),
            mediumSpace(),
            ListTile(
              leading: const Icon(Icons.add),
              title: textWidget(text: 'Add Candidate'),
              onTap: () {
                Get.toNamed(RouteManagement.recruiterDataScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: textWidget(text: 'Interview Scheduling'),
              onTap: () {
                Get.toNamed(RouteManagement.searchScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: textWidget(text: 'Interview Scheduled'),
              onTap: () {
               Get.toNamed(RouteManagement.scheduledInterviewListScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: textWidget(text: 'Add Vacancy'),
              onTap: () {
                Get.toNamed(RouteManagement.addVacancyScreen);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: textWidget(text: 'Logout'),
              onTap: () {
                getStorage.write('isLogin', false);
                Get.offAllNamed(RouteManagement.loginScreen);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: Get.height*0.1,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    title: 'Selected Students',
                    total: 120,
                    color: Colors.green.shade100,
                  ),
                  _buildDashboardCard(
                    title: 'Shortlisted Students',
                    total: 80,
                    color: Colors.blue.shade100,
                  ),
                  _buildDashboardCard(
                    title: 'Blacklisted Students',
                    total: 10,
                    color: Colors.red.shade100,
                  ),
                  _buildDashboardCard(
                    title: 'Interview Scheduled',
                    total: 45,
                    color: Colors.orange.shade100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDashboardCard({required String title, required int total, required Color color}) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '$total',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
