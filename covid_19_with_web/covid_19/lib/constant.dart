import 'package:flutter/material.dart';
import 'package:covid_19/moreInformationDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final aboutCovid19 = new MoreInformationDataModel(
    id: 0,
    title: "What is COVID-19?",
    subTitle:
        "COVID-19 is the new respiratory disease spreading around the world and it is caused by a coronavirus. COVID-19 is short for coronavirus disease 2019. ",
    description:
        "The virus is thought to spread mainly between people who are in close contact with one another (about 6 feet) and through respiratory droplets produced when an infected person coughs or sneezes.\n\nPeople are most contagious when they are the sickest. But those who don’t have a lot of symptoms can still pass the virus on to others.\n\nThere is currently no vaccine or cure for COVID-19 but researchers are working to find one.",
    backgroundColor: Colors.blue[200],
    imageName: 'assets/img/virus.png');

final covid19Symptom = new MoreInformationDataModel(
    id: 1,
    title: "What are COVID-19’s symptoms?",
    subTitle:
        "The most common symptoms are very similar to other viruses: fever, cough, and difficulty breathing.",
    description:
        "Common symptoms of COVID-19 are changing as more is learned about the disease. For the most up to date symptom list, visit the CDC’s website.\n\nSymptoms may appear 2 to 14 days after exposure and range from mild to severe illness.\n\nIf you or someone you know has symptoms, our Screening Tool will recommend best next steps.",
    backgroundColor: Colors.green[200],
    imageName: 'assets/img/symptoms.png');

final covid19HighRisk = new MoreInformationDataModel(
    id: 2,
    title: "Who is at high risk for COVID-19?",
    subTitle:
        "Everyone is at risk of getting COVID-19, but some people are at a higher risk of serious illness.",
    description:
        "Generally speaking, adults aged 65 and older and people of any age who have heart disease, lung disease, and diabetes with complications (such as, but not limited to, kidney disease, heart disease, and neuropathy) may be at higher risk for serious illness from COVID-19.\n\nThe most up-to-date way to assess your risk is to complete our Screening Tool.",
    backgroundColor: Colors.purple[200],
    imageName: 'assets/img/man.png');

final covid19Doctor = new MoreInformationDataModel(
    id: 3,
    title: "When should I see a doctor?",
    subTitle:
        "Knowing when to see a doctor can keep medical care available for those who need it most.",
    description:
        "Most mild symptoms can be treated at home. The most up-to-date way to assess your best next steps is to complete our Screening Tool.\n\nIf you have mild symptoms, call your doctor before going into their office. Many physicians’ offices are doing virtual visits. They will tell you what to do based on your location.\n\nTesting is limited-availability across the country and is currently being prioritized for healthcare workers, emergency medical service providers, police, and other essential workers, so please consult your doctor for availability in your local area.\n\nIf you develop emergency warning signs, call 911. Main emergency warning signs include: persistent chest pain or pressure; extreme difficulty breathing; severe, constant dizziness or lightheadedness; slurred speech; and difficulty waking up.",
    backgroundColor: Colors.orange[200],
    imageName: 'assets/img/doctor.png');

final washingYourHands = new MoreInformationDataModel(
    id: 4,
    title: "Washing Your Hands",
    subTitle:
        "Washing your hands is the best way to help you stay healthy. Here’s how to do it.",
    description:
        "Wet your hands with clean, running water. Turn off the tap and apply soap.\n\nLather your hands by rubbing them together. Get the backs of your hands, between your fingers, and under your nails.\n\nScrub your hands for 20 seconds. Sing “Happy Birthday” twice while washing to gauge your timing.\n\nRinse your hands under clean, running water. Air dry or use a clean towel.\n\nNo soap or water? Use hand sanitizer that contains at least 60 percent alcohol. Apply the gel to the palm of one hand. Rub your hands together over all of your hands’ surfaces and fingers until your hands are dry.\n\nAvoid touching your face and eyes.",
    backgroundColor: Colors.blue[200],
    imageName: 'assets/img/washinghands.png');

final isolateYourselfFromOthers = new MoreInformationDataModel(
    id: 5,
    title: "Isolate Yourself from Others",
    subTitle:
        "If you have confirmed or possible COVID-19 or have symptoms, isolate yourself in your home to protect others.",
    description:
        "Stay home. Monitor your symptoms and if they get worse, contact your doctor immediately.\n\nDo your best to stay away from your other household members, including pets. Designate a room for your use only. Ideally use your own bathroom, too.\n\nWash your hands frequently. If you cough or sneeze, cover your mouth and nose with a tissue. Discard the tissue and immediately wash your hands. Avoid sharing personal items such as dishes, towels, and bedding with other people in your house. Clean and disinfect frequently used surfaces often. Wash laundry frequently.\n\nHave a household member or friend run errands for you like picking up groceries or prescriptions.\n\nWear a mask if you have to be around other people. If you can’t find a mask, create one from a garment like a scarf. If you can’t wear a mask because of difficulty breathing, make sure caregivers wear one around you.\n\nYou can leave your house to receive medical care, but don’t take the bus, subway, or taxi.",
    backgroundColor: Colors.green[200],
    imageName: 'assets/img/isolate.png');

final socialDistancing = new MoreInformationDataModel(
    id: 6,
    title: "Social Distancing",
    subTitle:
        "The main way COVID-19 spreads is between people. Social distancing helps to stop the spread.",
    description:
        "Avoid physical contact with other people.\n\nStay at least 6 feet away from people when outside your home.\n\nDo not invite guests over to your house.\n\nAvoid large groups.\n\nStay home if you’re sick.",
    backgroundColor: Colors.purple[200],
    imageName: 'assets/img/socialdistancing.png');

final symptomMonitoring = new MoreInformationDataModel(
    id: 7,
    title: "Symptom Monitoring",
    subTitle:
        "Observe your COVID-19 symptoms for 14 days if you suspect you have the disease, have been around someone who has tested positive for it, or you’ve been diagnosed.",
    description:
        "First, seek emergency care right away if you develop emergency warning signs, which include: persistent chest pain or pressure; extreme difficulty breathing; severe, constant dizziness or lightheadedness; slurred speech; and difficulty waking up.\n\nHave your medical provider’s contact information on hand.\n\nKeep a log of your symptoms, including your temperature.\n\nIf your symptoms worsen, call your doctor immediately to update them and they will tell you what to do next. Complete our Screening Tool to help you determine next steps based on your symptoms and risk factors.",
    backgroundColor: Colors.orange[200],
    imageName: 'assets/img/symptoms.png');

final cleaningAndDisinfectingSurfaces = new MoreInformationDataModel(
    id: 8,
    title: "Cleaning and Disinfecting Surfaces",
    subTitle:
        "Commonly used surfaces should be regularly cleaned and disinfected.",
    description:
        "It’s always a good idea to routinely clean and disinfect frequently touched surfaces like tables, doorknobs, light switches, handles, desks, toilets, faucets, and sinks. But if you have a suspected or confirmed case of COVID-19, be vigilant about doing this daily.\n\nFirst, clean dirty surfaces with soap and water. Cleaning will remove dirt and lower the number of germs—but it will not kill germs.\n\nNext, disinfect surfaces to kill germs. Disinfecting after cleaning can further lower the risk of spreading an infection. Most common EPA-registered household disinfectants will work. Or dilute your household bleach with 1/3 cup of bleach per gallon of water.\n\nWear dedicated gloves for COVID-19 related cleaning and disinfecting or use disposable gloves and discard them after each use.",
    backgroundColor: Colors.orange[200],
    imageName: 'assets/img/clean.png');

enum MoreInformationOption { 
   about, 
   whatYouanDo, 
   preventAndManagment, 
}

enum CaseType {
  totalCases,
  totalDeath,
  totalRecoved,
  totalCritical,
  affectedCountries,
  active,
}

 String getFormattedString(String value) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
      String result = value.replaceAllMapped(reg, mathFunc);
    return result;
  }


  Future<void> updateFavCountryStatus(String countryCode) async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> countryList = prefs.getStringList('countries');

        if(countryList == null) {
          countryList = List<String>();
        } 
        if(countryList.contains(countryCode) == false) {
          countryList.add(countryCode);
        } else {
          countryList.remove(countryCode);
        }
        prefs.setStringList('countries', countryList);
  }

  Future<List<String>> getFavCountryList() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> countryList = prefs.getStringList('countries');
        return countryList;

  }

   Future<bool> isFav(String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> countryList = prefs.getStringList('countries');

        if(countryList == null) {
          return false;
        }

        if(countryList.contains(countryCode) == true){
          return true;
        }
          
        return false;

  }