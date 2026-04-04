import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

//======= discounts ===========//
final discounts = [
  {
    'id': 1,
    'title': 'Buy for 20k for first time',
    'code': '1ST2D',
    'percentage': 30,
    'minAmount': 20000,
    'isActive': true,
    'firstTimeOnly': true,
    'valid_until': DateTime(2026, 4, 24).toIso8601String(),
    'rules': [
      'Use before expiration date',
      'Only for first purchase',
      'Cannot combine with other offers',
      'Applicable to all plants',
    ],
  },
  {
    'id': 2,
    'title': 'Summer Sale Offer',
    'code': 'SUMMER25',
    'percentage': 25,
    'minAmount': 15000,
    'valid_until': DateTime(2026, 5, 10).toIso8601String(),
    'isActive': true,
    'firstTimeOnly': false,
    'rules': [
      'Valid for Indoor plants only',
      'Cannot combine with other offers',
      'Limited time only',
    ],
  },
  {
    'id': 3,
    'title': 'Weekend Special',
    'code': 'WEEKEND15',
    'percentage': 15,
    'minAmount': 10000.0,
    'valid_until': DateTime(2026, 6, 1).toIso8601String(),
    'isActive': true,
    'firstTimeOnly': false,
    'rules': [
      'Valid only on weekends',
      'Minimum purchase required',
      'Applicable to all plants',
    ],
  },
];

//========== address in separate file ===============//

//========== plants ===============//
final plants = [
  {
    'id': 1,
    'name': 'Snake Plants',
    'price': 15000,
    'height': '1.5m',
    'category': 'Outdoor',
    'temperature': '60°F to 75°F',
    'pot': 'Ciramic Pot',
    'thumbnailImg': ImageStrings.snakePlant,
    'imageUrl': [ImageStrings.snakePlant],
    'description':
        'The snake plant is a hardy, low-maintenance indoor plant with striking leaves',
    'stock': 60,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Prefers bright, indirect sunlight. Can tolerate some direct morning sun.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Water only when the soil is completely dry. Overwatering may cause root rot.',
      },
      'humidity': {
        'title': 'Humidity',
        'description':
            'Does well in average indoor humidity. No misting required.',
      },

      'soil': {
        'title': 'Soil',
        'description': 'Use well-draining cactus or succulent soil mix.',
      },

      'petSafety': {
        'title': 'Pet Safety',
        'description': 'Toxic to pets if ingested.',
      },
    },
  },
  {
    'id': 2,
    'name': 'Peperomia Plant',
    'price': 22000,
    'height': '1.2m',
    'category': 'Indoor',
    'temperature': '50°F',
    'pot': 'Plastic Pot',
    'thumbnailImg': ImageStrings.peperomiaPlant,
    'imageUrl': [ImageStrings.peperomiaPlant],
    'description':
        'Peperomia are small, low-maintenance houseplants with varied, attractive leaves, thriving in indirect light and humidity.',
    'stock': 100,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Prefers bright, indirect sunlight. Can tolerate some direct morning sun.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Water only when the soil is completely dry. Overwatering may cause root rot.',
      },
      'humidity': {
        'title': 'Humidity',
        'description':
            'Does well in average indoor humidity. No misting required.',
      },

      'soil': {
        'title': 'Soil',
        'description': 'Use well-draining cactus or succulent soil mix.',
      },

      'petSafety': {
        'title': 'Pet Safety',
        'description': 'Toxic to pets if ingested.',
      },
    },
  },
  {
    'id': 3,
    'name': 'Areca Palm',
    'price': 33000,
    'height': '1.2m - 2m',
    'category': 'Indoor',
    'temperature': '18°C to 24°C',
    'pot': 'Plastic Pot',
    'thumbnailImg': ImageStrings.plamPlant,
    'imageUrl': [ImageStrings.plamPlant],
    'description':
        'Areca Palm is a popular indoor plant known for its feathery, arching green fronds that bring a tropical feel to any space. It is also known for improving indoor air quality and is easy to maintain.',
    'stock': 180,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Prefers bright, indirect sunlight. Avoid strong direct sunlight as it can burn the leaves.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Keep the soil lightly moist but not soggy. Water when the top inch of soil feels dry.',
      },
      'humidity': {
        'title': 'Humidity',
        'description':
            'Prefers moderate to high humidity. Occasional misting helps keep the leaves healthy.',
      },
      'soil': {
        'title': 'Soil',
        'description':
            'Use well-draining potting soil with good aeration, such as a mix for indoor plants.',
      },
      'petSafety': {
        'title': 'Pet Safety',
        'description':
            'Non-toxic to cats and dogs, making it a pet-friendly houseplant.',
      },
    },
  },
  {
    'id': 4,
    'name': 'Lush green dracena',
    'price': 15000,
    'height': '1.4m',
    'category': 'Gardening',
    'temperature': '60°F',
    'pot': 'Plastic Pot',
    'thumbnailImg': ImageStrings.lushGreen,
    'imageUrl': [ImageStrings.lushGreen],
    'description':
        'Green Echeveria agavoides is a compact, rosette-forming succulent with pointed, fleshy green leaves that resemble an agave.',
    'stock': 180,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Prefers bright, indirect sunlight. Can tolerate some direct morning sun.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Water only when the soil is completely dry. Overwatering may cause root rot.',
      },
      'humidity': {
        'title': 'Humidity',
        'description':
            'Does well in average indoor humidity. No misting required.',
      },

      'soil': {
        'title': 'Soil',
        'description': 'Use well-draining cactus or succulent soil mix.',
      },

      'petSafety': {
        'title': 'Pet Safety',
        'description': 'Toxic to pets if ingested.',
      },
    },
  },
  {
    'id': 5,
    'name': 'Monstera Deliciosa',
    'price': 22000,
    'height': '1m - 2m',
    'category': 'Gardening',
    'temperature': '18°C to 30°C',
    'pot': 'Plastic Pot',
    'thumbnailImg': ImageStrings.monsteraPlant,
    'imageUrl': [ImageStrings.monsteraPlant],
    'description':
        'Monstera Deliciosa, also known as the Swiss Cheese Plant, is a tropical houseplant famous for its large, glossy green leaves with natural splits and holes. It is a popular decorative plant that adds a lush, jungle-like feel to indoor spaces.',
    'stock': 180,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Thrives in bright, indirect sunlight. Can tolerate medium light but avoid harsh direct sun.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Water when the top 2–3 cm of soil feels dry. Avoid overwatering to prevent root rot.',
      },
      'humidity': {
        'title': 'Humidity',
        'description':
            'Prefers moderate to high humidity. Occasional misting helps keep leaves healthy.',
      },
      'soil': {
        'title': 'Soil',
        'description':
            'Use well-draining potting mix rich in organic matter, such as peat, perlite, and bark.',
      },
      'petSafety': {
        'title': 'Pet Safety',
        'description':
            'Toxic to cats and dogs if ingested due to calcium oxalate crystals.',
      },
    },
  },
  {
    'id': 6,
    'name': 'Pink Azalea',
    'price': 50000,
    'height': '60cm - 1.5m',
    'category': 'Flowering',
    'temperature': '15°C to 24°C',
    'pot': 'Plastic Pot',
    'thumbnailImg': ImageStrings.pinkAzalea,
    'imageUrl': [ImageStrings.pinkAzalea],
    'description':
        'Pink Azalea is a beautiful flowering shrub known for its vibrant pink blossoms and lush green foliage. It is commonly grown in gardens and patios, bringing bright seasonal color and elegance to outdoor spaces.',
    'stock': 180,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Prefers partial shade or filtered sunlight. Avoid strong afternoon sun.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Keep the soil consistently moist but not waterlogged. Azaleas dislike dry soil.',
      },
      'humidity': {
        'title': 'Humidity',
        'description': 'Prefers moderate humidity and good air circulation.',
      },
      'soil': {
        'title': 'Soil',
        'description':
            'Requires acidic, well-draining soil rich in organic matter such as peat moss.',
      },
      'petSafety': {
        'title': 'Pet Safety',
        'description':
            'Toxic to pets and humans if ingested due to grayanotoxins.',
      },
    },
  },
  {
    'id': 7,
    'name': 'Cherry Blossom',
    'price': 40000,
    'height': '3m - 8m',
    'category': 'Flowering',
    'temperature': '10°C to 25°C',
    'pot': 'Plastic Pot',
    'thumbnailImg': ImageStrings.cherryBlosom,
    'imageUrl': [ImageStrings.cherryBlosom],
    'description':
        'Cherry Blossom is a famous ornamental tree known for its stunning pink or white flowers that bloom in spring. These delicate blossoms create breathtaking landscapes and symbolize beauty and renewal.',
    'stock': 180,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Requires full sunlight for healthy growth and abundant flowering.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Water regularly, especially during dry periods. Keep the soil moist but well-drained.',
      },
      'humidity': {
        'title': 'Humidity',
        'description': 'Prefers moderate humidity with good air circulation.',
      },
      'soil': {
        'title': 'Soil',
        'description':
            'Thrives in well-draining, fertile soil with slightly acidic to neutral pH.',
      },
      'petSafety': {
        'title': 'Pet Safety',
        'description':
            'Seeds, leaves, and stems can be toxic to pets if ingested.',
      },
    },
  },
  {
    'id': 8,
    'name': 'Hanging Plant',
    'price': 20000,
    'height': '20cm - 60cm',
    'category': 'Hanging',
    'temperature': '18°C to 28°C',
    'pot': 'no pot',
    'thumbnailImg': ImageStrings.hangingPlant,
    'imageUrl': [ImageStrings.hangingPlant],
    'description':
        'Hanging plants are beautiful trailing houseplants that grow gracefully from hanging baskets or pots. Their cascading vines make them perfect for decorating balconies, windows, and indoor spaces.',
    'stock': 180,
    'careGuide': {
      'light': {
        'title': 'Light',
        'description':
            'Prefers bright, indirect sunlight. Can tolerate low to medium light conditions.',
      },
      'water': {
        'title': 'Water',
        'description':
            'Water when the top layer of soil feels dry. Avoid overwatering to prevent root rot.',
      },
      'humidity': {
        'title': 'Humidity',
        'description':
            'Prefers moderate humidity but adapts well to normal indoor conditions.',
      },
      'soil': {
        'title': 'Soil',
        'description':
            'Use well-draining indoor potting mix with good aeration.',
      },
      'petSafety': {
        'title': 'Pet Safety',
        'description':
            'Pet safety depends on the specific plant variety. Some hanging plants may be toxic to pets.',
      },
    },
  },
];
