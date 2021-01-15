import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void loadData() {
    for (var x in information.keys) {
      firestore
          .collection('landmark_information')
          .add({'landmark_name': x, 'landmark_data': information[x]});
    }
  }

  Map information = {
    'petronas_towers': [
      'The Petronas Towers, also known as the Petronas Twin Towers are twin skyscrapers in Kuala Lumpur, Malaysia they were the tallest buildings in the world from 1998 to 2004 when they were surpassed by Taipei 101. The Petronas Towers remain the tallest twin towers in the world.',
      'Each tower is 88 storeys high and stand at a height of 452 meters, weigh 300k tones which is equivalent to about 42,857 adult elephants and both towers have a 395,000sqm build-up area.',
      'The towers were designed by Argentine architect César Pelli and costed 1.6 billion USD and it took 6 years of construction from foundation to opening where: \n Construction started: 1 March 1993\n Construction Completed:	1 March 1996\n Opened: 31 August 1999',
      'The petronas towers have the worlds largest foundation 120m deep under the ground which was completed within 12 months by Bachy Soletanche.',
      'Each tower has an observation deck at the 86th floor which allows visitors to enjoy a spectacular bird`s eye view from 370 meters above the ground.',
      'A Sky Bridge connects the two towers on Level 41 and 42 Interestingly, the skybridge is not fully attached to the main building - engineers deliberately designed the skybridge this way to give allowance for small movements during high winds and other unpleasant weathers. The bridge is 58.4 meters long and stands at 170 meters above the ground.'
    ],
    'hofburg_palace': [
      'The Hofburg is the official residence and workplace of the President of Austria and was formerly the principal imperial palace of the Habsburg dynasty.',
      'Located in the center of Vienna, it was built in the 13th century and expanded several times afterwards. It also served as the imperial winter residence, as Schönbrunn Palace was the summer residence.',
      'The name translates as "Castle of the Court", which denotes its origins when initially constructed during the Middle Ages. Initially planned in the 13th century as the seat of the Dukes of Austria.',
      'The palace expanded over the centuries, as they became increasingly powerful. From 1438 to 1583, and again from 1612 to 1806, it was the seat of the Habsburg kings and emperors of the Holy Roman Empire, and thereafter until 1918 the seat of the Emperors of Austria. Since then the palace has continued in its role as the seat of the head of state and is today used by the Austrian Federal President.',
      'Hofburg palace extends over 240,000 m² consists of 18 wings, 19 courtyards and 2,600 rooms in which nearly 5,000 people still work and live today.',
      'The Sisi museum in Hofburg Palace shows a deeper insight into the life of empress Elisabeth where numerous personal items that once belonged to Elisabeth are on display.',
      'Among the 300 objects on display in the Sisi museum are parasols, fans and gloves, items of clothing, beauty preparations, her milk glass with its travelling case, her travelling medicine chest and even the original death certificate.'
    ],
    'temple_of_aphrodite': [
      'The Temple of Aphrodite at Acrocorinth was a sanctuary in Ancient Corinth dedicated to the goddess Aphrodite. It was the main temple of Aphrodite in Corinth, and famous for its alleged temple prostitution.',
      'The goddess Aphrodite was the protector deity of the city of Corinth. She had at least three sanctuaries in the city; the temple of Aphrodite at the Acrocorinth, the temple of Aphrodite II, and the Temple of Aphrodite Kraneion, as well as one temple at Leachaion and one at Cenchreae. It was however the Aphrodite temple of Acrocorinth that was the most famous one.',
      'The temple was constructed in the 5th-century BC. It was situated at the top peak of the Acrocorinth. According to the myth, the Acrocorinth had been given to Aphrodite by Poseidon. It was a small building, 10 by 16 metres. It contained a famous statue of Armed Aphrodite, dressed in armour and holding a shield before herself as a mirror.',
      'The later history of the temple is not clearly established. In 146 BC, the city of Ancient Corinth was destroyed, and many of the sanctuaries atop the Acrocorinth was, if not destroyed, so deserted. When the city of Roman Corinth was established in 44 BC, many of the former sanctuaries were rebuilt, such as the Temple of Apollo and the Sanctuary of Demeter and Kore on Acrocorinth. It appears that the Temple of Aphrodite at Acrocorinth was also rebuilt. It appears on many coins from the Roman era.',
      'The remains of the temple were used as a part of a church in the 5th century.'
    ],
    'leifeng_pagoda': [
      'Lei Feng pagoda was constructed in 975 at the order of Qian Hongchu, the King of Wuyue Kingdom to celebrate the birth of a son by one of his favorite concubines - Huangfei. It was therefore called Huangfei Pagoda at that time. Since the pagoda was located outside the west gate of the city, it was also known as the Brick Pagoda of West Gate. All those names, however, have been forgotten over the years; only the name Leifeng Pagoda has been passed on from generation to generation.',
      'Leifeng Pagoda was an octagonal, five-storeyed structure built of brick and wood. The body of the pagoda was made of brick, but the eaves, balconies, inside landings and balustrades were made of wood. Stones with the Huayan Scriptures inscribed on them were inlaid on the inner walls of the pagoda. There used to be sixteen sculptures of vajra arhats at the foot of the pagoda, but they were later moved to Jingci Temple.',
      'The pagoda became a household name in China thanks to the popular folk tale, "The Legend of the White Snake", a touching love story about a girl who changed into a snake and a young man. The story has been repeatedly adapted for traditional operas and also for modern movies and TV series.',
      'In the story, the couple are separated by an evil old monk with magical powers, who had the snake girl imprisoned under the Leifeng Pagoda for years. She is finally rescued by her son who caused the collapse of the pagoda.',
      'In real life, the pagoda also had a sad history. During the Yuan Dynasty it was a magnificent building "of ten thousand chi" standing "aloft as if in midair." It suffered a most severe disaster during the Ming Dynasty. During the Jiaqing years (1522-66) Japanese invaders set fire to the pagoda and burned the coves, balconies, balustrades and steeple to ashes, leaving only a brick skeleton.',
      'Later some superstitious and ignorant people often took bricks from the pagoda in the belief that the abrasive powder of the bricks was a magic remedy that could cure all diseases and keep a foetus from aborting. Others stole Buddhist scriptures from the pagoda in order to make money. Finally, in August 1924 the foot of the pagoda was dug hollow and other parts of the pagoda were so severely damaged that the ancient pagoda suddenly collapsed.',
      'In November, 2000, the Hangzhou Municipal People\'s Government declared that it was going to rebuild Lei Feng Pagoda. And the construction was completed in October, 2002.',
      'The current Leifeng Pagoda is comprised of three parts: the pedestal, the body part, and the top. The octagonal pagoda is 72 meters high. The two-storey pedestal is 10 meters , the five-storey body part is 46 meters, and the top is 18 meters . The body part has a side length of 11 meters , a diameter of 28 meters and a girth of 88 meters . It covers a total area of 3,133 square meters . Inside the tower are two elevators which can carry tourists to the top.'
    ],
    'rialto_bridge': [
      'Rialto Bridge, Italian Ponte di Rialto, stone-arch bridge crossing over the narrowest point of the Grand Canal in the heart of Venice.',
      'Built in the closing years of the 16th century, the Rialto Bridge is the oldest bridge across the canal and is renowned as an architectural and engineering achievement of the Renaissance. It was designed and built by Antonio da Ponte and his nephew, Antonio Contino, following a design competition in the city.',
      'The first bridge at that location, known as Ponte della Moneta, was a wooden pontoon bridge designed in 1178 by Nicolò Barattieri. The structure was rebuilt in 1255 and 1264 and, following a number of collapses, was eventually replaced by the Rialto Bridge to provide better access to Rialto, the primary financial centre of Venice.',
      'The bridge served as the only fixed structure crossing the Canal until the 1850s; prior to that, pedestrian crossings at other locations were done by gondola ferries.',
      'The Rialto Bridge consists of a single stone-arch span that supports a broad rectangular deck carrying two arcades of shops fronting on three roadways. The lower chord of the bridge is only 25 metres in length, while the width 20 metres.',
      'To support the wide stone arch in the soft alluvial soil, 6,000 timber piles were driven under each abutment, and the bed joints of the stones were placed perpendicular to the thrust of the arch.',
    ],
    'royal_ontario_museum': [
      'The Royal Ontario Museum is a museum of art, world culture and natural history .It is one of the largest museums in North America and the largest in Canada. It attracts more than one million visitors every year, making the ROM the most-visited museum in Canada.',
      'The Royal Ontario Museum was formally created by the signing of the ROM Act in the Ontario Legislature on April 16, 1912. When the Duke of Connaught, then Governor-General of Canada, opened the new building to the public at 3:00 pm on March 19, 1914, it instantly became an object of pride for Toronto.',
      'The museum has maintained close relations with the University of Toronto throughout its history, often sharing expertise and resources.The museum was under the direct control and management of the University of Toronto until 1968, when it became an independent Crown agency of the Government of Ontario. Today, the museum is Canada\'s largest field-research institution, with research and conservation activities around the world.',
      'With more than 6,000,000 items and 40 galleries, the museum\'s diverse collections of world culture and natural history contribute to its international reputation.The museum contains a collection of dinosaurs, minerals and meteorites; Canadian, and European historical artifacts; as well as African, Near Eastern, and East Asian art. It houses the world\'s largest collection of fossils from the Burgess Shale with more than 150,000 specimens.The museum also contains an extensive collection of design and fine art, including clothing, interior, and product design, especially Art Deco.',
      'A \$55 million renovation was begun in 1978, intended to provide for the greatly extended research and collection activities and included a new curatorial centre, a new library and other facilities. Her Majesty Queen Elizabeth officially opened the new exhibition and gallery space, the Terrace Galleries, in a 1984 ceremony.',
      'On June 3, 2007, the ROM opened the Michael Lee-Chin Crystal,the extension provides 100,000 square feet of new exhibition space, a new entrance and lobby, a street level retail shop and three new restaurants. The Crystal generated a 44% increase in visitors in its first year and transformed the ROM’s fortress-like character, turning it into an inspired atmosphere dedicated to the resurgence of the Museum as the dynamic center of Toronto.'
    ],
    'poznan_cathedral': [
      'The Archcathedral Basilica of St. Peter and St. Paul in Poznań is one of the oldest churches in Poland and the oldest Polish cathedral, dating from the 10th century. It stands on the island of Ostrów Tumski north-east of the city centre.',
      'The original edifice was erected way, way back in 968, but has subsequently been razed, rebuilt, and remodelled numerous times over the centuries, each resulting in the addition of a new architectural style: a 1622 fire led to a Baroque finish, while a 1722 fire ushered in a change to neo-Classicism. During the 1945 battle to liberate Poznań, 65 percent of the Cathedral once again burned down, exposing the building’s buried Gothic elements and leading to its restoration in the style visitors see today.',
      'Inside the Cathedral are a number of elements of interest. Surrounding the interior are twelve different chapels, including the Chapel of the Holy Sacrament, which has several outstanding examples of Renaissance art (the tombstones of the Górka family and Bishop Benedykt Izbieński, to be specific) and the Baroque altar houses a miraculous crucifix brought to the Cathedral from the former Wrocławska town gate.',
      'The Golden Chapel was designed as the mausoleum of the first Polish monarchs and houses the sarcophagi of kings Mieszko I and Bolesław Chrobry; the two kings are also depicted in a bronze monument together, above which is a painting by January Suchodolski showing Mieszko I, the instigator of Catholicism in Poland, destroying pagan idols. The chapel is indeed thoroughly golden, but to fully admire the glitz you must drop a coin into an absurd contraption, whereupon the illumination will come on.',
      'The eye-catching high altar at the centre of the Cathedral is a 14th/15th polyptych depicting Our Lady surrounded by 14 female saints, while the outer wings feature eight paintings depicting the Passion of the Christ. The Cathedral’s lavish Baroque pulpit is equally stunning and dates to 1720.',
      'The Cathedral’s five Gothic and early Renaissance bronze tomb slabs, which originated at the famed Nuremburg workshop of Herman and Peter Vischer. The slabs were originally on the Cathedral floor to cover the entrances to tombs, but were later mounted on pillars and chapel walls. Stolen during the war, the slabs were returned to Poznań in 1993 and are back on display.',
      'One of the newer elements of Poland’s oldest Cathedral is the giant 52-pipe organ at the rear of the building, which perfectly frames the large stained glass window.',
      'The Cathedral’s crypt is certainly worth a look. Visitors can feast their eyes on the remains of the pre-Romanesque and Romanesque versions of the Cathedral and a 10th century baptismal font most likely used to baptise the first Polish sovereign and his subjects.'
    ],
    'castel_nuovo': [
      'The Castel Nuovo (or Maschio Angioino) is one of the most famous and important symbols of the city of Naples. It majestic architecture, facing the deep blue Mediterranean Sea, has been part of the history of Naples over the last eight centuries, silently witnessing the constant succession of men who have made the history of the city great.',
      'Named Castrum Novum (New Castle) to distinguish it from the other two royal residences of Naples (Castel dell’Ovo and Castel Capuano), this huge Neapolitan medieval fortress was built in between 1279 and 1284, according to Charles I of Anjou’s wishes, who upon taking over Naples in the 13th century, launched a great construction plan to expand the city and the port area.',
      'Later, during the kingdom of Robert of Anjou, the castle became a popular cultural centre for the time by giving hospitality to leading intellectuals, doctors and artists like Giotto, Petrarch and Boccaccio.',
      'There, in the 14th century, the brilliant court of King Robert welcomed Petrarch and Boccaccio, and Giotto was summoned to execute frescoes (now lost).',
      'The castle was embellished by Alfonso V of Aragon (Alfonso I of Naples), whose triumphal entry into Naples in 1443 supplies the theme of magnificent Renaissance sculptures over the west entrance.',
      'The nowadays castle, however, is the result of the a meticulous restoration plan and clearance works of the early years of the 20th century when the Municipal Council began to isolate again the castle from the surrounding buildings in recognition of the historical and monumental importance of the fortress.',
      'The castle is nowadays the venue of cultural events and it houses the Municipal Museum of Naples arranged on several floors that includes sculptures, paintings and objects ranging from the medieval period to the late 19th century.'
    ],
    'wat_chedi_luang': [
      'One of Thailand’s oldest temples, Wat Chedi Luang has witnessed war, revolution, natural disasters and the succession of multiple dynasties. Dating back over 700 years, it’s as ancient as the great ruins of Ayutthaya and Sukhothai, making it one of Northern Thailand\'s most important historical, cultural and religious sites.',
      'Wat Chedi Luang was designed and built by King Saen Muang Ma somewhere between the late 1300s and early 1400s to house the ashes of his beloved father. Its history has been a troubled one: a devastating earthquake in 1545 toppled the central chedi, reducing the spire from 80 to 60 meters in height. Even so, the Wat remains one of Chiang Mai’s highest points and it\'s hard not to wonder how much more impressive it must have been in its heyday.',
      'The uneven, jagged roof has remained unchanged since the earthquake almost 500 years ago, but renovation work completed in the 1990s restored much of the elaborate stonework and Buddhist imagery embellishing the central tower.',
      'The detailed serpents and elephants flanking the temple today are carefully designed to replicate the site’s original 14th century decor, providing a faithful vision of Chiang Mai’s distant past.',
      'For locals, one of the most popular times to visit Wat Chedi Luang is Visakha Buja, a ceremony celebrating the birth, enlightenment and death of the Buddha. On this day, Buddhists hold an awe-inspiring candle ceremony here, adorning the temple grounds with colorful votive offerings in the form of food and flowers.',
      'Today, a remarkable emerald Buddha can be seen in the main temple. This is a replica of the original holy relic, which was taken from the site several hundred years ago and moved to Luang Prabang in Laos. Later still, it was moved to Bangkok where it now resides inside Wat Phra Kaew'
    ],
    'beamless_brick_hall': [
      'The Beamless Brick Hall was built in 1600 by Wanli Emperor to congratulate the birthday of his mother.',
      'It is 17.12-metre high, 15.79-metre wide and 16.06-metre long. Inspired by techniques and styles of India and Myanmar with not a single piece of wood was used.'
          'Walls of the hall are decorated with patterns of wood-like structures like circular arches, vertical columns, window lattices, etc. On the dome there are five white pagodas and statues of four auspicious animals. With the ancient style, the walls of dome were carved with small statues of Buddha, which were called "Thousand Buddha Worshiping Samantabhadra"',
      'There are closets for enshrining God Buddha on the four walls inside the hall, divided into two parts, the lower part has 24 closets enshrined an iron Buddha inside them respectively, the upper part has 6 horizontal God cupboards put 307 smaller bronze Buddha statues. The smaller bronze Buddha and the iron Buddha are all worthy to appreciate, solemn, auspicious and happy.',
      'A bronze statue of Samantabhadra riding a white elephant is placed under the dome. It is 7.35-metre high and weighs 62 tons. The statue was cast in 980, during the 5th year of Taiping Xingguo period of the Northern Song dynasty (960–1127). Sitting on the lotus throne, Samantabhadra wears a golden crown on the head and holds a Ruyi, his mount is also standing on four lotus platforms.'
    ]
  };
}
