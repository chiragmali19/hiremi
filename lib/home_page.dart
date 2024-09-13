import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Job> jobs = [
    Job(
      title: 'Jr. Java Programmer',
      company: 'CRTD Technologies',
      location: 'Bhopal, Madhya Pradesh, India',
      qualification: 'BE/B.TECH/M.TECH/MCA/MBA/BCA/BSC/MSC',
      salary: '₹ 4.75 LPA',
      tags: ['Remote', 'Job', '2 Year Exp'],
    ),
    Job(
      title: 'Flutter Developer',
      company: 'ABC Software Pvt. Ltd.',
      location: 'Indore, Madhya Pradesh, India',
      qualification: 'BE/B.TECH/M.TECH/MCA',
      salary: '₹ 6.00 LPA',
      tags: ['On-site', 'Job', '1 Year Exp'],
    ),
    Job(
      title: 'React Developer',
      company: 'XYZ Technologies',
      location: 'Mumbai, Maharashtra, India',
      qualification: 'BCA/BSC/MCA',
      salary: '₹ 5.00 LPA',
      tags: ['Remote', 'Full-time', '3 Year Exp'],
    ),
    Job(
      title: 'Python Developer',
      company: 'DEF Solutions',
      location: 'Pune, Maharashtra, India',
      qualification: 'BE/B.TECH/MCA',
      salary: '₹ 5.50 LPA',
      tags: ['Remote', 'Full-time', '2 Year Exp'],
    ),
    Job(
      title: 'Backend Engineer',
      company: 'GHI Corp',
      location: 'Hyderabad, Telangana, India',
      qualification: 'B.TECH/MCA',
      salary: '₹ 7.50 LPA',
      tags: ['On-site', 'Job', '4 Year Exp'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Opportunities'),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return JobCard(job: jobs[index]);
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;

  JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                job.company,
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 18.0),
                  SizedBox(width: 5.0),
                  Text(job.location),
                ],
              ),
              SizedBox(height: 8.0),
              Text(job.qualification),
              SizedBox(height: 8.0),
              Text(job.salary, style: TextStyle(color: Colors.green)),
              SizedBox(height: 10.0),
              Row(
                children: job.tags.map((tag) => TagWidget(tag: tag)).toList(),
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  // Add apply functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                child: Text('Apply Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final String tag;

  TagWidget({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.yellow[700],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class Job {
  final String title;
  final String company;
  final String location;
  final String qualification;
  final String salary;
  final List<String> tags;

  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.qualification,
    required this.salary,
    required this.tags,
  });
}
