import 'package:flutter/material.dart';

class PlantInfoWithIcons extends StatelessWidget {
  const PlantInfoWithIcons({super.key, required this.plantData});

  final Map<String, Object> plantData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.height, size: 34),
              Text(
                'Height',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                plantData['height'] as String,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.device_thermostat_outlined, size: 34),
              Text(
                'Temperature',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                plantData['temperature'] as String,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.inventory_2_outlined, size: 34),
              Text(
                'Pot',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                plantData['pot'] as String,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
