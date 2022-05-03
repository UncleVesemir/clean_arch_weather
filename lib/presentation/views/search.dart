import 'package:clean_arch_weather/presentation/widgets/city_item.dart';
import 'package:clean_arch_weather/styles_const.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainMid,
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 8),
        child: Column(
          children: [
            SizedBox(
              height: 65,
              child: Card(
                elevation: 15,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      right: 18.0,
                      top: 10,
                      bottom: 10,
                    ),
                    child: TextFormField(
                      style: AppTextStyles.search,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter city name...',
                        hintStyle: AppTextStyles.searchHint,
                        suffixIcon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: const [
                  CityItem(
                    city: 'city',
                    windSpeed: 20.0,
                    temperature: 13,
                    humidity: 20.2,
                  ),
                  SizedBox(height: 10),
                  CityItem(
                    city: 'city',
                    windSpeed: 20.0,
                    temperature: 13,
                    humidity: 20.2,
                  ),
                  SizedBox(height: 10),
                  CityItem(
                    city: 'city',
                    windSpeed: 20.0,
                    temperature: 13,
                    humidity: 20.2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
