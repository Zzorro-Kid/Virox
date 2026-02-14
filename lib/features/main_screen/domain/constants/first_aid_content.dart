import '../entities/first_aid_type_data.dart';
import '../entities/first_aid_content_data.dart';

const firstAidContent = [
  FirstAidContentData(
    category: FirstAidTypeData.eye,
    title: 'Eye',
    videoUrl: '',
    videoThumbnail: '',
    description:
        'What do you do if you get a cleaning spray or the oil from poison '
        'ivy in your eye? Maybe you accidentally got hydrogen peroxide or '
        'brake cleaner in your eye. Are you prepared? Injuries like these '
        "happen every day, and it's important to know the basic first aid "
        'for an eye exposure.',
    instructions: [
      'Wash your hands to make sure they are clean of any other substances before removing contact lenses and flushing the eye.',
      'Flush your eye(s) with lukewarm water for 5-10 minutes.',
      'Have the patient blink as much as possible during flushing. Do not force eyelids open.',
      'Call the Missouri Poison Center right away at 1-800-222-1222 to receive further treatment advice. If possible, have the bottle and/or name of the chemical or poison that entered your eye available.',
    ],
    importantNote:
        'If you are wearing contact lenses, immediately remove them from '
        'your eye(s). Contacts can hold the chemical or poison against your '
        'cornea, which can cause serious injury.',
  ),
  FirstAidContentData(
    category: FirstAidTypeData.inhaled,
    title: 'Inhaled',
    videoUrl: '',
    videoThumbnail: '',
    description:
        'Exposure to poisonous fumes can happen at search_screen or in the workplace. '
        'Mixing certain substances can cause an unplanned chemical reaction '
        'that releases toxic fumes into the air. Similarly, working with '
        'cleaning products for a long time can begin to irritate the lungs. '
        'Understand what symptoms to look for as signs of poisoning and when '
        'to call to get help to treat an inhaled chemical poisoning.',
    instructions: [
      'Open windows and doors, and turn on the fans in the room if possible to ventilate the area.',
      'Leave the area and go outside to get fresh air.',
      'There may be some symptoms that are not treated from fresh air alone. If you or someone else continues to experience: Coughing or chest congestion after fresh air, additional treatment may be needed. The poison center can assist with further advice. Throat irritation, drink a glass of cold water or milk. Eye irritation, flush your eyes with lukewarm water for 5-10 minutes.',
      'Call the Missouri Poison Center at 1-800-222-1222 to talk to a specially trained nurse or pharmacist for more advice.',
    ],
    importantNote:
        "Poisonous fumes aren't always detectable by our noses like carbon "
        "monoxide (CO), which is odorless, colorless, and tasteless. It's "
        'important to install CO alarms to help keep you and your family safe.',
  ),
  FirstAidContentData(
    category: FirstAidTypeData.swallowed,
    title: 'Swallowed',
    videoUrl: '',
    videoThumbnail: '',
    description:
        'Ingested poison can be anything from swallowing hand sanitizer or '
        'berries to chemicals or medication. What steps should you take if '
        'someone swallows bleach, paint thinner, or another toxic substance? '
        'Some poisonous substances can act quickly once ingested. When someone '
        'swallows poison, it is best to stay calm and call for poison help.',
    instructions: [
      'Call 911 if the person is unconscious, having seizures, or has trouble breathing.',
      'Do not induce vomiting and do not give them anything to drink.',
      'Wipe out their mouth with a damp cloth and or let them rinse their mouth out with water.',
      'If the person is awake and alert, call the Missouri Poison Center at 1-800-222-1222 for further treatment advice. Be prepared with important information such as the individual\'s name, age, weight, and condition. If possible, bring the bottle or packaging to the phone.',
    ],
    importantNote:
        'Do not wait for symptoms to start before calling the poison center. '
        'Fast, free confidential assistance is available 24/7/365.',
  ),
  FirstAidContentData(
    category: FirstAidTypeData.skin,
    title: 'Skin',
    videoUrl: '',
    videoThumbnail: '',
    description:
        'Do you know how to treat an exposure to substances like bleach, '
        'acetone, or acid? Proper first aid can prevent irritation or a '
        'chemical burn. Learn how to handle this type of contact injury '
        'with these basic first aid tips for poisoning on the skin.',
    instructions: [
      'Remove any jewelry or clothing that could have been contaminated by the chemical.',
      'Rinse the affected area with cool water to get off any of the leftover chemicals for at least 10 minutes. For dry chemicals, brush off any remaining chemicals before rinsing with water.',
      'After rinsing, wash the area gently with soap and water.',
      'Call the Missouri Poison Center at 1-800-222-1222 to talk to a specially trained nurse or pharmacist for more treatment advice.',
    ],
    importantNote:
        'Some chemical burns you may notice instantly, while others can take '
        "hours to develop after exposure. If you think your skin has been exposed "
        "to a poison, but don't see any symptoms, call the Missouri Poison Center "
        'for guidance.',
  ),
];