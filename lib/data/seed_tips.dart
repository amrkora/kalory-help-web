// Daily nutrition & health tips sourced from WHO, NHS, Harvard Health,
// Mayo Clinic, AHA, and other authoritative public-health organizations.
// Tips rotate on a 500-day cycle based on the current day number.

/// Returns the tip for today based on a fixed epoch cycle.
/// The epoch (2025-01-01) must never change once deployed.
Map<String, String> getTodaysTip() {
  final epoch = DateTime(2025, 1, 1);
  final today = DateTime.now();
  final dayIndex = today.difference(epoch).inDays % seedTips.length;
  return seedTips[dayIndex];
}

const List<Map<String, String>> seedTips = [
  // ── Hydration (1–20) ──────────────────────────────────────────────────
  {
    'text': 'Adults should aim for 6–8 glasses of fluid per day; water, lower-fat milk, and sugar-free drinks all count.',
    'text_ar': 'يجب أن يهدف البالغون إلى شرب 6-8 أكواب من السوائل يومياً؛ ويُحتسب الماء والحليب قليل الدسم والمشروبات الخالية من السكر.',
    'source': 'NHS',
  },
  {
    'text': 'Even mild dehydration of 1–2% body weight loss can impair concentration, mood, and memory.',
    'text_ar': 'حتى الجفاف الخفيف بفقدان 1-2% من وزن الجسم يمكن أن يُضعف التركيز والمزاج والذاكرة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Thirst is not always a reliable early indicator of dehydration — check your urine colour instead; pale straw is ideal.',
    'text_ar': 'العطش ليس دائماً مؤشراً مبكراً موثوقاً على الجفاف — تحقق من لون البول بدلاً من ذلك؛ اللون الأصفر الباهت هو المثالي.',
    'source': 'NHS',
  },
  {
    'text': 'Water makes up about 60% of adult body weight and is involved in every metabolic process.',
    'text_ar': 'يشكّل الماء نحو 60% من وزن جسم البالغين ويشارك في كل عملية أيضية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Drinking a glass of water before meals may help reduce overall calorie intake at that meal.',
    'text_ar': 'شرب كوب من الماء قبل الوجبات قد يساعد في تقليل إجمالي السعرات الحرارية المتناولة في تلك الوجبة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Caffeinated drinks like tea and coffee count toward your daily fluid intake, despite a mild diuretic effect.',
    'text_ar': 'المشروبات التي تحتوي على الكافيين كالشاي والقهوة تُحتسب ضمن استهلاك السوائل اليومي، رغم تأثيرها المدر الخفيف للبول.',
    'source': 'NHS',
  },
  {
    'text': 'During exercise, drink water before, during, and after — about 200 ml every 15–20 minutes of activity.',
    'text_ar': 'أثناء التمرين، اشرب الماء قبله وأثناءه وبعده — نحو 200 مل كل 15-20 دقيقة من النشاط.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Fruits and vegetables with high water content (cucumber, watermelon, oranges) contribute to daily hydration.',
    'text_ar': 'الفواكه والخضراوات ذات المحتوى المائي العالي (الخيار، البطيخ، البرتقال) تساهم في الترطيب اليومي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'In hot weather or during illness with fever, increase fluid intake above your usual baseline.',
    'text_ar': 'في الطقس الحار أو أثناء المرض المصحوب بحمى، زِد استهلاك السوائل فوق المعدل المعتاد.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Older adults are at higher risk of dehydration because the thirst mechanism weakens with age.',
    'text_ar': 'كبار السن أكثر عرضة للجفاف لأن آلية العطش تضعف مع التقدم في العمر.',
    'source': 'NHS',
  },
  {
    'text': 'Sparkling water is just as hydrating as still water and counts equally toward daily intake.',
    'text_ar': 'المياه الغازية مرطبة بنفس قدر المياه العادية وتُحتسب بالتساوي ضمن الاستهلاك اليومي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Carrying a reusable water bottle makes it easier to sip throughout the day and track intake.',
    'text_ar': 'حمل زجاجة ماء قابلة لإعادة الاستخدام يسهّل الشرب على مدار اليوم ومتابعة الاستهلاك.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Dark yellow or amber urine usually signals you need to drink more water.',
    'text_ar': 'البول الأصفر الداكن أو الكهرماني يشير عادةً إلى حاجتك لشرب المزيد من الماء.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Alcohol is a diuretic — alternate alcoholic drinks with glasses of water to stay hydrated.',
    'text_ar': 'الكحول مدر للبول — تناوب بين المشروبات الكحولية وأكواب الماء للحفاظ على الترطيب.',
    'source': 'NHS',
  },
  {
    'text': 'Soup and broth-based dishes contribute meaningfully to daily fluid intake.',
    'text_ar': 'الشوربات والأطباق المبنية على المرق تساهم بشكل ملموس في استهلاك السوائل اليومي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Dehydration can cause headaches; drinking water is often the first remedy to try.',
    'text_ar': 'الجفاف يمكن أن يسبب الصداع؛ شرب الماء غالباً ما يكون أول علاج يجب تجربته.',
    'source': 'NHS',
  },
  {
    'text': 'Children and teenagers need about 6–8 glasses of fluid per day, more when physically active.',
    'text_ar': 'يحتاج الأطفال والمراهقون إلى نحو 6-8 أكواب من السوائل يومياً، وأكثر عند ممارسة النشاط البدني.',
    'source': 'NHS',
  },
  {
    'text': 'Herbal teas count toward your fluid intake and are a good caffeine-free option.',
    'text_ar': 'شاي الأعشاب يُحتسب ضمن استهلاك السوائل وهو خيار جيد خالٍ من الكافيين.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'During breastfeeding, women need additional fluids — about 700 ml more per day than usual.',
    'text_ar': 'أثناء الرضاعة الطبيعية، تحتاج النساء إلى سوائل إضافية — نحو 700 مل أكثر يومياً من المعتاد.',
    'source': 'NHS',
  },
  {
    'text': 'Keeping water at your desk or bedside removes friction and helps build a drinking habit.',
    'text_ar': 'إبقاء الماء على مكتبك أو بجانب سريرك يزيل العوائق ويساعد في بناء عادة الشرب.',
    'source': 'Harvard Health',
  },

  // ── Protein (21–40) ───────────────────────────────────────────────────
  {
    'text': 'Eating protein at every meal helps maintain and repair muscle tissue throughout the day.',
    'text_ar': 'تناول البروتين في كل وجبة يساعد في الحفاظ على الأنسجة العضلية وإصلاحها طوال اليوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Adults need roughly 0.8 g of protein per kilogram of body weight per day as a minimum.',
    'text_ar': 'يحتاج البالغون إلى نحو 0.8 غرام من البروتين لكل كيلوغرام من وزن الجسم يومياً كحد أدنى.',
    'source': 'WHO',
  },
  {
    'text': 'Spreading protein intake across meals is more effective for muscle synthesis than loading it into one meal.',
    'text_ar': 'توزيع تناول البروتين على الوجبات أكثر فعالية لبناء العضلات من تركيزه في وجبة واحدة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Beans, lentils, chickpeas, and tofu are excellent plant-based protein sources.',
    'text_ar': 'الفاصوليا والعدس والحمص والتوفو مصادر ممتازة للبروتين النباتي.',
    'source': 'NHS',
  },
  {
    'text': 'Eggs are one of the most complete protein sources, containing all nine essential amino acids.',
    'text_ar': 'البيض من أكثر مصادر البروتين اكتمالاً، إذ يحتوي على جميع الأحماض الأمينية الأساسية التسعة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Greek yogurt contains roughly twice the protein of regular yogurt per serving.',
    'text_ar': 'الزبادي اليوناني يحتوي على ضعف كمية البروتين الموجودة في الزبادي العادي تقريباً لكل حصة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Fish provides high-quality protein along with omega-3 fatty acids that support heart health.',
    'text_ar': 'يوفر السمك بروتيناً عالي الجودة إلى جانب أحماض أوميغا-3 الدهنية التي تدعم صحة القلب.',
    'source': 'NHS',
  },
  {
    'text': 'Protein takes longer to digest than carbohydrates, which helps you feel fuller for longer after meals.',
    'text_ar': 'يستغرق هضم البروتين وقتاً أطول من الكربوهيدرات، مما يساعدك على الشعور بالشبع لفترة أطول بعد الوجبات.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Nuts and seeds provide protein along with healthy fats, fiber, and essential minerals.',
    'text_ar': 'توفر المكسرات والبذور البروتين إلى جانب الدهون الصحية والألياف والمعادن الأساسية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Lean poultry (chicken breast, turkey) is one of the lowest-fat animal protein sources available.',
    'text_ar': 'الدواجن الخالية من الدهن (صدر الدجاج، الديك الرومي) من أقل مصادر البروتين الحيواني دهوناً.',
    'source': 'NHS',
  },
  {
    'text': 'Combining different plant proteins (e.g. rice and beans) across the day provides all essential amino acids.',
    'text_ar': 'الجمع بين بروتينات نباتية مختلفة (مثل الأرز والفاصوليا) على مدار اليوم يوفر جميع الأحماض الأمينية الأساسية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Cottage cheese is high in protein and pairs well with fruit for a balanced snack.',
    'text_ar': 'جبن القريش غني بالبروتين ويتناسب جيداً مع الفاكهة كوجبة خفيفة متوازنة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Quinoa is one of the few plant foods that contains all nine essential amino acids.',
    'text_ar': 'الكينوا من الأطعمة النباتية القليلة التي تحتوي على جميع الأحماض الأمينية الأساسية التسعة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Protein needs increase during pregnancy and breastfeeding to support fetal and infant growth.',
    'text_ar': 'تزداد احتياجات البروتين أثناء الحمل والرضاعة لدعم نمو الجنين والرضيع.',
    'source': 'WHO',
  },
  {
    'text': 'Older adults may need more protein (1.0–1.2 g per kg) to prevent age-related muscle loss.',
    'text_ar': 'قد يحتاج كبار السن إلى المزيد من البروتين (1.0-1.2 غرام لكل كغ) لمنع فقدان العضلات المرتبط بالعمر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Edamame (young soybeans) provides about 17 g of protein per cup and makes a great snack.',
    'text_ar': 'يوفر الإدامامي (فول الصويا الصغير) نحو 17 غراماً من البروتين لكل كوب ويُعد وجبة خفيفة رائعة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Protein helps stabilize blood sugar levels, reducing energy crashes between meals.',
    'text_ar': 'يساعد البروتين في استقرار مستويات السكر في الدم، مما يقلل من انخفاض الطاقة بين الوجبات.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Whey and casein in dairy products are highly bioavailable forms of protein.',
    'text_ar': 'بروتينا مصل اللبن والكازين في منتجات الألبان من أشكال البروتين عالية التوافر الحيوي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'After resistance exercise, consuming 20–30 g of protein helps maximize muscle repair.',
    'text_ar': 'بعد تمارين المقاومة، يساعد تناول 20-30 غراماً من البروتين في تعظيم إصلاح العضلات.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Choosing lean cuts of red meat and trimming visible fat provides protein with less saturated fat.',
    'text_ar': 'اختيار قطع اللحم الأحمر الخالية من الدهن وإزالة الدهون المرئية يوفر البروتين مع دهون مشبعة أقل.',
    'source': 'NHS',
  },

  // ── Fiber (41–60) ─────────────────────────────────────────────────────
  {
    'text': 'Adults should aim for at least 30 g of fiber per day, but most people eat only about 20 g.',
    'text_ar': 'يجب أن يهدف البالغون إلى تناول 30 غراماً على الأقل من الألياف يومياً، لكن معظم الناس يتناولون نحو 20 غراماً فقط.',
    'source': 'NHS',
  },
  {
    'text': 'Fiber helps maintain bowel health and regularity by adding bulk to stool.',
    'text_ar': 'تساعد الألياف في الحفاظ على صحة الأمعاء وانتظامها عن طريق إضافة حجم للبراز.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Whole grains like oats, brown rice, and whole wheat bread are excellent fiber sources.',
    'text_ar': 'الحبوب الكاملة مثل الشوفان والأرز البني وخبز القمح الكامل مصادر ممتازة للألياف.',
    'source': 'NHS',
  },
  {
    'text': 'Soluble fiber (found in oats, beans, apples) helps lower blood cholesterol levels.',
    'text_ar': 'تساعد الألياف القابلة للذوبان (الموجودة في الشوفان والفاصوليا والتفاح) في خفض مستويات الكوليسترول في الدم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Insoluble fiber (found in whole wheat, nuts, vegetables) helps food pass through the digestive system.',
    'text_ar': 'تساعد الألياف غير القابلة للذوبان (الموجودة في القمح الكامل والمكسرات والخضراوات) الطعام على المرور عبر الجهاز الهضمي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Increasing fiber intake gradually and drinking plenty of water helps prevent digestive discomfort.',
    'text_ar': 'زيادة تناول الألياف تدريجياً وشرب الكثير من الماء يساعد في منع الانزعاج الهضمي.',
    'source': 'NHS',
  },
  {
    'text': 'Leaving the skin on fruits and vegetables increases their fiber content significantly.',
    'text_ar': 'ترك القشرة على الفواكه والخضراوات يزيد من محتواها من الألياف بشكل كبير.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Legumes (beans, lentils, peas) are among the highest-fiber foods available, with 7–8 g per half cup.',
    'text_ar': 'البقوليات (الفاصوليا والعدس والبازلاء) من أغنى الأطعمة بالألياف، بمعدل 7-8 غرامات لكل نصف كوب.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'A high-fiber diet is associated with a lower risk of developing type 2 diabetes.',
    'text_ar': 'يرتبط النظام الغذائي الغني بالألياف بانخفاض خطر الإصابة بداء السكري من النوع الثاني.',
    'source': 'WHO',
  },
  {
    'text': 'Berries are among the highest-fiber fruits — raspberries provide about 8 g per cup.',
    'text_ar': 'التوت من أغنى الفواكه بالألياف — يوفر توت العليق نحو 8 غرامات لكل كوب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Popcorn (air-popped, without excess butter) is a whole grain snack with about 3.5 g fiber per 3 cups.',
    'text_ar': 'الفشار (المحضّر بالهواء دون زبدة زائدة) وجبة خفيفة من الحبوب الكاملة تحتوي على نحو 3.5 غرام من الألياف لكل 3 أكواب.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Avocados provide about 10 g of fiber per fruit along with healthy monounsaturated fats.',
    'text_ar': 'يوفر الأفوكادو نحو 10 غرامات من الألياف لكل حبة إلى جانب الدهون الأحادية غير المشبعة الصحية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Switching from white to whole grain bread, pasta, and rice is an easy way to boost daily fiber.',
    'text_ar': 'التحول من الخبز الأبيض والمعكرونة والأرز إلى نظيراتها من الحبوب الكاملة طريقة سهلة لزيادة الألياف اليومية.',
    'source': 'NHS',
  },
  {
    'text': 'Fiber-rich foods tend to be more filling, which can help with weight management.',
    'text_ar': 'الأطعمة الغنية بالألياف تميل إلى أن تكون أكثر إشباعاً، مما يساعد في إدارة الوزن.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Chia seeds provide about 10 g of fiber per ounce and can be added to yogurt or smoothies.',
    'text_ar': 'توفر بذور الشيا نحو 10 غرامات من الألياف لكل أونصة ويمكن إضافتها إلى الزبادي أو العصائر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A diet high in fiber may reduce the risk of colorectal cancer.',
    'text_ar': 'قد يقلل النظام الغذائي الغني بالألياف من خطر الإصابة بسرطان القولون والمستقيم.',
    'source': 'WHO',
  },
  {
    'text': 'Artichokes are one of the highest-fiber vegetables, with about 10 g per medium artichoke.',
    'text_ar': 'الخرشوف من أغنى الخضراوات بالألياف، بنحو 10 غرامات لكل حبة متوسطة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Adding beans or lentils to soups, stews, and salads is an easy way to increase fiber intake.',
    'text_ar': 'إضافة الفاصوليا أو العدس إلى الشوربات واليخنات والسلطات طريقة سهلة لزيادة تناول الألياف.',
    'source': 'NHS',
  },
  {
    'text': 'Fiber slows the absorption of sugar, helping to improve blood sugar control.',
    'text_ar': 'تبطئ الألياف امتصاص السكر، مما يساعد في تحسين التحكم بسكر الدم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Sweet potatoes provide about 4 g of fiber each and are a nutritious alternative to white potatoes.',
    'text_ar': 'توفر البطاطا الحلوة نحو 4 غرامات من الألياف لكل حبة وهي بديل مغذٍّ للبطاطا البيضاء.',
    'source': 'Mayo Clinic',
  },

  // ── Vitamins & Minerals (61–80) ───────────────────────────────────────
  {
    'text': 'Vitamin D helps the body absorb calcium; consider a supplement during winter months when sunlight is limited.',
    'text_ar': 'يساعد فيتامين د الجسم على امتصاص الكالسيوم؛ يُنصح بتناول مكمّل غذائي خلال أشهر الشتاء عندما يكون ضوء الشمس محدوداً.',
    'source': 'NHS',
  },
  {
    'text': 'Iron from plant sources (spinach, lentils) is absorbed better when eaten with vitamin C-rich foods.',
    'text_ar': 'يُمتص الحديد من المصادر النباتية (السبانخ والعدس) بشكل أفضل عند تناوله مع أطعمة غنية بفيتامين ج.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Calcium is essential for strong bones and teeth — dairy products, fortified plant milks, and leafy greens are good sources.',
    'text_ar': 'الكالسيوم ضروري لعظام وأسنان قوية — منتجات الألبان والحليب النباتي المدعّم والخضراوات الورقية مصادر جيدة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Folate is critical during early pregnancy to prevent neural tube defects; leafy greens and legumes are rich sources.',
    'text_ar': 'حمض الفوليك بالغ الأهمية في بداية الحمل لمنع عيوب الأنبوب العصبي؛ والخضراوات الورقية والبقوليات مصادر غنية به.',
    'source': 'WHO',
  },
  {
    'text': 'Vitamin B12 is found mainly in animal products; vegans should take a supplement or eat fortified foods.',
    'text_ar': 'يوجد فيتامين ب12 بشكل رئيسي في المنتجات الحيوانية؛ يجب على النباتيين تناول مكمّل أو أطعمة مدعّمة.',
    'source': 'NHS',
  },
  {
    'text': 'Potassium helps regulate blood pressure; bananas, potatoes, spinach, and beans are rich sources.',
    'text_ar': 'يساعد البوتاسيوم في تنظيم ضغط الدم؛ والموز والبطاطس والسبانخ والفاصوليا مصادر غنية به.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Zinc supports immune function and wound healing; meat, shellfish, legumes, and seeds are good sources.',
    'text_ar': 'يدعم الزنك وظيفة المناعة والتئام الجروح؛ واللحوم والمحار والبقوليات والبذور مصادر جيدة له.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Vitamin A supports vision and immune health; orange and yellow vegetables, liver, and dairy are rich sources.',
    'text_ar': 'يدعم فيتامين أ الرؤية وصحة المناعة؛ والخضراوات البرتقالية والصفراء والكبد ومنتجات الألبان مصادر غنية به.',
    'source': 'WHO',
  },
  {
    'text': 'Magnesium is involved in over 300 enzyme reactions; nuts, seeds, whole grains, and dark chocolate provide it.',
    'text_ar': 'يشارك المغنيسيوم في أكثر من 300 تفاعل إنزيمي؛ وتوفره المكسرات والبذور والحبوب الكاملة والشوكولاتة الداكنة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Iodine is essential for thyroid function; fish, dairy, and iodized salt are the main dietary sources.',
    'text_ar': 'اليود ضروري لوظيفة الغدة الدرقية؛ والأسماك ومنتجات الألبان والملح المعالج باليود هي المصادر الغذائية الرئيسية.',
    'source': 'NHS',
  },
  {
    'text': 'Vitamin C supports the immune system and helps the body make collagen; citrus fruits, peppers, and berries are excellent sources.',
    'text_ar': 'يدعم فيتامين ج جهاز المناعة ويساعد الجسم في إنتاج الكولاجين؛ والحمضيات والفلفل والتوت مصادر ممتازة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Selenium acts as an antioxidant; just two Brazil nuts per day provides your recommended intake.',
    'text_ar': 'يعمل السيلينيوم كمضاد للأكسدة؛ حبتان فقط من جوز البرازيل يومياً توفران الكمية الموصى بها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vitamin K is needed for blood clotting and bone health; green leafy vegetables are the best source.',
    'text_ar': 'فيتامين ك ضروري لتخثر الدم وصحة العظام؛ والخضراوات الورقية الخضراء هي أفضل مصدر.',
    'source': 'NHS',
  },
  {
    'text': 'Omega-3 fatty acids support brain and heart health; aim for two portions of fish per week, one being oily.',
    'text_ar': 'تدعم أحماض أوميغا-3 الدهنية صحة الدماغ والقلب؛ اهدف إلى حصتين من الأسماك أسبوعياً، إحداهما دهنية.',
    'source': 'NHS',
  },
  {
    'text': 'B vitamins help the body convert food into energy; whole grains, meat, eggs, and legumes are key sources.',
    'text_ar': 'تساعد فيتامينات ب الجسم في تحويل الطعام إلى طاقة؛ والحبوب الكاملة واللحوم والبيض والبقوليات مصادر رئيسية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Eating a variety of colorful fruits and vegetables helps ensure a broad spectrum of vitamins and minerals.',
    'text_ar': 'تناول تشكيلة متنوعة من الفواكه والخضراوات الملونة يساعد في ضمان طيف واسع من الفيتامينات والمعادن.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vitamin E is an antioxidant found in nuts, seeds, and vegetable oils that protects cells from damage.',
    'text_ar': 'فيتامين هـ مضاد للأكسدة يوجد في المكسرات والبذور والزيوت النباتية ويحمي الخلايا من التلف.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Chromium helps regulate blood sugar; broccoli, grape juice, and whole grains are sources.',
    'text_ar': 'يساعد الكروم في تنظيم سكر الدم؛ والبروكلي وعصير العنب والحبوب الكاملة مصادر له.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Copper supports iron metabolism and nerve function; shellfish, nuts, seeds, and dark chocolate contain it.',
    'text_ar': 'يدعم النحاس أيض الحديد ووظيفة الأعصاب؛ ويحتوي عليه المحار والمكسرات والبذور والشوكولاتة الداكنة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Too much of certain vitamins (A, D, E, K) can be harmful; aim to get nutrients from food first.',
    'text_ar': 'الإفراط في تناول بعض الفيتامينات (أ، د، هـ، ك) قد يكون ضاراً؛ احرص على الحصول على العناصر الغذائية من الطعام أولاً.',
    'source': 'NHS',
  },

  // ── Meal Timing & Patterns (81–95) ────────────────────────────────────
  {
    'text': 'Eating breakfast helps replenish blood glucose and can improve concentration and energy levels throughout the morning.',
    'text_ar': 'تناول وجبة الإفطار يساعد في تجديد غلوكوز الدم ويمكن أن يحسّن التركيز ومستويات الطاقة طوال الصباح.',
    'source': 'NHS',
  },
  {
    'text': 'Eating at regular times helps your body regulate hunger hormones and energy use.',
    'text_ar': 'الأكل في أوقات منتظمة يساعد جسمك على تنظيم هرمونات الجوع واستخدام الطاقة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Leaving at least two hours between your last meal and bedtime may improve sleep quality and digestion.',
    'text_ar': 'ترك ساعتين على الأقل بين آخر وجبة ووقت النوم قد يحسّن جودة النوم والهضم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Planning meals ahead reduces the likelihood of reaching for high-calorie convenience foods.',
    'text_ar': 'التخطيط المسبق للوجبات يقلل من احتمالية اللجوء إلى الأطعمة السريعة عالية السعرات الحرارية.',
    'source': 'NHS',
  },
  {
    'text': 'If you skip meals, you are more likely to overeat at the next one due to increased hunger.',
    'text_ar': 'إذا تخطيت وجبة، فمن المرجح أن تفرط في الأكل في الوجبة التالية بسبب زيادة الجوع.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A balanced meal includes protein, complex carbohydrates, healthy fat, and vegetables.',
    'text_ar': 'الوجبة المتوازنة تشمل البروتين والكربوهيدرات المعقدة والدهون الصحية والخضراوات.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Eating slowly and chewing thoroughly gives your brain time to register fullness, typically about 20 minutes.',
    'text_ar': 'الأكل ببطء والمضغ جيداً يمنح دماغك الوقت لتسجيل الشبع، عادةً نحو 20 دقيقة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Mid-morning and mid-afternoon snacks can prevent energy dips if they include protein and fiber.',
    'text_ar': 'الوجبات الخفيفة في منتصف الصباح وبعد الظهر يمكن أن تمنع انخفاض الطاقة إذا تضمنت البروتين والألياف.',
    'source': 'NHS',
  },
  {
    'text': 'Batch cooking on weekends sets you up with healthy ready-made meals for the busy week ahead.',
    'text_ar': 'طهي كميات كبيرة في عطلة نهاية الأسبوع يوفر لك وجبات صحية جاهزة للأسبوع المزدحم.',
    'source': 'NHS',
  },
  {
    'text': 'Mindful eating — paying attention to taste, texture, and hunger cues — can help prevent overeating.',
    'text_ar': 'الأكل الواعي — الانتباه للطعم والقوام وإشارات الجوع — يمكن أن يساعد في منع الإفراط في الأكل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating your heaviest meal earlier in the day may be beneficial for metabolic health.',
    'text_ar': 'تناول أثقل وجبة في وقت مبكر من اليوم قد يكون مفيداً لصحة الأيض.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Keeping a consistent eating schedule, even on weekends, supports stable blood sugar levels.',
    'text_ar': 'الحفاظ على جدول أكل منتظم، حتى في عطلة نهاية الأسبوع، يدعم استقرار مستويات السكر في الدم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Preparing a grocery list before shopping reduces impulse purchases of less nutritious items.',
    'text_ar': 'إعداد قائمة مشتريات قبل التسوق يقلل من المشتريات العشوائية للمواد الأقل تغذية.',
    'source': 'NHS',
  },
  {
    'text': 'Having healthy snacks readily available (cut vegetables, fruit, nuts) makes good choices easier.',
    'text_ar': 'توفير وجبات خفيفة صحية جاهزة (خضراوات مقطعة، فواكه، مكسرات) يسهّل اتخاذ الخيارات الجيدة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Cooking at home gives you more control over ingredients, portions, and cooking methods.',
    'text_ar': 'الطهي في المنزل يمنحك تحكماً أكبر في المكونات والحصص وطرق الطبخ.',
    'source': 'Mayo Clinic',
  },

  // ── Portion Control (96–110) ──────────────────────────────────────────
  {
    'text': 'Using a smaller plate can naturally reduce portion sizes without making you feel deprived.',
    'text_ar': 'استخدام طبق أصغر يمكن أن يقلل أحجام الحصص بشكل طبيعي دون أن تشعر بالحرمان.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A serving of meat or fish should be roughly the size of your palm.',
    'text_ar': 'يجب أن تكون حصة اللحم أو السمك بحجم راحة يدك تقريباً.',
    'source': 'NHS',
  },
  {
    'text': 'A serving of cheese is about the size of two thumbs placed together.',
    'text_ar': 'حصة الجبن تعادل تقريباً حجم إبهامين مضمومين معاً.',
    'source': 'NHS',
  },
  {
    'text': 'One serving of cooked pasta or rice is about the size of your clenched fist.',
    'text_ar': 'حصة واحدة من المعكرونة أو الأرز المطبوخ تعادل تقريباً حجم قبضة يدك.',
    'source': 'NHS',
  },
  {
    'text': 'Reading the serving size on food labels helps you understand exactly how much you are eating.',
    'text_ar': 'قراءة حجم الحصة على ملصقات الطعام تساعدك على فهم الكمية التي تتناولها بالضبط.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Restaurants often serve two to three times the recommended portion size; consider sharing or saving half.',
    'text_ar': 'المطاعم غالباً ما تقدم ضعفين إلى ثلاثة أضعاف حجم الحصة الموصى به؛ فكّر في المشاركة أو حفظ النصف.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Filling half your plate with vegetables and salad naturally limits space for higher-calorie foods.',
    'text_ar': 'ملء نصف طبقك بالخضراوات والسلطة يحدّ بشكل طبيعي من المساحة المتاحة للأطعمة الأعلى سعرات حرارية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Pre-portioning snacks into small containers prevents mindless eating from large bags.',
    'text_ar': 'تقسيم الوجبات الخفيفة مسبقاً في حاويات صغيرة يمنع الأكل غير الواعي من الأكياس الكبيرة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Serving food from the kitchen rather than placing dishes on the table reduces the temptation for seconds.',
    'text_ar': 'تقديم الطعام من المطبخ بدلاً من وضع الأطباق على المائدة يقلل من إغراء أخذ حصة ثانية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A portion of nuts as a snack is about a small handful (30 g), roughly 150–180 calories.',
    'text_ar': 'حصة المكسرات كوجبة خفيفة تعادل حفنة صغيرة (30 غراماً)، أي نحو 150-180 سعرة حرارية.',
    'source': 'NHS',
  },
  {
    'text': 'Drinking a glass of water before a meal can help you eat a more appropriate portion.',
    'text_ar': 'شرب كوب من الماء قبل الوجبة يمكن أن يساعدك على تناول حصة مناسبة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Check cereal box servings — many people pour two to three times the recommended amount.',
    'text_ar': 'تحقق من حصص علب الحبوب — كثير من الناس يسكبون ضعفين إلى ثلاثة أضعاف الكمية الموصى بها.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Using measuring cups for cooking oils ensures you do not add excessive hidden calories.',
    'text_ar': 'استخدام أكواب القياس لزيوت الطبخ يضمن عدم إضافة سعرات حرارية مخفية مفرطة.',
    'source': 'NHS',
  },
  {
    'text': 'Eating from a bowl rather than a bag helps you see and control how much you consume.',
    'text_ar': 'تناول الطعام من وعاء بدلاً من كيس يساعدك على رؤية الكمية التي تستهلكها والتحكم بها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'When dining out, ask for dressings and sauces on the side so you control the amount added.',
    'text_ar': 'عند تناول الطعام خارج المنزل، اطلب الصلصات والتتبيلات جانباً لتتحكم في الكمية المضافة.',
    'source': 'Mayo Clinic',
  },

  // ── Food Safety (111–125) ─────────────────────────────────────────────
  {
    'text': 'Wash your hands thoroughly with soap and warm water for at least 20 seconds before preparing food.',
    'text_ar': 'اغسل يديك جيداً بالصابون والماء الدافئ لمدة 20 ثانية على الأقل قبل تحضير الطعام.',
    'source': 'WHO',
  },
  {
    'text': 'Use separate chopping boards for raw meat and ready-to-eat foods to prevent cross-contamination.',
    'text_ar': 'استخدم ألواح تقطيع منفصلة للحوم النيئة والأطعمة الجاهزة للأكل لمنع التلوث المتبادل.',
    'source': 'NHS',
  },
  {
    'text': 'Refrigerate perishable foods within two hours of purchase or preparation to slow bacterial growth.',
    'text_ar': 'ضع الأطعمة القابلة للتلف في الثلاجة خلال ساعتين من الشراء أو التحضير لإبطاء نمو البكتيريا.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Cook poultry to an internal temperature of at least 74 °C (165 °F) to kill harmful bacteria.',
    'text_ar': 'اطبخ الدواجن حتى تصل درجة الحرارة الداخلية إلى 74 درجة مئوية (165 فهرنهايت) على الأقل للقضاء على البكتيريا الضارة.',
    'source': 'WHO',
  },
  {
    'text': 'Defrost frozen food in the refrigerator, in cold water, or in the microwave — never at room temperature.',
    'text_ar': 'قم بإذابة الأطعمة المجمدة في الثلاجة أو في ماء بارد أو في الميكروويف — ولا تذبها أبداً في درجة حرارة الغرفة.',
    'source': 'NHS',
  },
  {
    'text': 'Leftover cooked food should be refrigerated within one hour and consumed within two days.',
    'text_ar': 'يجب وضع بقايا الطعام المطبوخ في الثلاجة خلال ساعة واحدة واستهلاكها في غضون يومين.',
    'source': 'NHS',
  },
  {
    'text': 'Do not wash raw chicken before cooking; this spreads bacteria via water droplets to nearby surfaces.',
    'text_ar': 'لا تغسل الدجاج النيء قبل الطبخ؛ فذلك ينشر البكتيريا عبر رذاذ الماء إلى الأسطح المجاورة.',
    'source': 'NHS',
  },
  {
    'text': 'Check the use-by date on perishable foods — after this date, the food may no longer be safe to eat.',
    'text_ar': 'تحقق من تاريخ انتهاء الصلاحية على الأطعمة القابلة للتلف — بعد هذا التاريخ قد لا يكون الطعام آمناً للأكل.',
    'source': 'NHS',
  },
  {
    'text': 'Keep your refrigerator at 5 °C or below to keep food safe; use a fridge thermometer to verify.',
    'text_ar': 'حافظ على درجة حرارة ثلاجتك عند 5 درجات مئوية أو أقل للحفاظ على سلامة الطعام؛ واستخدم مقياس حرارة للتحقق.',
    'source': 'NHS',
  },
  {
    'text': 'Reheat leftover food until it is steaming hot all the way through, reaching at least 70 °C.',
    'text_ar': 'أعد تسخين بقايا الطعام حتى يصبح ساخناً جداً بالكامل، بحيث تصل درجة الحرارة إلى 70 درجة مئوية على الأقل.',
    'source': 'WHO',
  },
  {
    'text': 'Raw eggs may contain Salmonella; cook eggs until both the white and yolk are firm.',
    'text_ar': 'قد يحتوي البيض النيء على بكتيريا السالمونيلا؛ اطبخ البيض حتى يتماسك كل من البياض والصفار.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Rice can contain Bacillus cereus spores; cool and refrigerate leftover rice within one hour.',
    'text_ar': 'قد يحتوي الأرز على أبواغ بكتيريا العصوية الشمعية؛ بَرّد الأرز المتبقي وضعه في الثلاجة خلال ساعة واحدة.',
    'source': 'NHS',
  },
  {
    'text': 'Canned food that is bulging, leaking, or has a foul odor should be discarded immediately.',
    'text_ar': 'يجب التخلص فوراً من الأطعمة المعلبة المنتفخة أو المتسربة أو ذات الرائحة الكريهة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Wash all fruits and vegetables under running water before eating, even if you plan to peel them.',
    'text_ar': 'اغسل جميع الفواكه والخضراوات تحت الماء الجاري قبل تناولها، حتى لو كنت تنوي تقشيرها.',
    'source': 'WHO',
  },
  {
    'text': 'Pregnant women should avoid soft mould-ripened cheeses, raw fish, and pâté to reduce infection risk.',
    'text_ar': 'يجب على الحوامل تجنب الأجبان الطرية المعتّقة بالعفن والأسماك النيئة والباتيه للحد من خطر العدوى.',
    'source': 'NHS',
  },

  // ── Mental Health & Eating (126–140) ──────────────────────────────────
  {
    'text': 'The gut and brain communicate through the gut-brain axis; a balanced diet supports both digestive and mental health.',
    'text_ar': 'يتواصل الدماغ والأمعاء عبر محور الأمعاء والدماغ؛ والنظام الغذائي المتوازن يدعم الصحة الهضمية والنفسية معاً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Omega-3 fatty acids found in oily fish may help reduce symptoms of depression and anxiety.',
    'text_ar': 'قد تساعد أحماض أوميغا-3 الدهنية الموجودة في الأسماك الدهنية في تخفيف أعراض الاكتئاب والقلق.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Regular meals help stabilize blood sugar, which can prevent mood swings and irritability.',
    'text_ar': 'تساعد الوجبات المنتظمة في استقرار سكر الدم، مما يمنع تقلبات المزاج والعصبية.',
    'source': 'NHS',
  },
  {
    'text': 'Emotional eating is a common response to stress; recognizing triggers is the first step toward changing the pattern.',
    'text_ar': 'الأكل العاطفي استجابة شائعة للتوتر؛ والتعرف على المحفزات هو الخطوة الأولى لتغيير هذا النمط.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Foods rich in tryptophan (turkey, eggs, cheese) support serotonin production, which regulates mood.',
    'text_ar': 'الأطعمة الغنية بالتريبتوفان (الديك الرومي والبيض والجبن) تدعم إنتاج السيروتونين الذي ينظم المزاج.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A Mediterranean-style diet rich in fruits, vegetables, fish, and olive oil is associated with lower rates of depression.',
    'text_ar': 'يرتبط النظام الغذائي المتوسطي الغني بالفواكه والخضراوات والأسماك وزيت الزيتون بانخفاض معدلات الاكتئاب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excessive caffeine intake can increase anxiety and disrupt sleep; limit to 400 mg per day (about 4 cups of coffee).',
    'text_ar': 'الإفراط في تناول الكافيين يمكن أن يزيد القلق ويعطّل النوم؛ حدّد استهلاكك بـ 400 ملغ يومياً (نحو 4 أكواب قهوة).',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Probiotics in fermented foods (yogurt, kefir, sauerkraut) may positively influence mood via the gut-brain connection.',
    'text_ar': 'قد تؤثر البروبيوتيك في الأطعمة المخمرة (الزبادي والكفير ومخلل الملفوف) إيجابياً على المزاج عبر الرابط بين الأمعاء والدماغ.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Skipping meals can lead to low blood sugar, causing fatigue, poor concentration, and irritability.',
    'text_ar': 'تخطي الوجبات قد يؤدي إلى انخفاض سكر الدم مسبباً الإرهاق وضعف التركيز والعصبية.',
    'source': 'NHS',
  },
  {
    'text': 'B vitamins, particularly B6, B12, and folate, play a role in producing brain chemicals that regulate mood.',
    'text_ar': 'تلعب فيتامينات ب، وخاصة ب6 وب12 وحمض الفوليك، دوراً في إنتاج المواد الكيميائية الدماغية المنظمة للمزاج.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating together with family or friends has social and emotional benefits and often leads to healthier food choices.',
    'text_ar': 'تناول الطعام مع العائلة أو الأصدقاء له فوائد اجتماعية وعاطفية وغالباً ما يؤدي إلى خيارات غذائية أكثر صحة.',
    'source': 'NHS',
  },
  {
    'text': 'Restrictive dieting can worsen mental health; focus on adding nutritious foods rather than eliminating entire groups.',
    'text_ar': 'الحميات التقييدية قد تُسيء إلى الصحة النفسية؛ ركّز على إضافة أطعمة مغذية بدلاً من حذف مجموعات غذائية كاملة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Dark chocolate (70%+ cocoa) in moderation may improve mood due to flavonoids and theobromine.',
    'text_ar': 'الشوكولاتة الداكنة (بنسبة كاكاو 70% أو أكثر) باعتدال قد تحسّن المزاج بفضل الفلافونويدات والثيوبرومين.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Staying well-hydrated is important for cognitive function; even mild dehydration can worsen anxiety.',
    'text_ar': 'الحفاظ على ترطيب الجسم مهم للوظائف الذهنية؛ حتى الجفاف الخفيف يمكن أن يزيد من القلق.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Journaling your food intake and mood can help identify patterns between what you eat and how you feel.',
    'text_ar': 'تدوين ما تأكله ومزاجك في دفتر يومي يساعد في تحديد الأنماط بين غذائك وشعورك.',
    'source': 'Mayo Clinic',
  },

  // ── Weight Management (141–160) ───────────────────────────────────────
  {
    'text': 'A sustainable rate of weight loss is 0.5 to 1 kg (1–2 lbs) per week.',
    'text_ar': 'المعدل المستدام لفقدان الوزن هو 0.5 إلى 1 كيلوغرام (1-2 رطل) أسبوعياً.',
    'source': 'NHS',
  },
  {
    'text': 'Weight management is about long-term habits, not short-term diets; focus on changes you can maintain.',
    'text_ar': 'إدارة الوزن تتعلق بالعادات طويلة المدى وليس الحميات قصيرة المدى؛ ركّز على تغييرات يمكنك الحفاظ عليها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A calorie deficit of about 500 calories per day typically leads to about 0.5 kg of weight loss per week.',
    'text_ar': 'عجز يومي بنحو 500 سعرة حرارية يؤدي عادةً إلى فقدان نحو 0.5 كيلوغرام أسبوعياً.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Protein-rich foods increase satiety and can help reduce overall calorie intake naturally.',
    'text_ar': 'الأطعمة الغنية بالبروتين تزيد الشعور بالشبع ويمكن أن تساعد في تقليل إجمالي السعرات الحرارية المتناولة بشكل طبيعي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Regular physical activity combined with dietary changes is more effective for weight management than diet alone.',
    'text_ar': 'النشاط البدني المنتظم مع التغييرات الغذائية أكثر فعالية في إدارة الوزن من الحمية وحدها.',
    'source': 'WHO',
  },
  {
    'text': 'Getting 7–9 hours of sleep per night supports healthy weight; poor sleep disrupts hunger hormones.',
    'text_ar': 'الحصول على 7-9 ساعات من النوم ليلاً يدعم الوزن الصحي؛ فقلة النوم تُخلّ بهرمونات الجوع.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Stress raises cortisol levels, which can increase appetite and promote fat storage, especially around the abdomen.',
    'text_ar': 'يرفع التوتر مستويات الكورتيزول، مما قد يزيد الشهية ويعزز تخزين الدهون، خاصة حول البطن.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Keeping a food diary increases awareness of eating habits and has been shown to support weight loss.',
    'text_ar': 'يساعد تدوين الطعام في دفتر يومي على زيادة الوعي بعادات الأكل وقد ثبت أنه يدعم فقدان الوزن.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Replacing sugary drinks with water, tea, or black coffee can eliminate a significant source of hidden calories.',
    'text_ar': 'استبدال المشروبات السكرية بالماء أو الشاي أو القهوة السوداء يمكن أن يزيل مصدراً كبيراً من السعرات الحرارية المخفية.',
    'source': 'NHS',
  },
  {
    'text': 'Weighing yourself at the same time each day (ideally morning) provides the most consistent tracking data.',
    'text_ar': 'وزن نفسك في الوقت ذاته كل يوم (ويُفضّل في الصباح) يوفر بيانات تتبع أكثر اتساقاً.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Small, consistent changes like taking stairs or walking after dinner add up to meaningful calorie expenditure.',
    'text_ar': 'التغييرات الصغيرة المستمرة كصعود الدرج أو المشي بعد العشاء تتراكم لتشكّل إنفاقاً ملموساً للسعرات الحرارية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Beware of "health halo" foods (granola, smoothie bowls, trail mix) which can be surprisingly high in calories.',
    'text_ar': 'احذر من أطعمة "الهالة الصحية" (الغرانولا وأوعية السموذي وخليط المكسرات والفواكه المجففة) التي قد تكون عالية السعرات بشكل مفاجئ.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Fad diets that promise rapid results often lead to muscle loss and are rarely sustainable long-term.',
    'text_ar': 'الحميات الرائجة التي تعد بنتائج سريعة غالباً ما تؤدي إلى فقدان العضلات ونادراً ما تكون مستدامة على المدى الطويل.',
    'source': 'NHS',
  },
  {
    'text': 'Increasing vegetable intake at meals displaces higher-calorie foods and adds volume with fewer calories.',
    'text_ar': 'زيادة تناول الخضراوات في الوجبات يحلّ محل الأطعمة الأعلى سعرات ويضيف حجماً بسعرات أقل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Alcohol contains 7 calories per gram (nearly as much as fat) and can weaken dietary resolve.',
    'text_ar': 'يحتوي الكحول على 7 سعرات حرارية لكل غرام (تقريباً بقدر الدهون) ويمكن أن يُضعف الالتزام بالحمية.',
    'source': 'NHS',
  },
  {
    'text': 'Building muscle through resistance training increases your resting metabolic rate.',
    'text_ar': 'بناء العضلات من خلال تمارين المقاومة يزيد من معدل الأيض أثناء الراحة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'It is normal for weight to fluctuate 1–2 kg day to day due to water retention, digestion, and hormones.',
    'text_ar': 'من الطبيعي أن يتقلب الوزن بمقدار 1-2 كيلوغرام يومياً بسبب احتباس الماء والهضم والهرمونات.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating enough fiber helps you feel full and satisfied, reducing the urge to snack between meals.',
    'text_ar': 'تناول كمية كافية من الألياف يساعدك على الشعور بالامتلاء والرضا، مما يقلل الرغبة في تناول الوجبات الخفيفة بين الوجبات.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Setting specific, measurable goals (like "eat 5 servings of vegetables daily") is more effective than vague intentions.',
    'text_ar': 'وضع أهداف محددة وقابلة للقياس (مثل "تناول 5 حصص من الخضراوات يومياً") أكثر فعالية من النوايا الغامضة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'BMI is a useful screening tool but does not distinguish between muscle and fat; consider waist circumference too.',
    'text_ar': 'مؤشر كتلة الجسم أداة فحص مفيدة لكنه لا يميّز بين العضلات والدهون؛ ضع في الاعتبار أيضاً محيط الخصر.',
    'source': 'NHS',
  },

  // ── Special Diets (161–175) ───────────────────────────────────────────
  {
    'text': 'Vegetarians should pay special attention to iron, B12, zinc, and omega-3 intake from plant sources or supplements.',
    'text_ar': 'يجب على النباتيين إيلاء اهتمام خاص لتناول الحديد وب12 والزنك وأوميغا-3 من مصادر نباتية أو مكملات.',
    'source': 'NHS',
  },
  {
    'text': 'A well-planned vegan diet can meet all nutritional needs, but B12 supplementation is essential.',
    'text_ar': 'يمكن للنظام الغذائي النباتي الشامل المخطط جيداً تلبية جميع الاحتياجات الغذائية، لكن مكملات ب12 ضرورية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Gluten-free diets are medically necessary for people with coeliac disease but offer no proven benefit for others.',
    'text_ar': 'الأنظمة الغذائية الخالية من الغلوتين ضرورية طبياً لمرضى الداء البطني، لكنها لا تقدم فائدة مثبتة للآخرين.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'If following a dairy-free diet, ensure adequate calcium from fortified plant milks, tofu, or leafy greens.',
    'text_ar': 'إذا كنت تتبع نظاماً غذائياً خالياً من الألبان، تأكد من الحصول على كمية كافية من الكالسيوم من الحليب النباتي المدعّم أو التوفو أو الخضراوات الورقية.',
    'source': 'NHS',
  },
  {
    'text': 'The Mediterranean diet, rich in olive oil, fish, fruits, and vegetables, is one of the most researched and recommended dietary patterns.',
    'text_ar': 'يُعد حمية البحر الأبيض المتوسط، الغنية بزيت الزيتون والأسماك والفواكه والخضراوات، من أكثر الأنماط الغذائية بحثاً والموصى بها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'The DASH diet emphasizes fruits, vegetables, whole grains, and lean protein to lower blood pressure.',
    'text_ar': 'يركز نظام داش الغذائي على الفواكه والخضراوات والحبوب الكاملة والبروتين الخالي من الدهن لخفض ضغط الدم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Low-carb diets can be effective for short-term weight loss, but long-term safety depends on the types of fat and protein chosen.',
    'text_ar': 'يمكن أن تكون الأنظمة الغذائية منخفضة الكربوهيدرات فعالة لفقدان الوزن على المدى القصير، لكن سلامتها على المدى الطويل تعتمد على أنواع الدهون والبروتين المختارة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Intermittent fasting may help some people manage calorie intake, but it is not suitable for everyone.',
    'text_ar': 'قد يساعد الصيام المتقطع بعض الأشخاص في إدارة السعرات الحرارية، لكنه لا يناسب الجميع.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Lactose intolerant individuals can often tolerate yogurt and aged cheeses, which contain less lactose.',
    'text_ar': 'يمكن للأشخاص الذين يعانون من عدم تحمل اللاكتوز في الغالب تحمّل الزبادي والأجبان المعتّقة التي تحتوي على لاكتوز أقل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Pregnant women have increased needs for folate, iron, calcium, and protein; a prenatal vitamin can help fill gaps.',
    'text_ar': 'تزداد احتياجات الحوامل من حمض الفوليك والحديد والكالسيوم والبروتين؛ ويمكن لفيتامين ما قبل الولادة سدّ الفجوات.',
    'source': 'WHO',
  },
  {
    'text': 'Athletes generally need more protein and carbohydrates than sedentary individuals to support training and recovery.',
    'text_ar': 'يحتاج الرياضيون عموماً إلى بروتين وكربوهيدرات أكثر من الأشخاص غير النشطين لدعم التدريب والتعافي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Children and teenagers should not follow restrictive diets without medical supervision.',
    'text_ar': 'لا يجب أن يتبع الأطفال والمراهقون حميات تقييدية دون إشراف طبي.',
    'source': 'NHS',
  },
  {
    'text': 'If you have a diagnosed food allergy, always read ingredient labels, even on products you buy regularly.',
    'text_ar': 'إذا كنت تعاني من حساسية غذائية مشخّصة، احرص دائماً على قراءة ملصقات المكونات حتى على المنتجات التي تشتريها بانتظام.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Plant-based diets tend to be higher in fiber and lower in saturated fat than typical Western diets.',
    'text_ar': 'تميل الأنظمة الغذائية النباتية إلى أن تكون أعلى في الألياف وأقل في الدهون المشبعة مقارنة بالأنظمة الغذائية الغربية التقليدية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'The anti-inflammatory diet emphasizes foods that reduce inflammation: fatty fish, berries, nuts, and leafy greens.',
    'text_ar': 'يركز النظام الغذائي المضاد للالتهابات على الأطعمة التي تقلل الالتهاب: الأسماك الدهنية والتوت والمكسرات والخضراوات الورقية.',
    'source': 'Harvard Health',
  },

  // ── Gut Health (176–190) ──────────────────────────────────────────────
  {
    'text': 'The gut microbiome contains trillions of microorganisms that influence digestion, immunity, and even mental health.',
    'text_ar': 'يحتوي ميكروبيوم الأمعاء على تريليونات من الكائنات الدقيقة التي تؤثر في الهضم والمناعة وحتى الصحة النفسية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Fermented foods like yogurt, kefir, kimchi, and sauerkraut introduce beneficial bacteria to the gut.',
    'text_ar': 'تُدخل الأطعمة المخمرة مثل الزبادي والكفير والكيمتشي ومخلل الملفوف بكتيريا نافعة إلى الأمعاء.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A diverse diet rich in different plant foods supports a more diverse and resilient gut microbiome.',
    'text_ar': 'النظام الغذائي المتنوع الغني بأطعمة نباتية مختلفة يدعم ميكروبيوم أمعاء أكثر تنوعاً ومرونة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Prebiotics are types of fiber that feed beneficial gut bacteria; garlic, onions, bananas, and asparagus are rich sources.',
    'text_ar': 'البريبيوتيك أنواع من الألياف تغذي بكتيريا الأمعاء النافعة؛ والثوم والبصل والموز والهليون مصادر غنية بها.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Artificial sweeteners may alter gut bacteria composition; use them in moderation.',
    'text_ar': 'قد تغيّر المحلّيات الصناعية تركيبة بكتيريا الأمعاء؛ استخدمها باعتدال.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Antibiotics can disrupt the gut microbiome; eating probiotic-rich foods during and after a course may help restoration.',
    'text_ar': 'يمكن للمضادات الحيوية أن تُخلّ بميكروبيوم الأمعاء؛ وتناول أطعمة غنية بالبروبيوتيك أثناء العلاج وبعده قد يساعد في استعادة التوازن.',
    'source': 'NHS',
  },
  {
    'text': 'Whole grains provide fiber that feeds beneficial bacteria and supports regular bowel movements.',
    'text_ar': 'توفر الحبوب الكاملة أليافاً تغذي البكتيريا النافعة وتدعم انتظام حركة الأمعاء.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excessive alcohol consumption can damage the gut lining and reduce microbial diversity.',
    'text_ar': 'الإفراط في استهلاك الكحول يمكن أن يُتلف بطانة الأمعاء ويقلل من تنوع الميكروبات.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating a wide variety of fruits and vegetables — aim for 30 different plant foods per week — supports gut health.',
    'text_ar': 'تناول تشكيلة واسعة من الفواكه والخضراوات — استهدف 30 نوعاً مختلفاً من الأطعمة النباتية أسبوعياً — يدعم صحة الأمعاء.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Chronic stress can negatively affect gut bacteria and increase symptoms of IBS and other digestive conditions.',
    'text_ar': 'يمكن للتوتر المزمن أن يؤثر سلباً على بكتيريا الأمعاء ويزيد من أعراض القولون العصبي واضطرابات الجهاز الهضمي الأخرى.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Polyphenols in tea, coffee, dark chocolate, and berries act as prebiotics and support beneficial gut bacteria.',
    'text_ar': 'تعمل البوليفينولات الموجودة في الشاي والقهوة والشوكولاتة الداكنة والتوت كبريبيوتيك وتدعم بكتيريا الأمعاء النافعة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Getting enough sleep is linked to better gut microbiome health; disrupted sleep can alter microbial balance.',
    'text_ar': 'الحصول على قسط كافٍ من النوم يرتبط بصحة أفضل لميكروبيوم الأمعاء؛ واضطراب النوم يمكن أن يُخلّ بالتوازن الميكروبي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Soluble fiber in oats and legumes feeds Bifidobacteria and Lactobacillus, two important beneficial bacterial groups.',
    'text_ar': 'تغذي الألياف القابلة للذوبان في الشوفان والبقوليات بكتيريا البيفيدو والعصيات اللبنية، وهما مجموعتان مهمتان من البكتيريا النافعة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Bone broth contains collagen and amino acids that may support gut lining integrity.',
    'text_ar': 'يحتوي مرق العظام على الكولاجين والأحماض الأمينية التي قد تدعم سلامة بطانة الأمعاء.',
    'source': 'Harvard Health',
  },
  {
    'text': 'If you experience persistent digestive symptoms, consult a healthcare professional rather than self-diagnosing.',
    'text_ar': 'إذا كنت تعاني من أعراض هضمية مستمرة، استشر أخصائي رعاية صحية بدلاً من التشخيص الذاتي.',
    'source': 'NHS',
  },

  // ── Heart Health (191–210) ────────────────────────────────────────────
  {
    'text': 'Eating at least five portions of fruit and vegetables per day is associated with a lower risk of heart disease.',
    'text_ar': 'يرتبط تناول خمس حصص على الأقل من الفواكه والخضراوات يومياً بانخفاض خطر الإصابة بأمراض القلب.',
    'source': 'WHO',
  },
  {
    'text': 'Oily fish such as salmon, mackerel, and sardines provide omega-3 fats that help maintain a healthy heart.',
    'text_ar': 'توفر الأسماك الدهنية مثل السلمون والماكريل والسردين دهون أوميغا-3 التي تساعد في الحفاظ على صحة القلب.',
    'source': 'NHS',
  },
  {
    'text': 'Replacing saturated fats with unsaturated fats (olive oil, nuts, avocados) helps lower LDL cholesterol.',
    'text_ar': 'استبدال الدهون المشبعة بالدهون غير المشبعة (زيت الزيتون والمكسرات والأفوكادو) يساعد في خفض الكوليسترول الضار.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excess sodium raises blood pressure; aim for less than 5 g of salt (about 1 teaspoon) per day.',
    'text_ar': 'الإفراط في الصوديوم يرفع ضغط الدم؛ اهدف إلى أقل من 5 غرامات من الملح (نحو ملعقة صغيرة) يومياً.',
    'source': 'WHO',
  },
  {
    'text': 'Soluble fiber in oats, barley, and beans can help lower LDL ("bad") cholesterol.',
    'text_ar': 'تساعد الألياف القابلة للذوبان في الشوفان والشعير والفاصوليا على خفض الكوليسترول الضار (LDL).',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Trans fats are the most harmful dietary fat for heart health; avoid partially hydrogenated oils.',
    'text_ar': 'الدهون المتحولة هي أكثر الدهون الغذائية ضرراً بصحة القلب؛ تجنب الزيوت المهدرجة جزئياً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Regular physical activity of at least 150 minutes of moderate exercise per week benefits heart health.',
    'text_ar': 'يفيد النشاط البدني المنتظم بما لا يقل عن 150 دقيقة من التمارين المعتدلة أسبوعياً صحة القلب.',
    'source': 'WHO',
  },
  {
    'text': 'Nuts, eaten in moderate amounts (a small handful per day), are associated with reduced cardiovascular risk.',
    'text_ar': 'ترتبط المكسرات عند تناولها بكميات معتدلة (حفنة صغيرة يومياً) بانخفاض خطر الإصابة بأمراض القلب والأوعية الدموية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Whole grains retain their bran and germ, providing fiber and nutrients that support cardiovascular health.',
    'text_ar': 'تحتفظ الحبوب الكاملة بنخالتها وجنينها، مما يوفر أليافاً ومغذيات تدعم صحة القلب والأوعية الدموية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Limiting added sugar helps control weight and reduces risk factors for heart disease.',
    'text_ar': 'الحد من السكريات المضافة يساعد في التحكم بالوزن ويقلل من عوامل خطر الإصابة بأمراض القلب.',
    'source': 'NHS',
  },
  {
    'text': 'Dark leafy greens (spinach, kale) are rich in nitrates, which help relax blood vessels and lower blood pressure.',
    'text_ar': 'الخضروات الورقية الداكنة (السبانخ، الكرنب الأجعد) غنية بالنترات التي تساعد على استرخاء الأوعية الدموية وخفض ضغط الدم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Legumes (beans, lentils, chickpeas) improve heart health by providing fiber, plant protein, and potassium.',
    'text_ar': 'البقوليات (الفاصوليا، العدس، الحمص) تعزز صحة القلب من خلال توفير الألياف والبروتين النباتي والبوتاسيوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excessive alcohol consumption raises blood pressure and increases the risk of heart disease.',
    'text_ar': 'الإفراط في تناول الكحول يرفع ضغط الدم ويزيد من خطر الإصابة بأمراض القلب.',
    'source': 'NHS',
  },
  {
    'text': 'Olive oil, especially extra virgin, contains polyphenols that have anti-inflammatory benefits for the heart.',
    'text_ar': 'زيت الزيتون، وخاصة البكر الممتاز، يحتوي على مركبات البوليفينول التي لها فوائد مضادة للالتهابات لصحة القلب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Maintaining a healthy weight reduces strain on the heart and lowers cardiovascular risk factors.',
    'text_ar': 'الحفاظ على وزن صحي يقلل من الإجهاد على القلب ويخفض عوامل خطر الإصابة بأمراض القلب والأوعية الدموية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Garlic may have modest cholesterol-lowering and blood-pressure-lowering effects.',
    'text_ar': 'قد يكون للثوم تأثيرات معتدلة في خفض الكوليسترول وضغط الدم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Potassium-rich foods (bananas, sweet potatoes, spinach) help counteract sodium\'s effect on blood pressure.',
    'text_ar': 'الأطعمة الغنية بالبوتاسيوم (الموز، البطاطا الحلوة، السبانخ) تساعد في مواجهة تأثير الصوديوم على ضغط الدم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Chronic stress contributes to heart disease; regular relaxation practices can support cardiovascular health.',
    'text_ar': 'الإجهاد المزمن يسهم في أمراض القلب؛ وممارسة تقنيات الاسترخاء بانتظام يمكن أن تدعم صحة القلب والأوعية الدموية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Berries are rich in anthocyanins, antioxidants linked to reduced risk of heart attack.',
    'text_ar': 'التوت غني بالأنثوسيانين، وهي مضادات أكسدة مرتبطة بتقليل خطر الإصابة بالنوبات القلبية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Cooking at home allows you to control salt, fat, and sugar — all critical factors for heart health.',
    'text_ar': 'الطهي في المنزل يتيح لك التحكم في الملح والدهون والسكر — وهي عوامل حاسمة لصحة القلب.',
    'source': 'NHS',
  },

  // ── Bone Health (211–225) ─────────────────────────────────────────────
  {
    'text': 'Calcium and vitamin D work together for bone health; dairy, fortified foods, and sunlight are key sources.',
    'text_ar': 'الكالسيوم وفيتامين د يعملان معاً لتعزيز صحة العظام؛ ومنتجات الألبان والأطعمة المدعّمة وأشعة الشمس هي مصادر أساسية لهما.',
    'source': 'NHS',
  },
  {
    'text': 'Weight-bearing exercise like walking, jogging, and dancing helps maintain bone density.',
    'text_ar': 'التمارين التي تتضمن تحميل الوزن مثل المشي والركض والرقص تساعد في الحفاظ على كثافة العظام.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Adults need 700 mg of calcium per day; a glass of milk provides about 300 mg.',
    'text_ar': 'يحتاج البالغون إلى 700 ملغ من الكالسيوم يومياً؛ وكوب واحد من الحليب يوفر حوالي 300 ملغ.',
    'source': 'NHS',
  },
  {
    'text': 'Vitamin D is essential for calcium absorption; most people in northern climates should consider a supplement in winter.',
    'text_ar': 'فيتامين د ضروري لامتصاص الكالسيوم؛ ومعظم الأشخاص في المناخات الشمالية ينبغي أن يفكروا في تناول مكمّل غذائي في الشتاء.',
    'source': 'NHS',
  },
  {
    'text': 'Excessive caffeine intake (more than 4 cups of coffee per day) may reduce calcium absorption.',
    'text_ar': 'الإفراط في تناول الكافيين (أكثر من 4 أكواب من القهوة يومياً) قد يقلل من امتصاص الكالسيوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Smoking accelerates bone loss; quitting is one of the best things you can do for bone health.',
    'text_ar': 'التدخين يسرّع فقدان العظام؛ والإقلاع عنه من أفضل ما يمكنك فعله لصحة عظامك.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Protein is needed for bone structure; aim for adequate (not excessive) daily intake.',
    'text_ar': 'البروتين ضروري لبنية العظام؛ احرص على تناول كمية كافية (وليست مفرطة) يومياً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Sardines and canned salmon (eaten with bones) are excellent sources of both calcium and vitamin D.',
    'text_ar': 'السردين وسمك السلمون المعلّب (الذي يؤكل مع عظامه) مصادر ممتازة لكل من الكالسيوم وفيتامين د.',
    'source': 'NHS',
  },
  {
    'text': 'Too much salt increases calcium loss through urine; reducing sodium intake supports bone health.',
    'text_ar': 'الإفراط في تناول الملح يزيد من فقدان الكالسيوم عبر البول؛ وتقليل تناول الصوديوم يدعم صحة العظام.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Leafy greens like kale and broccoli provide calcium that is well absorbed by the body.',
    'text_ar': 'الخضروات الورقية مثل الكرنب الأجعد والبروكلي توفر كالسيوماً يمتصه الجسم بشكل جيد.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Magnesium supports bone mineralization; nuts, seeds, and whole grains are good sources.',
    'text_ar': 'المغنيسيوم يدعم تمعدن العظام؛ والمكسرات والبذور والحبوب الكاملة مصادر جيدة له.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Peak bone mass is built during childhood and adolescence; adequate nutrition during these years is critical.',
    'text_ar': 'تُبنى ذروة الكتلة العظمية خلال مرحلتي الطفولة والمراهقة؛ والتغذية الكافية خلال هذه السنوات أمر بالغ الأهمية.',
    'source': 'WHO',
  },
  {
    'text': 'Vitamin K, found in green leafy vegetables, is needed for proper calcium metabolism in bones.',
    'text_ar': 'فيتامين ك الموجود في الخضروات الورقية الخضراء ضروري لعملية أيض الكالسيوم في العظام.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excessive alcohol consumption interferes with calcium balance and increases the risk of fractures.',
    'text_ar': 'الإفراط في تناول الكحول يخلّ بتوازن الكالسيوم ويزيد من خطر الكسور.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Fortified plant-based milks (soy, almond, oat) can provide similar calcium levels to cow\'s milk when fortified.',
    'text_ar': 'الحليب النباتي المدعّم (حليب الصويا واللوز والشوفان) يمكن أن يوفر مستويات كالسيوم مماثلة لحليب البقر عند تدعيمه.',
    'source': 'NHS',
  },

  // ── Sugar & Salt Reduction (226–245) ──────────────────────────────────
  {
    'text': 'The WHO recommends that free sugars should make up less than 10% of total daily energy intake.',
    'text_ar': 'توصي منظمة الصحة العالمية بأن تشكّل السكريات الحرة أقل من 10% من إجمالي الطاقة اليومية المتناولة.',
    'source': 'WHO',
  },
  {
    'text': 'One can of regular soda contains about 35–40 g of sugar, which is nearly the entire recommended daily limit.',
    'text_ar': 'تحتوي علبة واحدة من المشروبات الغازية العادية على حوالي 35-40 غراماً من السكر، وهو ما يقارب الحد الأقصى الموصى به يومياً.',
    'source': 'NHS',
  },
  {
    'text': 'Checking ingredient lists for words ending in "-ose" (glucose, fructose, sucrose) helps identify hidden sugars.',
    'text_ar': 'التحقق من قائمة المكونات بحثاً عن كلمات تنتهي بـ "-وز" (غلوكوز، فركتوز، سكروز) يساعد في اكتشاف السكريات المخفية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Reducing sugar intake gradually allows your taste buds to adjust, making sweet foods taste sweeter over time.',
    'text_ar': 'تقليل تناول السكر تدريجياً يسمح لبراعم التذوق بالتكيّف، مما يجعل الأطعمة الحلوة تبدو أكثر حلاوة مع الوقت.',
    'source': 'NHS',
  },
  {
    'text': 'Flavoring water with lemon, lime, cucumber, or mint is a refreshing alternative to sugary drinks.',
    'text_ar': 'إضافة نكهة للماء بالليمون أو الليمون الحامض أو الخيار أو النعناع بديل منعش للمشروبات السكرية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Most adults eat about 8–10 g of salt per day, nearly double the WHO recommended limit of 5 g.',
    'text_ar': 'يتناول معظم البالغين حوالي 8-10 غرامات من الملح يومياً، أي ما يقارب ضعف الحد الموصى به من منظمة الصحة العالمية وهو 5 غرامات.',
    'source': 'WHO',
  },
  {
    'text': 'About 75% of the salt we eat comes from processed and packaged foods, not from the salt shaker.',
    'text_ar': 'حوالي 75% من الملح الذي نتناوله يأتي من الأطعمة المصنّعة والمعلّبة، وليس من ملّاحة الطعام.',
    'source': 'NHS',
  },
  {
    'text': 'Herbs, spices, lemon juice, and vinegar are effective ways to add flavor without adding salt.',
    'text_ar': 'الأعشاب والتوابل وعصير الليمون والخل طرق فعّالة لإضافة النكهة دون إضافة الملح.',
    'source': 'Harvard Health',
  },
  {
    'text': 'High sugar intake is linked to weight gain, tooth decay, and increased risk of type 2 diabetes.',
    'text_ar': 'يرتبط الإفراط في تناول السكر بزيادة الوزن وتسوّس الأسنان وارتفاع خطر الإصابة بداء السكري من النوع الثاني.',
    'source': 'WHO',
  },
  {
    'text': '"No added sugar" does not mean sugar-free; the product may still contain naturally occurring sugars.',
    'text_ar': 'عبارة "بدون سكر مضاف" لا تعني خالياً من السكر؛ فقد يحتوي المنتج على سكريات طبيعية.',
    'source': 'NHS',
  },
  {
    'text': 'Breakfast cereals, sauces, and breads can be surprisingly high in both sugar and salt.',
    'text_ar': 'حبوب الإفطار والصلصات والخبز قد تحتوي على كميات مرتفعة بشكل مفاجئ من السكر والملح معاً.',
    'source': 'NHS',
  },
  {
    'text': 'Fruit juices contain natural sugars and lack the fiber of whole fruit; limit to 150 ml per day.',
    'text_ar': 'عصائر الفاكهة تحتوي على سكريات طبيعية وتفتقر إلى ألياف الفاكهة الكاملة؛ يُنصح بالاكتفاء بـ 150 مل يومياً.',
    'source': 'NHS',
  },
  {
    'text': 'Gradually reducing salt in cooking allows your palate to adjust; most people stop noticing the difference after 2–3 weeks.',
    'text_ar': 'تقليل الملح تدريجياً أثناء الطهي يسمح لذائقتك بالتكيّف؛ ومعظم الناس يتوقفون عن ملاحظة الفرق بعد 2-3 أسابيع.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Choosing "reduced salt" or "low sodium" versions of canned foods can meaningfully cut daily salt intake.',
    'text_ar': 'اختيار الأطعمة المعلّبة "منخفضة الملح" أو "قليلة الصوديوم" يمكن أن يقلل بشكل ملموس من تناول الملح اليومي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Honey, agave, and maple syrup are still free sugars and count toward the daily limit.',
    'text_ar': 'العسل وشراب الصبّار وشراب القيقب لا تزال سكريات حرة وتُحتسب ضمن الحد اليومي المسموح.',
    'source': 'WHO',
  },
  {
    'text': 'High salt intake is a leading risk factor for high blood pressure and stroke worldwide.',
    'text_ar': 'الإفراط في تناول الملح عامل خطر رئيسي لارتفاع ضغط الدم والسكتة الدماغية على مستوى العالم.',
    'source': 'WHO',
  },
  {
    'text': 'Dried fruit is nutrient-dense but concentrated in sugar; keep portions to about 30 g.',
    'text_ar': 'الفواكه المجففة غنية بالعناصر الغذائية لكنها مركّزة السكر؛ يُنصح بالاكتفاء بحصة تبلغ حوالي 30 غراماً.',
    'source': 'NHS',
  },
  {
    'text': 'Reading traffic-light labels (green, amber, red) on food packaging helps quickly identify high-sugar and high-salt products.',
    'text_ar': 'قراءة ملصقات إشارة المرور (الأخضر والأصفر والأحمر) على عبوات الأطعمة تساعد في تحديد المنتجات عالية السكر والملح بسرعة.',
    'source': 'NHS',
  },
  {
    'text': 'Cooking from scratch gives you complete control over how much sugar and salt goes into your food.',
    'text_ar': 'الطهي من الصفر يمنحك تحكماً كاملاً في كمية السكر والملح التي تدخل في طعامك.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Children should have even lower sugar and salt limits than adults; setting good habits early protects long-term health.',
    'text_ar': 'ينبغي أن تكون حدود السكر والملح لدى الأطفال أقل من البالغين؛ وغرس العادات الصحية مبكراً يحمي الصحة على المدى البعيد.',
    'source': 'WHO',
  },

  // ── Cooking Tips & Methods (246–265) ──────────────────────────────────
  {
    'text': 'Steaming vegetables preserves more vitamins and minerals than boiling them.',
    'text_ar': 'طهي الخضروات على البخار يحافظ على الفيتامينات والمعادن أكثر من سلقها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Using non-stick pans or cooking spray reduces the amount of oil needed for cooking.',
    'text_ar': 'استخدام المقالي غير اللاصقة أو رذاذ الطهي يقلل من كمية الزيت اللازمة للطبخ.',
    'source': 'NHS',
  },
  {
    'text': 'Grilling, baking, and poaching are healthier cooking methods than deep-frying.',
    'text_ar': 'الشيّ والخبز والسلق طرق طهي أكثر صحة من القلي العميق.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Marinating meat in acidic ingredients (lemon, vinegar) reduces the formation of harmful compounds during high-heat cooking.',
    'text_ar': 'تتبيل اللحم بمكونات حمضية (الليمون، الخل) يقلل من تكوّن المركبات الضارة أثناء الطهي على حرارة عالية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Roasting vegetables (broccoli, cauliflower, carrots) at high heat brings out natural sweetness without added sugar.',
    'text_ar': 'تحميص الخضروات (البروكلي، القرنبيط، الجزر) على حرارة عالية يبرز حلاوتها الطبيعية دون إضافة سكر.',
    'source': 'NHS',
  },
  {
    'text': 'Crushing or chopping garlic and letting it sit for 10 minutes before cooking maximizes the formation of beneficial allicin.',
    'text_ar': 'هرس الثوم أو تقطيعه وتركه لمدة 10 دقائق قبل الطهي يزيد من تكوّن مادة الأليسين المفيدة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Using whole herbs and spices not only adds flavor but also provides small amounts of antioxidants.',
    'text_ar': 'استخدام الأعشاب والتوابل الكاملة لا يضيف نكهة فحسب، بل يوفر أيضاً كميات صغيرة من مضادات الأكسدة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Blanching vegetables (brief boiling then ice bath) preserves color, texture, and nutrients for later use.',
    'text_ar': 'سلق الخضروات لفترة وجيزة ثم تبريدها في ماء مثلّج يحافظ على لونها وقوامها وعناصرها الغذائية لاستخدامها لاحقاً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Slow cooking is ideal for tough, lean cuts of meat, making them tender without added fat.',
    'text_ar': 'الطهي البطيء مثالي لقطع اللحم القاسية والقليلة الدهن، إذ يجعلها طرية دون إضافة دهون.',
    'source': 'NHS',
  },
  {
    'text': 'Adding a small amount of healthy fat (olive oil) when cooking vegetables improves absorption of fat-soluble vitamins A, D, E, and K.',
    'text_ar': 'إضافة كمية صغيرة من الدهون الصحية (زيت الزيتون) عند طهي الخضروات يحسّن امتصاص الفيتامينات الذائبة في الدهون A وD وE وK.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Tomatoes release more lycopene (a beneficial antioxidant) when cooked than when eaten raw.',
    'text_ar': 'يُطلق الطماطم كمية أكبر من الليكوبين (مضاد أكسدة مفيد) عند طهيها مقارنة بتناولها نيئة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Stir-frying at high heat for a short time preserves nutrients and requires only a small amount of oil.',
    'text_ar': 'القلي السريع بالتحريك على حرارة عالية لفترة قصيرة يحافظ على العناصر الغذائية ولا يتطلب سوى كمية قليلة من الزيت.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Using a vegetable spiralizer to make zucchini or carrot "noodles" is a simple way to eat more vegetables.',
    'text_ar': 'استخدام أداة تقطيع الخضروات الحلزونية لصنع "نودلز" من الكوسا أو الجزر طريقة بسيطة لتناول المزيد من الخضروات.',
    'source': 'NHS',
  },
  {
    'text': 'Freezing fresh produce at peak ripeness retains most of its nutritional value for months.',
    'text_ar': 'تجميد المنتجات الطازجة في ذروة نضجها يحتفظ بمعظم قيمتها الغذائية لعدة أشهر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Rinsing canned beans and vegetables removes up to 40% of the added sodium.',
    'text_ar': 'شطف الفاصوليا والخضروات المعلّبة يزيل ما يصل إلى 40% من الصوديوم المضاف.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Batch-cooking grains (rice, quinoa) on the weekend saves time and encourages healthier meals during the week.',
    'text_ar': 'طهي الحبوب (الأرز، الكينوا) بكميات كبيرة في عطلة نهاية الأسبوع يوفّر الوقت ويشجع على وجبات صحية خلال الأسبوع.',
    'source': 'NHS',
  },
  {
    'text': 'Using citrus zest (lemon, orange) adds bright flavor to dishes without extra calories or sodium.',
    'text_ar': 'استخدام قشر الحمضيات (الليمون، البرتقال) يضيف نكهة منعشة للأطباق دون سعرات حرارية أو صوديوم إضافي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Homemade salad dressings with olive oil and vinegar are generally healthier than most store-bought versions.',
    'text_ar': 'تتبيلات السلطة المنزلية المصنوعة من زيت الزيتون والخل أكثر صحة عموماً من معظم الأنواع الجاهزة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Pressure cooking is one of the fastest methods and retains nutrients well due to shorter cooking times.',
    'text_ar': 'الطهي بالضغط من أسرع الطرق ويحافظ على العناصر الغذائية بشكل جيد بفضل أوقات الطهي القصيرة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Replacing cream-based sauces with tomato or vegetable-based sauces significantly reduces saturated fat and calories.',
    'text_ar': 'استبدال الصلصات القائمة على الكريمة بصلصات الطماطم أو الخضروات يقلل بشكل كبير من الدهون المشبعة والسعرات الحرارية.',
    'source': 'NHS',
  },

  // ── Reading Labels & Food Literacy (266–280) ─────────────────────────
  {
    'text': 'Ingredients are listed in descending order by weight; the first few items make up the bulk of the product.',
    'text_ar': 'تُدرج المكونات بترتيب تنازلي حسب الوزن؛ والعناصر الأولى في القائمة تشكّل الجزء الأكبر من المنتج.',
    'source': 'NHS',
  },
  {
    'text': 'The "per 100 g" column on nutrition labels allows you to compare different products fairly.',
    'text_ar': 'عمود "لكل 100 غرام" على ملصقات التغذية يتيح لك مقارنة المنتجات المختلفة بشكل عادل.',
    'source': 'NHS',
  },
  {
    'text': '"Light" or "lite" on packaging can refer to flavor, color, or texture — not necessarily fewer calories.',
    'text_ar': 'كلمة "خفيف" أو "لايت" على العبوة قد تشير إلى النكهة أو اللون أو القوام — وليس بالضرورة إلى سعرات حرارية أقل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Foods labeled "fat-free" may compensate with added sugar to maintain taste and texture.',
    'text_ar': 'الأطعمة المصنّفة "خالية من الدهون" قد تعوّض ذلك بإضافة السكر للحفاظ على الطعم والقوام.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Daily Reference Values (%DV) on labels help you understand whether a serving is high or low in a nutrient.',
    'text_ar': 'القيم اليومية المرجعية (%DV) على الملصقات تساعدك في فهم ما إذا كانت الحصة غنية أو منخفضة بعنصر غذائي معيّن.',
    'source': 'Harvard Health',
  },
  {
    'text': '"Natural" on a food label has no strict legal definition in many countries and does not guarantee healthfulness.',
    'text_ar': 'كلمة "طبيعي" على ملصق الطعام ليس لها تعريف قانوني صارم في كثير من البلدان ولا تضمن أن المنتج صحي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': '"Whole grain" should be the first ingredient for bread and cereals to truly be whole grain products.',
    'text_ar': 'يجب أن تكون "الحبوب الكاملة" المكوّن الأول في الخبز وحبوب الإفطار ليكون المنتج من الحبوب الكاملة فعلاً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Serving sizes on labels may be smaller than what you actually eat; always check and adjust.',
    'text_ar': 'أحجام الحصص على الملصقات قد تكون أصغر مما تتناوله فعلياً؛ تحقق دائماً واضبط الكميات وفقاً لذلك.',
    'source': 'NHS',
  },
  {
    'text': '"Organic" refers to how food is produced, not its nutritional content; organic cookies are still cookies.',
    'text_ar': 'كلمة "عضوي" تشير إلى طريقة إنتاج الغذاء وليس إلى محتواه الغذائي؛ فالبسكويت العضوي لا يزال بسكويتاً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Traffic-light labels (UK system) make it easy to see at a glance if a food is high in fat, salt, or sugar.',
    'text_ar': 'ملصقات إشارة المرور (النظام البريطاني) تسهّل معرفة ما إذا كان الطعام غنياً بالدهون أو الملح أو السكر بنظرة سريعة.',
    'source': 'NHS',
  },
  {
    'text': '"Multigrain" means multiple grains were used, but they may all be refined; look for "whole grain" instead.',
    'text_ar': 'كلمة "متعدد الحبوب" تعني استخدام عدة أنواع من الحبوب، لكنها قد تكون جميعها مكررة؛ ابحث عن "حبوب كاملة" بدلاً من ذلك.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Added sugars on labels include syrups, honey, and concentrated fruit juices used as sweeteners.',
    'text_ar': 'السكريات المضافة على الملصقات تشمل الشراب والعسل وعصائر الفاكهة المركّزة المستخدمة كمحلّيات.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Nutrition claims like "good source of" typically mean the food provides 10–19% of the Daily Value per serving.',
    'text_ar': 'عبارات مثل "مصدر جيد لـ" تعني عادةً أن الطعام يوفر 10-19% من القيمة اليومية لكل حصة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Allergen information is usually highlighted in bold or listed separately; always check if you have food sensitivities.',
    'text_ar': 'معلومات مسببات الحساسية عادةً ما تكون مميّزة بخط عريض أو مدرجة بشكل منفصل؛ تحقق منها دائماً إذا كانت لديك حساسية غذائية.',
    'source': 'NHS',
  },
  {
    'text': 'Comparing price per 100 g across brands helps you find the best value for nutritionally similar products.',
    'text_ar': 'مقارنة السعر لكل 100 غرام بين العلامات التجارية يساعدك في العثور على أفضل قيمة للمنتجات المتشابهة غذائياً.',
    'source': 'NHS',
  },

  // ── Fruits & Vegetables (281–290) ─────────────────────────────────────
  {
    'text': 'Eating at least five portions (400 g) of fruit and vegetables per day is associated with lower mortality from all causes.',
    'text_ar': 'تناول خمس حصص على الأقل (400 غرام) من الفواكه والخضروات يومياً يرتبط بانخفاض معدل الوفيات من جميع الأسباب.',
    'source': 'WHO',
  },
  {
    'text': 'Fresh, frozen, canned (in juice, not syrup), and dried fruits all count toward your five-a-day.',
    'text_ar': 'الفواكه الطازجة والمجمدة والمعلّبة (في عصيرها وليس في شراب) والمجففة جميعها تُحتسب ضمن حصصك اليومية الخمس.',
    'source': 'NHS',
  },
  {
    'text': 'Eating a rainbow of different colored produce ensures a wide variety of phytonutrients and antioxidants.',
    'text_ar': 'تناول تشكيلة متنوعة الألوان من الفواكه والخضروات يضمن الحصول على مجموعة واسعة من المغذيات النباتية ومضادات الأكسدة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Cruciferous vegetables (broccoli, cauliflower, cabbage, Brussels sprouts) contain compounds linked to cancer risk reduction.',
    'text_ar': 'الخضروات الصليبية (البروكلي، القرنبيط، الملفوف، كرنب بروكسل) تحتوي على مركبات مرتبطة بتقليل خطر الإصابة بالسرطان.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Leafy greens like spinach and kale are among the most nutrient-dense foods available per calorie.',
    'text_ar': 'الخضروات الورقية مثل السبانخ والكرنب الأجعد من أكثر الأطعمة كثافة بالعناصر الغذائية مقارنة بسعراتها الحرارية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Potatoes do not count toward your five-a-day because they are classified as starchy foods, not vegetables.',
    'text_ar': 'البطاطس لا تُحتسب ضمن الحصص اليومية الخمس لأنها تُصنّف ضمن الأطعمة النشوية وليس الخضروات.',
    'source': 'NHS',
  },
  {
    'text': 'One portion of fresh fruit is roughly 80 g, about the size of a tennis ball or a medium apple.',
    'text_ar': 'حصة واحدة من الفاكهة الطازجة تبلغ تقريباً 80 غراماً، أي بحجم كرة التنس أو تفاحة متوسطة.',
    'source': 'NHS',
  },
  {
    'text': 'Berries are particularly high in antioxidants and have been linked to improved brain function in aging.',
    'text_ar': 'التوت غني بشكل خاص بمضادات الأكسدة وقد ارتبط بتحسين وظائف الدماغ مع التقدم في العمر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Frozen vegetables are often flash-frozen at peak ripeness and can be just as nutritious as fresh.',
    'text_ar': 'الخضروات المجمدة غالباً ما تُجمّد بسرعة في ذروة نضجها ويمكن أن تكون مغذية بقدر الخضروات الطازجة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating fruit whole provides more fiber and leads to a slower sugar release than drinking fruit juice.',
    'text_ar': 'تناول الفاكهة كاملة يوفر ألياف أكثر ويؤدي إلى إطلاق أبطأ للسكر مقارنة بشرب عصير الفاكهة.',
    'source': 'NHS',
  },

  // ── Healthy Fats (291–300) ────────────────────────────────────────────
  {
    'text': 'Not all fats are equal; unsaturated fats (found in olive oil, nuts, avocados) are beneficial for health.',
    'text_ar': 'ليست كل الدهون متساوية؛ فالدهون غير المشبعة (الموجودة في زيت الزيتون والمكسرات والأفوكادو) مفيدة للصحة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Saturated fat intake should be less than 10% of total daily energy; replace with unsaturated fats where possible.',
    'text_ar': 'يجب أن يكون تناول الدهون المشبعة أقل من 10% من إجمالي الطاقة اليومية؛ واستبدلها بالدهون غير المشبعة كلما أمكن.',
    'source': 'WHO',
  },
  {
    'text': 'Avocados provide heart-healthy monounsaturated fat along with potassium and fiber.',
    'text_ar': 'الأفوكادو يوفر دهوناً أحادية غير مشبعة مفيدة للقلب إلى جانب البوتاسيوم والألياف.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Extra virgin olive oil is rich in polyphenols and is a cornerstone of the heart-healthy Mediterranean diet.',
    'text_ar': 'زيت الزيتون البكر الممتاز غني بمركبات البوليفينول وهو ركيزة أساسية في حمية البحر الأبيض المتوسط الصحية للقلب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Oily fish (salmon, mackerel, herring) are the best dietary source of omega-3 EPA and DHA fatty acids.',
    'text_ar': 'الأسماك الدهنية (السلمون، الماكريل، الرنجة) هي أفضل مصدر غذائي لأحماض أوميغا-3 الدهنية EPA وDHA.',
    'source': 'NHS',
  },
  {
    'text': 'Walnuts are unique among nuts because they provide a significant amount of plant-based omega-3 (ALA).',
    'text_ar': 'الجوز فريد بين المكسرات لأنه يوفر كمية كبيرة من أوميغا-3 النباتي (حمض ألفا-لينولينيك).',
    'source': 'Harvard Health',
  },
  {
    'text': 'Trans fats, found in some processed foods, raise LDL cholesterol and lower HDL cholesterol — the worst combination.',
    'text_ar': 'الدهون المتحولة الموجودة في بعض الأطعمة المصنّعة ترفع الكوليسترول الضار وتخفض الكوليسترول النافع — وهو أسوأ مزيج.',
    'source': 'WHO',
  },
  {
    'text': 'Flaxseeds and chia seeds are rich plant sources of alpha-linolenic acid (ALA), an omega-3 fatty acid.',
    'text_ar': 'بذور الكتان وبذور الشيا مصادر نباتية غنية بحمض ألفا-لينولينيك (ALA)، وهو حمض دهني من أوميغا-3.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Full-fat dairy in moderation may be part of a healthy diet; the overall dietary pattern matters more than single foods.',
    'text_ar': 'منتجات الألبان كاملة الدسم باعتدال قد تكون جزءاً من نظام غذائي صحي؛ فالنمط الغذائي العام أهم من الأطعمة المنفردة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Coconut oil is high in saturated fat; while not harmful in small amounts, it should not replace olive oil as your primary cooking fat.',
    'text_ar': 'زيت جوز الهند غني بالدهون المشبعة؛ ورغم أنه ليس ضاراً بكميات صغيرة، إلا أنه لا ينبغي أن يحلّ محل زيت الزيتون كزيت الطهي الأساسي.',
    'source': 'Harvard Health',
  },

  // ── Sleep & Nutrition (301–320) ───────────────────────────────────────
  {
    'text': 'Poor sleep increases levels of ghrelin (the hunger hormone) and decreases leptin (the fullness hormone), promoting overeating.',
    'text_ar': 'قلة النوم ترفع مستويات هرمون الجريلين (هرمون الجوع) وتخفض مستويات هرمون اللبتين (هرمون الشبع)، مما يعزز الإفراط في تناول الطعام.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating a large meal close to bedtime can disrupt sleep quality and increase acid reflux risk.',
    'text_ar': 'تناول وجبة كبيرة قبل النوم مباشرة قد يُخلّ بجودة النوم ويزيد من خطر الارتجاع الحمضي.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Tart cherry juice is one of the few natural food sources of melatonin and may help improve sleep.',
    'text_ar': 'عصير الكرز الحامض هو أحد المصادر الغذائية الطبيعية القليلة للميلاتونين وقد يساعد في تحسين النوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Magnesium-rich foods (almonds, spinach, pumpkin seeds) may help promote relaxation and better sleep.',
    'text_ar': 'الأطعمة الغنية بالمغنيسيوم (اللوز والسبانخ وبذور اليقطين) قد تساعد في تعزيز الاسترخاء وتحسين جودة النوم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Caffeine has a half-life of 5–6 hours; avoid it after early afternoon to protect sleep quality.',
    'text_ar': 'يبلغ عمر النصف للكافيين من 5 إلى 6 ساعات؛ تجنّب تناوله بعد أوائل فترة ما بعد الظهر للحفاظ على جودة النوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A light snack combining complex carbs and protein (e.g. whole grain crackers with cheese) may help you fall asleep.',
    'text_ar': 'وجبة خفيفة تجمع بين الكربوهيدرات المعقدة والبروتين (مثل البسكويت المصنوع من الحبوب الكاملة مع الجبن) قد تساعدك على النوم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Chronic sleep deprivation is associated with increased cravings for high-sugar, high-fat foods.',
    'text_ar': 'يرتبط الحرمان المزمن من النوم بزيادة الرغبة الشديدة في تناول الأطعمة الغنية بالسكر والدهون.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Alcohol may help you fall asleep faster but disrupts deep sleep and REM cycles later in the night.',
    'text_ar': 'قد يساعدك الكحول على النوم بشكل أسرع لكنه يُخلّ بالنوم العميق ودورات حركة العين السريعة لاحقاً في الليل.',
    'source': 'NHS',
  },
  {
    'text': 'Kiwi fruit eaten before bed has been linked to improved sleep onset and duration in small studies.',
    'text_ar': 'أظهرت دراسات صغيرة أن تناول فاكهة الكيوي قبل النوم يرتبط بتحسين بداية النوم ومدته.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Spicy foods before bed can raise body temperature and cause indigestion, both of which impair sleep.',
    'text_ar': 'الأطعمة الحارة قبل النوم قد ترفع حرارة الجسم وتسبب عسر الهضم، وكلاهما يُضعف جودة النوم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Tryptophan-rich foods (turkey, milk, bananas) are precursors to serotonin and melatonin, supporting sleep.',
    'text_ar': 'الأطعمة الغنية بالتريبتوفان (الديك الرومي والحليب والموز) هي مواد أولية للسيروتونين والميلاتونين، مما يدعم النوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'People who sleep fewer than 7 hours per night tend to consume more calories the following day.',
    'text_ar': 'يميل الأشخاص الذين ينامون أقل من 7 ساعات في الليلة إلى استهلاك سعرات حرارية أكثر في اليوم التالي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Chamomile tea contains apigenin, an antioxidant that may promote sleepiness and reduce insomnia.',
    'text_ar': 'يحتوي شاي البابونج على الأبيجينين، وهو مضاد أكسدة قد يعزز النعاس ويقلل الأرق.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Irregular meal times can disrupt your circadian rhythm, which in turn affects sleep quality.',
    'text_ar': 'أوقات الوجبات غير المنتظمة قد تُخلّ بالإيقاع اليومي للجسم، مما يؤثر بدوره على جودة النوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A Mediterranean diet pattern has been associated with better sleep quality in multiple studies.',
    'text_ar': 'يرتبط نمط حمية البحر الأبيض المتوسط بجودة نوم أفضل في دراسات متعددة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vitamin D deficiency is linked to sleep disorders; ensure adequate intake through sunlight, food, or supplements.',
    'text_ar': 'يرتبط نقص فيتامين د باضطرابات النوم؛ احرص على الحصول على كمية كافية من خلال أشعة الشمس أو الغذاء أو المكملات.',
    'source': 'NHS',
  },
  {
    'text': 'High-fiber diets are associated with deeper, more restorative slow-wave sleep.',
    'text_ar': 'ترتبط الأنظمة الغذائية الغنية بالألياف بنوم أعمق وأكثر ترميماً من نوع الموجات البطيئة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Warm milk before bed may help with sleep partly due to tryptophan and partly due to the comforting ritual.',
    'text_ar': 'قد يساعد الحليب الدافئ قبل النوم على النوم جزئياً بفضل التريبتوفان وجزئياً بفضل الطقس المريح المصاحب له.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Eating too little during the day can cause hunger-related wakefulness at night.',
    'text_ar': 'تناول كميات قليلة جداً من الطعام خلال النهار قد يسبب الاستيقاظ ليلاً بسبب الجوع.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Consistent meal and sleep schedules work together to keep your body clock properly synchronized.',
    'text_ar': 'تعمل مواعيد الوجبات والنوم المنتظمة معاً للحفاظ على تزامن الساعة البيولوجية للجسم بشكل سليم.',
    'source': 'Mayo Clinic',
  },

  // ── Immune System (321–340) ───────────────────────────────────────────
  {
    'text': 'Vitamin C does not prevent colds but may shorten their duration; citrus fruits, peppers, and strawberries are rich sources.',
    'text_ar': 'فيتامين ج لا يمنع نزلات البرد لكنه قد يقصّر مدتها؛ الحمضيات والفلفل والفراولة مصادر غنية به.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Zinc is essential for immune cell development; shellfish, meat, legumes, and pumpkin seeds provide it.',
    'text_ar': 'الزنك ضروري لتطوير الخلايا المناعية؛ المحار واللحوم والبقوليات وبذور اليقطين توفره.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Vitamin D plays a critical role in immune function; deficiency is linked to increased susceptibility to infection.',
    'text_ar': 'يلعب فيتامين د دوراً حاسماً في وظيفة المناعة؛ ويرتبط نقصه بزيادة القابلية للإصابة بالعدوى.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Garlic contains allicin, which has antimicrobial properties and may support immune function.',
    'text_ar': 'يحتوي الثوم على مادة الأليسين التي تمتلك خصائص مضادة للميكروبات وقد تدعم وظيفة المناعة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Probiotic-rich foods support gut health, where approximately 70% of immune cells reside.',
    'text_ar': 'الأطعمة الغنية بالبروبيوتيك تدعم صحة الأمعاء، حيث يتواجد نحو 70% من الخلايا المناعية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Elderberry supplements have shown some promise in reducing the severity and duration of colds and flu.',
    'text_ar': 'أظهرت مكملات البلسان بعض الفعالية في تقليل شدة ومدة نزلات البرد والإنفلونزا.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Excessive alcohol consumption suppresses both the innate and adaptive immune systems.',
    'text_ar': 'الإفراط في استهلاك الكحول يُثبّط كلاً من الجهاز المناعي الفطري والمكتسب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Beta-carotene in orange and yellow vegetables is converted to vitamin A, which helps maintain immune barriers.',
    'text_ar': 'يتحول البيتا كاروتين الموجود في الخضروات البرتقالية والصفراء إلى فيتامين أ الذي يساعد في الحفاظ على الحواجز المناعية.',
    'source': 'NHS',
  },
  {
    'text': 'Green tea contains catechins, antioxidants that may enhance immune function.',
    'text_ar': 'يحتوي الشاي الأخضر على الكاتيكينات، وهي مضادات أكسدة قد تعزز وظيفة المناعة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Iron deficiency impairs immune responses; ensure adequate intake especially for menstruating women.',
    'text_ar': 'نقص الحديد يُضعف الاستجابات المناعية؛ احرص على تناول كميات كافية خاصة للنساء في سن الحيض.',
    'source': 'WHO',
  },
  {
    'text': 'Selenium supports the immune system; Brazil nuts, fish, and whole grains are good sources.',
    'text_ar': 'السيلينيوم يدعم الجهاز المناعي؛ الجوز البرازيلي والأسماك والحبوب الكاملة مصادر جيدة له.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Turmeric contains curcumin, which has anti-inflammatory properties that may support immune health.',
    'text_ar': 'يحتوي الكركم على مادة الكركمين ذات الخصائص المضادة للالتهابات التي قد تدعم صحة المناعة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vitamin E is a powerful antioxidant that helps the body fight infection; almonds and sunflower seeds are rich sources.',
    'text_ar': 'فيتامين هـ مضاد أكسدة قوي يساعد الجسم على مكافحة العدوى؛ اللوز وبذور دوار الشمس مصادر غنية به.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Mushrooms (especially shiitake and maitake) contain beta-glucans that may stimulate immune activity.',
    'text_ar': 'يحتوي الفطر (خاصة الشيتاكي والمايتاكي) على بيتا غلوكان التي قد تحفّز نشاط الجهاز المناعي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A diet high in processed foods and added sugars may impair immune function over time.',
    'text_ar': 'النظام الغذائي الغني بالأطعمة المصنّعة والسكريات المضافة قد يُضعف وظيفة المناعة مع مرور الوقت.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Adequate protein intake is essential for producing antibodies and immune cells.',
    'text_ar': 'تناول كمية كافية من البروتين ضروري لإنتاج الأجسام المضادة والخلايا المناعية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Ginger has anti-inflammatory and antioxidant properties and may help support immune defenses.',
    'text_ar': 'يتمتع الزنجبيل بخصائص مضادة للالتهابات ومضادة للأكسدة وقد يساعد في دعم الدفاعات المناعية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Honey has natural antibacterial properties and can soothe sore throats, but should not be given to infants under one year.',
    'text_ar': 'يتمتع العسل بخصائص طبيعية مضادة للبكتيريا ويمكن أن يهدئ التهاب الحلق، لكن يجب عدم إعطائه للرضع دون عمر السنة.',
    'source': 'NHS',
  },
  {
    'text': 'Folate supports the production of new cells including immune cells; leafy greens and fortified grains are key sources.',
    'text_ar': 'حمض الفوليك يدعم إنتاج خلايا جديدة بما فيها الخلايا المناعية؛ الخضروات الورقية والحبوب المدعّمة مصادر أساسية له.',
    'source': 'Harvard Health',
  },
  {
    'text': 'No single food or supplement can "boost" your immune system; a balanced overall diet is what matters most.',
    'text_ar': 'لا يوجد طعام أو مكمل واحد يمكنه "تعزيز" جهازك المناعي؛ النظام الغذائي المتوازن الشامل هو الأهم.',
    'source': 'NHS',
  },

  // ── Diabetes Prevention (341–360) ─────────────────────────────────────
  {
    'text': 'Whole grains cause a slower rise in blood sugar compared to refined grains, reducing diabetes risk.',
    'text_ar': 'تسبب الحبوب الكاملة ارتفاعاً أبطأ في سكر الدم مقارنة بالحبوب المكررة، مما يقلل خطر الإصابة بالسكري.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Losing just 5–7% of body weight can reduce the risk of developing type 2 diabetes by up to 58%.',
    'text_ar': 'فقدان 5 إلى 7% فقط من وزن الجسم يمكن أن يقلل خطر الإصابة بالسكري من النوع الثاني بنسبة تصل إلى 58%.',
    'source': 'CDC',
  },
  {
    'text': 'Sugary drinks are one of the strongest dietary risk factors for type 2 diabetes.',
    'text_ar': 'المشروبات السكرية هي أحد أقوى عوامل الخطر الغذائية للإصابة بالسكري من النوع الثاني.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Regular physical activity improves insulin sensitivity, helping your body use blood sugar more effectively.',
    'text_ar': 'النشاط البدني المنتظم يحسّن حساسية الأنسولين، مما يساعد جسمك على استخدام سكر الدم بشكل أكثر فعالية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Fiber slows glucose absorption; aim for at least 30 g per day to help regulate blood sugar.',
    'text_ar': 'الألياف تبطئ امتصاص الجلوكوز؛ استهدف 30 غراماً على الأقل يومياً للمساعدة في تنظيم سكر الدم.',
    'source': 'NHS',
  },
  {
    'text': 'The glycemic index (GI) ranks foods by how quickly they raise blood sugar; choose low-GI foods more often.',
    'text_ar': 'المؤشر الجلايسيمي يصنّف الأطعمة حسب سرعة رفعها لسكر الدم؛ اختر الأطعمة ذات المؤشر المنخفض في أغلب الأحيان.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Cinnamon may have a modest effect on lowering blood sugar levels, though more research is needed.',
    'text_ar': 'قد يكون للقرفة تأثير متواضع في خفض مستويات سكر الدم، رغم الحاجة إلى مزيد من الأبحاث.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Eating protein and healthy fat with carbohydrates slows the blood sugar response after a meal.',
    'text_ar': 'تناول البروتين والدهون الصحية مع الكربوهيدرات يبطئ استجابة سكر الدم بعد الوجبة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Nuts consumed regularly are associated with a reduced risk of type 2 diabetes in large population studies.',
    'text_ar': 'يرتبط تناول المكسرات بانتظام بانخفاض خطر الإصابة بالسكري من النوع الثاني في دراسات سكانية كبيرة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vinegar consumed before a meal may slow the digestion of starch and reduce post-meal blood sugar spikes.',
    'text_ar': 'تناول الخل قبل الوجبة قد يبطئ هضم النشا ويقلل ارتفاع سكر الدم بعد الأكل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Coffee consumption (both regular and decaf) has been associated with a lower risk of type 2 diabetes.',
    'text_ar': 'يرتبط استهلاك القهوة (العادية ومنزوعة الكافيين) بانخفاض خطر الإصابة بالسكري من النوع الثاني.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Replacing white rice with brown rice even part of the time can meaningfully reduce type 2 diabetes risk.',
    'text_ar': 'استبدال الأرز الأبيض بالأرز البني حتى جزئياً يمكن أن يقلل بشكل ملموس من خطر الإصابة بالسكري من النوع الثاني.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excess belly fat is more closely linked to insulin resistance than fat stored elsewhere in the body.',
    'text_ar': 'دهون البطن الزائدة مرتبطة بمقاومة الأنسولين أكثر من الدهون المخزّنة في أجزاء أخرى من الجسم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Legumes have a low glycemic index and high fiber content, making them excellent for blood sugar management.',
    'text_ar': 'تتمتع البقوليات بمؤشر جلايسيمي منخفض ومحتوى عالٍ من الألياف، مما يجعلها ممتازة لإدارة سكر الدم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Chronic sleep deprivation impairs glucose metabolism and increases type 2 diabetes risk.',
    'text_ar': 'الحرمان المزمن من النوم يُضعف أيض الجلوكوز ويزيد خطر الإصابة بالسكري من النوع الثاني.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A brisk 30-minute walk daily can significantly reduce the risk of developing type 2 diabetes.',
    'text_ar': 'المشي السريع لمدة 30 دقيقة يومياً يمكن أن يقلل بشكل كبير من خطر الإصابة بالسكري من النوع الثاني.',
    'source': 'WHO',
  },
  {
    'text': 'Portion control is key for blood sugar management; even healthy foods raise glucose if eaten in excess.',
    'text_ar': 'التحكم في حجم الحصص أساسي لإدارة سكر الدم؛ حتى الأطعمة الصحية ترفع الجلوكوز إذا أُكلت بإفراط.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Magnesium intake from food sources is inversely associated with type 2 diabetes risk.',
    'text_ar': 'يرتبط تناول المغنيسيوم من مصادر غذائية عكسياً بخطر الإصابة بالسكري من النوع الثاني.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating vegetables before carbohydrates in a meal may reduce the post-meal blood sugar spike.',
    'text_ar': 'تناول الخضروات قبل الكربوهيدرات في الوجبة قد يقلل من ارتفاع سكر الدم بعد الأكل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Prediabetes can often be reversed with diet and lifestyle changes before it progresses to type 2 diabetes.',
    'text_ar': 'يمكن عكس حالة ما قبل السكري في كثير من الأحيان بتغييرات في النظام الغذائي ونمط الحياة قبل تطورها إلى السكري من النوع الثاني.',
    'source': 'CDC',
  },

  // ── Children & Adolescent Nutrition (361–380) ─────────────────────────
  {
    'text': 'Children need a variety of foods from all food groups for proper growth and development.',
    'text_ar': 'يحتاج الأطفال إلى تنوع في الأطعمة من جميع المجموعات الغذائية لضمان النمو والتطور السليم.',
    'source': 'NHS',
  },
  {
    'text': 'Breakfast is especially important for children; it improves concentration, memory, and academic performance.',
    'text_ar': 'وجبة الإفطار مهمة بشكل خاص للأطفال؛ فهي تحسّن التركيز والذاكرة والأداء الأكاديمي.',
    'source': 'NHS',
  },
  {
    'text': 'Children should have no more than 1 sugary drink per day; water and milk are the best choices.',
    'text_ar': 'يجب ألا يتناول الأطفال أكثر من مشروب سكري واحد يومياً؛ الماء والحليب هما الخيار الأفضل.',
    'source': 'WHO',
  },
  {
    'text': 'Introducing a wide variety of vegetables early in life increases acceptance of healthy foods later.',
    'text_ar': 'تقديم مجموعة واسعة من الخضروات في مرحلة مبكرة من الحياة يزيد من تقبّل الأطعمة الصحية لاحقاً.',
    'source': 'NHS',
  },
  {
    'text': 'Children who eat family meals together tend to eat more fruits and vegetables and fewer processed foods.',
    'text_ar': 'يميل الأطفال الذين يتناولون وجبات عائلية مشتركة إلى أكل المزيد من الفواكه والخضروات وأطعمة مصنّعة أقل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Calcium and vitamin D are critical during childhood and adolescence for building strong bones.',
    'text_ar': 'الكالسيوم وفيتامين د ضروريان خلال مرحلة الطفولة والمراهقة لبناء عظام قوية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Iron deficiency is the most common nutritional deficiency in children worldwide and affects cognitive development.',
    'text_ar': 'نقص الحديد هو أكثر حالات نقص التغذية شيوعاً لدى الأطفال عالمياً ويؤثر على التطور المعرفي.',
    'source': 'WHO',
  },
  {
    'text': 'Toddlers may need to be offered a new food 10–15 times before they accept it; persistence pays off.',
    'text_ar': 'قد يحتاج الأطفال الصغار إلى تقديم طعام جديد لهم من 10 إلى 15 مرة قبل أن يتقبّلوه؛ المثابرة تؤتي ثمارها.',
    'source': 'NHS',
  },
  {
    'text': 'Limiting screen time during meals helps children focus on hunger and fullness cues.',
    'text_ar': 'تقليل وقت الشاشات أثناء الوجبات يساعد الأطفال على التركيز على إشارات الجوع والشبع.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Involving children in food preparation encourages them to try new foods and develop healthy habits.',
    'text_ar': 'إشراك الأطفال في تحضير الطعام يشجعهم على تجربة أطعمة جديدة وتطوير عادات صحية.',
    'source': 'NHS',
  },
  {
    'text': 'Adolescents have higher calorie and nutrient needs than adults due to rapid growth and development.',
    'text_ar': 'يحتاج المراهقون إلى سعرات حرارية ومغذيات أكثر من البالغين بسبب النمو والتطور السريع.',
    'source': 'WHO',
  },
  {
    'text': 'Fruit juice should be limited to 150 ml per day for children; whole fruit is a better option.',
    'text_ar': 'يجب تقليل عصير الفاكهة إلى 150 مل يومياً للأطفال؛ الفاكهة الكاملة خيار أفضل.',
    'source': 'NHS',
  },
  {
    'text': 'Packing healthy school lunches with a protein, whole grain, fruit, and vegetable supports learning.',
    'text_ar': 'تحضير وجبات مدرسية صحية تحتوي على بروتين وحبوب كاملة وفاكهة وخضروات يدعم التعلّم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Children should not follow adult weight-loss diets; they need adequate calories and nutrients to grow.',
    'text_ar': 'يجب ألا يتبع الأطفال أنظمة إنقاص الوزن المخصصة للبالغين؛ فهم يحتاجون إلى سعرات حرارية ومغذيات كافية للنمو.',
    'source': 'NHS',
  },
  {
    'text': 'Omega-3 fatty acids from fish support brain development in children; aim for 1–2 servings per week.',
    'text_ar': 'أحماض أوميغا 3 الدهنية من الأسماك تدعم نمو الدماغ لدى الأطفال؛ استهدف حصة إلى حصتين أسبوعياً.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Honey should never be given to children under 12 months due to the risk of infant botulism.',
    'text_ar': 'يجب عدم إعطاء العسل أبداً للأطفال دون 12 شهراً بسبب خطر التسمم الغذائي الوشيقي عند الرضع.',
    'source': 'NHS',
  },
  {
    'text': 'Healthy snacks for children include fruit slices, vegetable sticks with hummus, yogurt, and whole grain crackers.',
    'text_ar': 'الوجبات الخفيفة الصحية للأطفال تشمل شرائح الفاكهة وأصابع الخضروات مع الحمص والزبادي وبسكويت الحبوب الكاملة.',
    'source': 'NHS',
  },
  {
    'text': 'Excessive salt in children\'s diets can establish a preference for salty foods and raise blood pressure.',
    'text_ar': 'الملح الزائد في غذاء الأطفال قد يرسّخ تفضيلاً للأطعمة المالحة ويرفع ضغط الدم.',
    'source': 'WHO',
  },
  {
    'text': 'Exclusive breastfeeding for the first 6 months provides ideal nutrition and protects against infections.',
    'text_ar': 'الرضاعة الطبيعية الحصرية خلال الأشهر الستة الأولى توفر تغذية مثالية وتحمي من العدوى.',
    'source': 'WHO',
  },
  {
    'text': 'Teaching children to read simple food labels empowers them to make healthier choices as they grow.',
    'text_ar': 'تعليم الأطفال قراءة ملصقات الطعام البسيطة يمكّنهم من اتخاذ خيارات صحية أفضل مع نموهم.',
    'source': 'Harvard Health',
  },

  // ── Skin Health & Nutrition (381–395) ─────────────────────────────────
  {
    'text': 'Vitamin C is essential for collagen production, which keeps skin firm and helps wounds heal.',
    'text_ar': 'فيتامين ج ضروري لإنتاج الكولاجين الذي يحافظ على متانة البشرة ويساعد في التئام الجروح.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Omega-3 fatty acids help maintain the skin\'s lipid barrier, keeping it moisturized and reducing inflammation.',
    'text_ar': 'تساعد أحماض أوميغا 3 الدهنية في الحفاظ على حاجز الدهون في البشرة، مما يبقيها رطبة ويقلل الالتهاب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Lycopene in cooked tomatoes may provide some protection against UV skin damage from the inside.',
    'text_ar': 'قد يوفر الليكوبين الموجود في الطماطم المطبوخة بعض الحماية من أضرار الأشعة فوق البنفسجية للبشرة من الداخل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Adequate hydration helps maintain skin elasticity and overall appearance.',
    'text_ar': 'الترطيب الكافي يساعد في الحفاظ على مرونة البشرة ومظهرها العام.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Vitamin E in nuts and seeds acts as an antioxidant that protects skin cells from oxidative damage.',
    'text_ar': 'فيتامين هـ الموجود في المكسرات والبذور يعمل كمضاد أكسدة يحمي خلايا البشرة من الضرر التأكسدي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Beta-carotene in carrots, sweet potatoes, and pumpkin gives skin a healthy glow and acts as a natural sunscreen.',
    'text_ar': 'البيتا كاروتين الموجود في الجزر والبطاطا الحلوة واليقطين يمنح البشرة توهجاً صحياً ويعمل كواقٍ طبيعي من الشمس.',
    'source': 'Harvard Health',
  },
  {
    'text': 'High-sugar diets accelerate glycation, a process that damages collagen and elastin, leading to premature aging.',
    'text_ar': 'الأنظمة الغذائية الغنية بالسكر تُسرّع عملية الغلوزة التي تُتلف الكولاجين والإيلاستين، مما يؤدي إلى الشيخوخة المبكرة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Zinc supports skin repair and renewal; deficiency can cause slow wound healing and skin rashes.',
    'text_ar': 'الزنك يدعم إصلاح البشرة وتجددها؛ ونقصه يمكن أن يسبب بطء التئام الجروح وطفحاً جلدياً.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Green tea polyphenols may protect skin from UV radiation and improve skin elasticity.',
    'text_ar': 'قد تحمي مادة البوليفينول في الشاي الأخضر البشرة من الأشعة فوق البنفسجية وتحسّن مرونتها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Avocados provide healthy fats and vitamins C and E, all of which support skin health.',
    'text_ar': 'يوفر الأفوكادو دهوناً صحية وفيتامينات ج وهـ، وجميعها تدعم صحة البشرة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Excessive alcohol consumption dehydrates the skin and can worsen conditions like rosacea and eczema.',
    'text_ar': 'الإفراط في استهلاك الكحول يُجفف البشرة وقد يُفاقم حالات مثل الوردية والأكزيما.',
    'source': 'NHS',
  },
  {
    'text': 'Biotin (vitamin B7) supports healthy skin, hair, and nails; eggs, nuts, and whole grains are good sources.',
    'text_ar': 'البيوتين (فيتامين ب7) يدعم صحة البشرة والشعر والأظافر؛ البيض والمكسرات والحبوب الكاملة مصادر جيدة له.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Dark chocolate (70%+ cocoa) contains flavonoids that may improve skin hydration and blood flow to the skin.',
    'text_ar': 'الشوكولاتة الداكنة (بنسبة كاكاو 70% أو أكثر) تحتوي على الفلافونويدات التي قد تحسّن ترطيب البشرة وتدفق الدم إليها.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Selenium helps protect skin from oxidative stress; Brazil nuts, fish, and eggs are excellent sources.',
    'text_ar': 'السيلينيوم يساعد في حماية البشرة من الإجهاد التأكسدي؛ الجوز البرازيلي والأسماك والبيض مصادر ممتازة له.',
    'source': 'Harvard Health',
  },
  {
    'text': 'A diet rich in fruits and vegetables provides antioxidants that combat free radical damage to skin cells.',
    'text_ar': 'النظام الغذائي الغني بالفواكه والخضروات يوفر مضادات أكسدة تكافح أضرار الجذور الحرة لخلايا البشرة.',
    'source': 'NHS',
  },

  // ── Aging & Nutrition (396–415) ───────────────────────────────────────
  {
    'text': 'Older adults need more protein per kilogram of body weight to maintain muscle mass and prevent sarcopenia.',
    'text_ar': 'يحتاج كبار السن إلى المزيد من البروتين لكل كيلوغرام من وزن الجسم للحفاظ على الكتلة العضلية والوقاية من ضمور العضلات.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vitamin B12 absorption decreases with age; adults over 50 should consider fortified foods or supplements.',
    'text_ar': 'يتناقص امتصاص فيتامين ب12 مع التقدم في العمر؛ يُنصح البالغون فوق الخمسين بتناول الأطعمة المدعّمة أو المكملات.',
    'source': 'NHS',
  },
  {
    'text': 'Calcium needs increase after age 50; aim for 1200 mg per day from food and supplements if needed.',
    'text_ar': 'تزداد الحاجة إلى الكالسيوم بعد سن الخمسين؛ استهدف 1200 ملغ يومياً من الغذاء والمكملات عند الحاجة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'The Mediterranean diet is associated with slower cognitive decline and reduced risk of Alzheimer\'s disease.',
    'text_ar': 'يرتبط نظام حمية البحر الأبيض المتوسط بتباطؤ التدهور المعرفي وانخفاض خطر الإصابة بمرض الزهايمر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Dehydration risk increases with age as the sense of thirst diminishes; drink water regularly throughout the day.',
    'text_ar': 'يزداد خطر الجفاف مع التقدم في العمر لأن الإحساس بالعطش يتراجع؛ اشرب الماء بانتظام طوال اليوم.',
    'source': 'NHS',
  },
  {
    'text': 'Blueberries and other berry fruits may help protect the brain from age-related decline due to their flavonoid content.',
    'text_ar': 'قد يساعد التوت الأزرق وأنواع التوت الأخرى في حماية الدماغ من التدهور المرتبط بالتقدم في العمر بفضل محتواها من مركبات الفلافونويد.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Vitamin D supplementation becomes more important with age as the skin\'s ability to synthesize it from sunlight decreases.',
    'text_ar': 'تزداد أهمية مكملات فيتامين د مع التقدم في العمر، إذ تتراجع قدرة الجلد على تصنيعه من أشعة الشمس.',
    'source': 'NHS',
  },
  {
    'text': 'Sarcopenia (age-related muscle loss) can be slowed with adequate protein intake and resistance exercise.',
    'text_ar': 'يمكن إبطاء ضمور العضلات المرتبط بالعمر (الساركوبينيا) من خلال تناول كميات كافية من البروتين وممارسة تمارين المقاومة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Omega-3 fatty acids may help reduce inflammation associated with age-related diseases like arthritis.',
    'text_ar': 'قد تساعد أحماض أوميغا-3 الدهنية في تقليل الالتهابات المرتبطة بأمراض الشيخوخة كالتهاب المفاصل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Fiber intake remains important for older adults to maintain digestive health and prevent constipation.',
    'text_ar': 'يظل تناول الألياف مهمًا لكبار السن للحفاظ على صحة الجهاز الهضمي والوقاية من الإمساك.',
    'source': 'NHS',
  },
  {
    'text': 'Smaller, more frequent meals can help older adults who find large meals difficult or have reduced appetite.',
    'text_ar': 'يمكن للوجبات الصغيرة والمتكررة أن تساعد كبار السن الذين يجدون صعوبة في تناول وجبات كبيرة أو يعانون من ضعف الشهية.',
    'source': 'NHS',
  },
  {
    'text': 'Leafy green vegetables (spinach, kale) are associated with slower age-related cognitive decline.',
    'text_ar': 'ترتبط الخضروات الورقية الخضراء (كالسبانخ والكرنب الأجعد) بإبطاء التدهور المعرفي المرتبط بالعمر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Potassium becomes more important with age to help control blood pressure; bananas, potatoes, and beans are good sources.',
    'text_ar': 'يزداد البوتاسيوم أهمية مع التقدم في العمر للمساعدة في التحكم بضغط الدم؛ والموز والبطاطا والبقوليات مصادر جيدة له.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Social isolation can reduce appetite in older adults; eating with others encourages better nutrition.',
    'text_ar': 'قد تقلل العزلة الاجتماعية من شهية كبار السن؛ وتناول الطعام مع الآخرين يشجع على تغذية أفضل.',
    'source': 'NHS',
  },
  {
    'text': 'Foods fortified with vitamin D and calcium (like fortified cereals and plant milks) are especially valuable for older adults.',
    'text_ar': 'تُعدّ الأطعمة المدعمة بفيتامين د والكالسيوم (كحبوب الإفطار المدعمة وحليب النبات) ذات قيمة خاصة لكبار السن.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Antioxidant-rich foods (berries, dark chocolate, pecans) help combat oxidative stress associated with aging.',
    'text_ar': 'تساعد الأطعمة الغنية بمضادات الأكسدة (كالتوت والشوكولاتة الداكنة والجوز البقان) في مكافحة الإجهاد التأكسدي المرتبط بالشيخوخة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Adequate folate intake helps maintain red blood cell production, which can decline with age.',
    'text_ar': 'يساعد تناول كمية كافية من حمض الفوليك في الحفاظ على إنتاج خلايا الدم الحمراء الذي قد يتراجع مع التقدم في العمر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Staying well-nourished supports immune function, which naturally weakens with age.',
    'text_ar': 'يدعم الحصول على تغذية جيدة وظيفة الجهاز المناعي التي تضعف بشكل طبيعي مع التقدم في العمر.',
    'source': 'NHS',
  },
  {
    'text': 'Dental health affects nutrition in older adults; soft-textured protein sources like eggs, fish, and yogurt can help.',
    'text_ar': 'تؤثر صحة الأسنان على تغذية كبار السن؛ ويمكن أن تساعد مصادر البروتين طرية القوام كالبيض والسمك والزبادي.',
    'source': 'NHS',
  },
  {
    'text': 'The MIND diet (combining Mediterranean and DASH diets) was specifically designed to support brain health in aging.',
    'text_ar': 'صُمم نظام مايند الغذائي (الذي يجمع بين حمية البحر الأبيض المتوسط وحمية داش) خصيصًا لدعم صحة الدماغ أثناء الشيخوخة.',
    'source': 'Harvard Health',
  },

  // ── Sports & Exercise Nutrition (416–435) ─────────────────────────────
  {
    'text': 'Carbohydrates are the primary fuel source during moderate-to-high intensity exercise.',
    'text_ar': 'الكربوهيدرات هي مصدر الوقود الأساسي أثناء التمارين متوسطة إلى عالية الشدة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Eating a meal 2–3 hours before exercise provides energy without causing digestive discomfort.',
    'text_ar': 'يوفر تناول وجبة قبل التمرين بساعتين إلى ثلاث ساعات الطاقة دون التسبب في اضطرابات هضمية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Post-exercise nutrition should include both carbohydrates (to replenish glycogen) and protein (for muscle repair).',
    'text_ar': 'يجب أن تتضمن التغذية بعد التمرين كربوهيدرات (لتعويض الغليكوجين) وبروتينًا (لإصلاح العضلات).',
    'source': 'Harvard Health',
  },
  {
    'text': 'For exercise lasting less than 60 minutes, water is sufficient; sports drinks are unnecessary.',
    'text_ar': 'بالنسبة للتمارين التي تقل مدتها عن 60 دقيقة، يكفي شرب الماء؛ ولا حاجة لمشروبات الطاقة الرياضية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Bananas are an excellent pre-workout snack, providing easily digestible carbohydrates and potassium.',
    'text_ar': 'يُعدّ الموز وجبة خفيفة ممتازة قبل التمرين، إذ يوفر كربوهيدرات سهلة الهضم وبوتاسيوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Chocolate milk is an effective post-workout recovery drink due to its optimal ratio of carbs to protein.',
    'text_ar': 'يُعتبر حليب الشوكولاتة مشروبًا فعالًا للتعافي بعد التمرين بفضل نسبته المثالية من الكربوهيدرات إلى البروتين.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Creatine is one of the most well-studied sports supplements and can improve performance in short, intense activities.',
    'text_ar': 'يُعدّ الكرياتين من أكثر المكملات الرياضية التي خضعت للدراسة، ويمكنه تحسين الأداء في الأنشطة القصيرة والمكثفة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Electrolytes (sodium, potassium, magnesium) lost through sweat need to be replaced during prolonged exercise.',
    'text_ar': 'يجب تعويض الإلكتروليتات (الصوديوم والبوتاسيوم والمغنيسيوم) المفقودة عبر التعرق أثناء التمارين المطولة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Caffeine consumed 30–60 minutes before exercise can improve endurance performance and reduce perceived effort.',
    'text_ar': 'يمكن أن يحسّن تناول الكافيين قبل التمرين بـ 30 إلى 60 دقيقة من أداء التحمل ويقلل الشعور بالجهد.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Female athletes should pay special attention to iron intake, as deficiency can impair performance.',
    'text_ar': 'يجب على الرياضيات الإناث الاهتمام بشكل خاص بتناول الحديد، إذ قد يؤثر نقصه سلبًا على الأداء.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Overhydrating during exercise (hyponatremia) can be dangerous; drink to thirst rather than forcing fluids.',
    'text_ar': 'قد يكون الإفراط في شرب الماء أثناء التمرين (نقص صوديوم الدم) خطيرًا؛ اشرب وفقًا لشعورك بالعطش بدلًا من إجبار نفسك على شرب السوائل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Complex carbs (oatmeal, whole grain toast) are better pre-exercise choices than simple sugars for sustained energy.',
    'text_ar': 'تُعدّ الكربوهيدرات المعقدة (كالشوفان وخبز الحبوب الكاملة) خيارات أفضل قبل التمرين من السكريات البسيطة لطاقة مستدامة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Beetroot juice contains nitrates that may improve exercise efficiency and endurance performance.',
    'text_ar': 'يحتوي عصير الشمندر على نترات قد تحسّن كفاءة التمرين وأداء التحمل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Protein needs for regular exercisers are 1.2–2.0 g per kg of body weight per day, depending on intensity.',
    'text_ar': 'تتراوح احتياجات البروتين لمن يمارسون الرياضة بانتظام بين 1.2 و2.0 غرام لكل كيلوغرام من وزن الجسم يوميًا، حسب شدة التمرين.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Avoid high-fat and high-fiber meals immediately before exercise, as they are slower to digest.',
    'text_ar': 'تجنب الوجبات الغنية بالدهون والألياف مباشرة قبل التمرين، لأنها أبطأ في الهضم.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Tart cherry juice may reduce muscle soreness and inflammation after intense exercise.',
    'text_ar': 'قد يقلل عصير الكرز الحامض من آلام العضلات والالتهابات بعد التمارين المكثفة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Adequate glycogen stores before exercise prevent early fatigue; eat sufficient carbohydrates in the hours beforehand.',
    'text_ar': 'يمنع وجود مخزون كافٍ من الغليكوجين قبل التمرين الإرهاق المبكر؛ تناول كمية كافية من الكربوهيدرات في الساعات السابقة للتمرين.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'The anabolic window after exercise is wider than once thought; eating protein within 2 hours is sufficient.',
    'text_ar': 'نافذة البناء العضلي بعد التمرين أوسع مما كان يُعتقد سابقًا؛ يكفي تناول البروتين خلال ساعتين من التمرين.',
    'source': 'Harvard Health',
  },
  {
    'text': 'For endurance events over 90 minutes, consuming 30–60 g of carbohydrates per hour during exercise helps maintain performance.',
    'text_ar': 'في فعاليات التحمل التي تتجاوز 90 دقيقة، يساعد تناول 30 إلى 60 غرامًا من الكربوهيدرات في الساعة أثناء التمرين على الحفاظ على الأداء.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Adequate sleep is as important as nutrition for exercise recovery and performance improvement.',
    'text_ar': 'يُعدّ النوم الكافي بنفس أهمية التغذية لتعافي الجسم بعد التمرين وتحسين الأداء.',
    'source': 'Harvard Health',
  },

  // ── Sustainability & Eating (436–450) ─────────────────────────────────
  {
    'text': 'Plant-based diets generally have a lower environmental footprint than diets high in animal products.',
    'text_ar': 'تمتلك الأنظمة الغذائية النباتية عمومًا بصمة بيئية أقل مقارنة بالأنظمة الغنية بالمنتجات الحيوانية.',
    'source': 'WHO',
  },
  {
    'text': 'Reducing food waste at home saves money and reduces the environmental impact of food production.',
    'text_ar': 'يوفر تقليل هدر الطعام في المنزل المال ويقلل الأثر البيئي لإنتاج الغذاء.',
    'source': 'NHS',
  },
  {
    'text': 'Buying seasonal, locally grown produce reduces transport emissions and often means fresher, tastier food.',
    'text_ar': 'يقلل شراء المنتجات الموسمية والمحلية من انبعاثات النقل، وغالبًا ما يعني طعامًا أكثر طزاجة ولذة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Legumes (beans, lentils) are one of the most sustainable protein sources, enriching soil with nitrogen as they grow.',
    'text_ar': 'تُعدّ البقوليات (كالفاصوليا والعدس) من أكثر مصادر البروتين استدامة، إذ تُثري التربة بالنيتروجين أثناء نموها.',
    'source': 'WHO',
  },
  {
    'text': 'Planning meals and making a shopping list reduces food waste and unnecessary packaging.',
    'text_ar': 'يقلل التخطيط للوجبات وإعداد قائمة تسوق من هدر الطعام والتغليف غير الضروري.',
    'source': 'NHS',
  },
  {
    'text': 'Eating less red meat and more plant-based proteins is one of the most impactful dietary changes for the planet.',
    'text_ar': 'يُعدّ تناول كميات أقل من اللحوم الحمراء والمزيد من البروتينات النباتية من أكثر التغييرات الغذائية تأثيرًا إيجابيًا على كوكب الأرض.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Frozen fruits and vegetables have a longer shelf life, reducing waste while retaining nutritional value.',
    'text_ar': 'تتمتع الفواكه والخضروات المجمدة بعمر تخزين أطول، مما يقلل الهدر مع الحفاظ على القيمة الغذائية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Using leftover vegetables in soups, stir-fries, or smoothies prevents waste and adds nutrition.',
    'text_ar': 'يمنع استخدام بقايا الخضروات في الحساء أو القلي السريع أو العصائر الهدرَ ويضيف قيمة غذائية.',
    'source': 'NHS',
  },
  {
    'text': 'Choosing sustainably sourced fish helps protect ocean ecosystems; look for MSC certification.',
    'text_ar': 'يساعد اختيار الأسماك المستدامة المصدر في حماية النظم البيئية البحرية؛ ابحث عن شهادة MSC.',
    'source': 'NHS',
  },
  {
    'text': 'Composting food scraps diverts waste from landfills and creates nutrient-rich soil.',
    'text_ar': 'يحوّل تحويل بقايا الطعام إلى سماد عضوي النفايات بعيدًا عن مكبات القمامة ويُنتج تربة غنية بالمغذيات.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Tap water has a far lower environmental impact than bottled water and is safe in most developed countries.',
    'text_ar': 'يمتلك ماء الصنبور أثرًا بيئيًا أقل بكثير من المياه المعبأة، وهو آمن في معظم الدول المتقدمة.',
    'source': 'NHS',
  },
  {
    'text': 'Understanding "best before" vs "use by" dates prevents discarding perfectly safe food unnecessarily.',
    'text_ar': 'يمنع فهم الفرق بين عبارتي "يُفضل الاستخدام قبل" و"يُستخدم قبل" التخلص من طعام آمن تمامًا دون داعٍ.',
    'source': 'NHS',
  },
  {
    'text': 'Growing herbs at home (basil, parsley, mint) reduces packaging waste and adds fresh flavor to cooking.',
    'text_ar': 'تقلل زراعة الأعشاب في المنزل (كالريحان والبقدونس والنعناع) من نفايات التغليف وتضيف نكهة طازجة للطبخ.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Choosing whole, unprocessed foods reduces packaging waste compared to heavily packaged processed products.',
    'text_ar': 'يقلل اختيار الأطعمة الكاملة غير المصنعة من نفايات التغليف مقارنة بالمنتجات المصنعة ذات التغليف الكثيف.',
    'source': 'NHS',
  },
  {
    'text': 'A flexitarian approach (mostly plant-based with occasional meat) balances health and sustainability goals.',
    'text_ar': 'يحقق النهج المرن في التغذية (نباتي في الغالب مع لحوم في بعض الأحيان) التوازن بين أهداف الصحة والاستدامة.',
    'source': 'Harvard Health',
  },

  // ── Snacking & Mindful Eating (451–470) ───────────────────────────────
  {
    'text': 'Pairing protein with fiber in snacks (e.g. apple with peanut butter) provides lasting energy and satiety.',
    'text_ar': 'يوفر الجمع بين البروتين والألياف في الوجبات الخفيفة (كالتفاح مع زبدة الفول السوداني) طاقة مستدامة وشعورًا بالشبع.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating directly from large packages makes it easy to overconsume; portion snacks into small bowls instead.',
    'text_ar': 'يسهّل تناول الطعام مباشرة من العبوات الكبيرة الإفراط في الأكل؛ قسّم الوجبات الخفيفة في أطباق صغيرة بدلًا من ذلك.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Nuts are calorie-dense but highly satiating; a small handful (30 g) makes a nutritious snack.',
    'text_ar': 'المكسرات غنية بالسعرات الحرارية لكنها تمنح شعورًا عاليًا بالشبع؛ وحفنة صغيرة (30 غرامًا) تُشكل وجبة خفيفة مغذية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating while distracted (TV, phone, computer) leads to consuming more calories without realizing it.',
    'text_ar': 'يؤدي تناول الطعام أثناء الانشغال (كمشاهدة التلفزيون أو استخدام الهاتف أو الحاسوب) إلى استهلاك سعرات حرارية أكثر دون إدراك.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Hard-boiled eggs are a portable, protein-rich snack that keeps you full between meals.',
    'text_ar': 'يُعدّ البيض المسلوق وجبة خفيفة غنية بالبروتين وسهلة الحمل تُبقيك ممتلئًا بين الوجبات.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Before reaching for a snack, pause and ask if you are truly hungry or eating out of boredom or habit.',
    'text_ar': 'قبل تناول وجبة خفيفة، توقف واسأل نفسك ما إذا كنت جائعًا حقًا أم تأكل بدافع الملل أو العادة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Edamame is a fiber-and protein-rich snack with only about 120 calories per half cup.',
    'text_ar': 'فول الصويا الأخضر (إدامامي) وجبة خفيفة غنية بالألياف والبروتين تحتوي على نحو 120 سعرة حرارية فقط لكل نصف كوب.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Keeping unhealthy snacks out of sight (or out of the house) significantly reduces mindless eating.',
    'text_ar': 'يقلل إبعاد الوجبات الخفيفة غير الصحية عن الأنظار (أو عدم إحضارها للمنزل) بشكل كبير من الأكل غير الواعي.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Greek yogurt with berries provides protein, probiotics, fiber, and antioxidants in one snack.',
    'text_ar': 'يوفر الزبادي اليوناني مع التوت البروتين والبروبيوتيك والألياف ومضادات الأكسدة في وجبة خفيفة واحدة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Savoring food by eating slowly and noticing flavors increases satisfaction and reduces the desire to overeat.',
    'text_ar': 'يزيد تذوق الطعام ببطء والانتباه للنكهات من الشعور بالرضا ويقلل الرغبة في الإفراط في الأكل.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Air-popped popcorn is a whole grain, high-fiber snack with only about 30 calories per cup.',
    'text_ar': 'يُعدّ الفشار المحضر بالهواء الساخن وجبة خفيفة من الحبوب الكاملة الغنية بالألياف تحتوي على نحو 30 سعرة حرارية فقط لكل كوب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Planning snacks as part of your daily meals prevents random grazing on whatever is available.',
    'text_ar': 'يمنع التخطيط للوجبات الخفيفة كجزء من وجباتك اليومية الأكل العشوائي من أي شيء متاح.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Hummus with vegetable sticks (carrots, celery, peppers) provides fiber, protein, and healthy fats.',
    'text_ar': 'يوفر الحمص مع أصابع الخضار (كالجزر والكرفس والفلفل) الألياف والبروتين والدهون الصحية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eating in a calm, seated position rather than standing or rushing improves digestion and satisfaction.',
    'text_ar': 'يحسّن تناول الطعام بهدوء وأنت جالس بدلًا من الوقوف أو الاستعجال عملية الهضم والشعور بالرضا.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Trail mix can be healthy but watch for added sugar, chocolate, and excessive dried fruit; make your own for better control.',
    'text_ar': 'يمكن أن يكون مزيج المكسرات والفواكه المجففة صحيًا، لكن احذر من السكر المضاف والشوكولاتة والإفراط في الفواكه المجففة؛ حضّره بنفسك للتحكم بشكل أفضل.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Putting your fork down between bites is a simple technique to slow down and eat more mindfully.',
    'text_ar': 'يُعدّ وضع الشوكة على الطاولة بين كل لقمة وأخرى أسلوبًا بسيطًا لإبطاء الأكل وتناوله بوعي أكبر.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Cottage cheese with pineapple or berries is a high-protein, satisfying snack under 200 calories.',
    'text_ar': 'يُعدّ الجبن القريش مع الأناناس أو التوت وجبة خفيفة غنية بالبروتين ومُشبعة تحتوي على أقل من 200 سعرة حرارية.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Hunger peaks about 4–5 hours after a meal; planning a snack at this time prevents overeating at the next meal.',
    'text_ar': 'يبلغ الجوع ذروته بعد نحو 4 إلى 5 ساعات من الوجبة؛ والتخطيط لوجبة خفيفة في هذا الوقت يمنع الإفراط في الأكل في الوجبة التالية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Rice cakes topped with avocado or nut butter make a crunchy, satisfying snack with balanced macros.',
    'text_ar': 'تُشكل كعكات الأرز مع الأفوكادو أو زبدة المكسرات وجبة خفيفة مقرمشة ومُشبعة بعناصر غذائية متوازنة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Checking in with your body after eating — "Am I satisfied?" — builds awareness and prevents overconsumption.',
    'text_ar': 'يبني التحقق من إحساسك الجسدي بعد الأكل — "هل أنا راضٍ؟" — وعيًا يمنع الإفراط في الاستهلاك.',
    'source': 'Mayo Clinic',
  },

  // ── Breakfast & Morning Nutrition (471–485) ───────────────────────────
  {
    'text': 'People who eat breakfast regularly tend to have better nutrient intake and healthier body weight.',
    'text_ar': 'يميل الأشخاص الذين يتناولون وجبة الإفطار بانتظام إلى الحصول على تغذية أفضل ووزن جسم أكثر صحة.',
    'source': 'NHS',
  },
  {
    'text': 'A breakfast containing protein (eggs, yogurt) keeps blood sugar stable and reduces mid-morning cravings.',
    'text_ar': 'يحافظ إفطار يحتوي على البروتين (كالبيض والزبادي) على استقرار سكر الدم ويقلل الرغبة في تناول الطعام منتصف الصباح.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Overnight oats are a convenient no-cook breakfast that provides fiber, protein, and slow-release energy.',
    'text_ar': 'يُعدّ الشوفان المنقوع طوال الليل إفطارًا مريحًا لا يحتاج للطهي ويوفر الألياف والبروتين والطاقة بطيئة الإطلاق.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Many commercial breakfast cereals are high in sugar; choose those with less than 5 g of sugar per serving.',
    'text_ar': 'تحتوي كثير من حبوب الإفطار التجارية على نسبة عالية من السكر؛ اختر تلك التي تحتوي على أقل من 5 غرامات من السكر لكل حصة.',
    'source': 'NHS',
  },
  {
    'text': 'Adding a handful of berries to your breakfast significantly boosts your antioxidant intake for the day.',
    'text_ar': 'تعزز إضافة حفنة من التوت إلى إفطارك بشكل كبير من تناولك لمضادات الأكسدة خلال اليوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Whole grain toast with avocado provides healthy fats, fiber, and sustained energy to start the day.',
    'text_ar': 'يوفر خبز الحبوب الكاملة المحمص مع الأفوكادو دهونًا صحية وأليافًا وطاقة مستدامة لبدء اليوم.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Smoothies can be nutritious breakfasts if they include protein (yogurt, nut butter) and are not just fruit and juice.',
    'text_ar': 'يمكن أن تكون العصائر المخفوقة وجبات إفطار مغذية إذا تضمنت البروتين (كالزبادي أو زبدة المكسرات) ولم تقتصر على الفاكهة والعصير فقط.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Skipping breakfast is associated with higher cortisol levels and increased stress responses throughout the morning.',
    'text_ar': 'يرتبط تخطي وجبة الإفطار بارتفاع مستويات الكورتيزول وزيادة استجابات التوتر طوال فترة الصباح.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Eggs at breakfast provide high-quality protein and have been shown to increase fullness compared to cereal-based breakfasts.',
    'text_ar': 'يوفر البيض في الإفطار بروتينًا عالي الجودة وقد ثبت أنه يزيد الشعور بالامتلاء مقارنة بوجبات الإفطار القائمة على الحبوب.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Preparing breakfast ingredients the night before removes barriers and makes healthy morning eating easier.',
    'text_ar': 'يزيل تحضير مكونات الإفطار في الليلة السابقة العوائق ويجعل تناول إفطار صحي في الصباح أسهل.',
    'source': 'NHS',
  },
  {
    'text': 'Porridge made with milk and topped with fruit and nuts is one of the most balanced and filling breakfast options.',
    'text_ar': 'تُعدّ العصيدة المحضرة بالحليب والمغطاة بالفاكهة والمكسرات من أكثر خيارات الإفطار توازنًا وإشباعًا.',
    'source': 'NHS',
  },
  {
    'text': 'Breakfast pastries (croissants, muffins, danish) are often high in sugar and saturated fat despite seeming light.',
    'text_ar': 'غالبًا ما تحتوي معجنات الإفطار (كالكرواسون والمافن والدانيش) على نسبة عالية من السكر والدهون المشبعة رغم مظهرها الخفيف.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Greek yogurt parfaits layered with granola and fruit provide protein, probiotics, and complex carbs.',
    'text_ar': 'يوفر بارفيه الزبادي اليوناني مع طبقات الغرانولا والفاكهة البروتين والبروبيوتيك والكربوهيدرات المعقدة.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'If you are not hungry first thing in the morning, a small breakfast 1–2 hours after waking still provides benefits.',
    'text_ar': 'إذا لم تشعر بالجوع فور الاستيقاظ، فإن تناول إفطار صغير بعد ساعة إلى ساعتين من الاستيقاظ لا يزال يقدم فوائد.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Adding ground flaxseed or chia seeds to breakfast boosts fiber and omega-3 intake with minimal effort.',
    'text_ar': 'تعزز إضافة بذور الكتان المطحونة أو بذور الشيا إلى الإفطار تناول الألياف وأوميغا-3 بأقل جهد.',
    'source': 'Harvard Health',
  },

  // ── Common Myths & Misconceptions (486–500) ──────────────────────────
  {
    'text': 'Eating fat does not necessarily make you fat; excess calories from any source cause weight gain.',
    'text_ar': 'تناول الدهون لا يعني بالضرورة زيادة الوزن؛ فالسعرات الحرارية الزائدة من أي مصدر هي التي تسبب زيادة الوزن.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Detox diets and juice cleanses have no scientific evidence supporting their claims; your liver and kidneys already detoxify.',
    'text_ar': 'لا يوجد دليل علمي يدعم حميات التخلص من السموم وتطهير الجسم بالعصائر؛ فالكبد والكليتان يقومان بالفعل بتنقية الجسم.',
    'source': 'NHS',
  },
  {
    'text': 'Eating after 8 PM does not inherently cause weight gain; total daily calorie intake matters more than timing.',
    'text_ar': 'لا يتسبب تناول الطعام بعد الساعة الثامنة مساءً بالضرورة في زيادة الوزن؛ إجمالي السعرات الحرارية اليومية أهم من توقيت الأكل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Carbohydrates are not the enemy; whole grains, fruits, and vegetables are carbohydrate-rich and essential for health.',
    'text_ar': 'الكربوهيدرات ليست العدو؛ فالحبوب الكاملة والفواكه والخضروات غنية بالكربوهيدرات وضرورية للصحة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Fresh vegetables are not always more nutritious than frozen; frozen produce is often picked and frozen at peak ripeness.',
    'text_ar': 'الخضروات الطازجة ليست دائمًا أكثر قيمة غذائية من المجمدة؛ فالمنتجات المجمدة غالبًا ما تُقطف وتُجمّد في ذروة نضجها.',
    'source': 'Harvard Health',
  },
  {
    'text': '"Superfoods" is a marketing term; no single food provides all the nutrients you need.',
    'text_ar': '"الأطعمة الخارقة" مصطلح تسويقي؛ لا يوجد طعام واحد يوفر جميع العناصر الغذائية التي تحتاجها.',
    'source': 'NHS',
  },
  {
    'text': 'Eggs do not significantly raise blood cholesterol for most people; dietary cholesterol has less impact than once thought.',
    'text_ar': 'لا يرفع البيض مستوى الكوليسترول في الدم بشكل كبير لدى معظم الناس؛ فتأثير الكوليسترول الغذائي أقل مما كان يُعتقد سابقًا.',
    'source': 'Harvard Health',
  },
  {
    'text': 'You do not need to drink exactly 8 glasses of water per day; needs vary by individual, climate, and activity level.',
    'text_ar': 'لا تحتاج لشرب 8 أكواب من الماء يوميًا بالضبط؛ فالاحتياجات تختلف حسب الفرد والمناخ ومستوى النشاط.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Gluten is only harmful to people with coeliac disease or non-coeliac gluten sensitivity; it is safe for everyone else.',
    'text_ar': 'الغلوتين ضار فقط للأشخاص المصابين بمرض السيلياك أو حساسية الغلوتين غير السيلياكية؛ وهو آمن لجميع الآخرين.',
    'source': 'Mayo Clinic',
  },
  {
    'text': 'Microwaving food does not destroy nutrients more than other cooking methods; it may actually preserve them better.',
    'text_ar': 'لا يدمر الميكروويف العناصر الغذائية أكثر من طرق الطهي الأخرى؛ بل قد يحافظ عليها بشكل أفضل.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Sea salt and Himalayan pink salt contain similar amounts of sodium as table salt; they are not healthier alternatives.',
    'text_ar': 'يحتوي ملح البحر وملح الهيمالايا الوردي على كميات مماثلة من الصوديوم مقارنة بملح الطعام؛ وليسا بدائل أكثر صحة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Snacking is not inherently bad; what matters is the quality and quantity of what you snack on.',
    'text_ar': 'تناول الوجبات الخفيفة ليس سيئًا بطبيعته؛ المهم هو جودة وكمية ما تتناوله من وجبات خفيفة.',
    'source': 'Harvard Health',
  },
  {
    'text': 'Supplements cannot replace a healthy diet; nutrients from whole foods are better absorbed and more beneficial.',
    'text_ar': 'لا يمكن للمكملات الغذائية أن تحل محل النظام الغذائي الصحي؛ فالعناصر الغذائية من الأطعمة الكاملة تُمتص بشكل أفضل وأكثر فائدة.',
    'source': 'NHS',
  },
  {
    'text': 'Brown sugar is not healthier than white sugar; the nutritional difference is negligible.',
    'text_ar': 'السكر البني ليس أكثر صحة من السكر الأبيض؛ فالفرق الغذائي بينهما ضئيل للغاية.',
    'source': 'Harvard Health',
  },
  {
    'text': 'You cannot "spot reduce" fat through diet or exercise; fat loss happens systemically across the whole body.',
    'text_ar': 'لا يمكنك استهداف منطقة معينة لإنقاص الدهون منها عبر الحمية أو التمرين؛ فخسارة الدهون تحدث بشكل شامل في جميع أنحاء الجسم.',
    'source': 'Mayo Clinic',
  },
];
