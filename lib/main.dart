import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================
// Задание 2: MyApp переведён на StatefulWidget для переключения темы
// ============================================================
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мой профиль',
      debugShowCheckedModeBanner: false,
      // Задание 1: изменена цветовая тема на deepPurple
      // Задание 2: переключение светлой/тёмной темы
      theme: _isDark
          ? ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
            )
          : ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
              ),
            ),
      // Задание 3: MainScreen с BottomNavigationBar
      home: MainScreen(
        onToggleTheme: () {
          setState(() {
            _isDark = !_isDark;
          });
        },
        isDark: _isDark,
      ),
    );
  }
}

// ============================================================
// Задание 3: MainScreen с тремя вкладками
// ============================================================
class MainScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDark;

  const MainScreen({super.key, this.onToggleTheme, this.isDark = false});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      ProfileScreen(
        onToggleTheme: widget.onToggleTheme,
        isDark: widget.isDark,
      ),
      const GalleryScreen(),
      const ContactsScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Галерея',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Контакты',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Экран профиля (StatefulWidget для кнопки «Нравится»)
// Задание 1: персонализированный профиль
// Задание 2: кнопка переключения темы в AppBar
// ============================================================
class ProfileScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final bool isDark;

  const ProfileScreen({super.key, this.onToggleTheme, this.isDark = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _likes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          // Задание 2: кнопка переключения темы
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            tooltip: 'Переключить тему',
          ),
          // Навигация на экран «О приложении»
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Аватар
              // Задание 1: персонализированные данные
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.deepPurple,
                child: Text(
                  'ОД',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Имя
              const Text(
                'Олег Довильт',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              // Статус
              Text(
                'Flutter-разработчик',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // --- Информационные карточки ---
              Card(
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.deepPurple),
                      title: Text('Email'),
                      subtitle: Text('oleg@example.com'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.green),
                      title: Text('Телефон'),
                      subtitle: Text('+7 (999) 123-45-67'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.red),
                      title: Text('Город'),
                      subtitle: Text('Новосибирск'),
                    ),
                  ],
                ),
              ),

              // Задание 1: дополнительная карточка
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.school, color: Colors.orange),
                      title: Text('Университет'),
                      subtitle: Text('НГТУ'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.code, color: Colors.blueGrey),
                      title: Text('GitHub'),
                      subtitle: Text('github.com/Dowilt'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // --- Заголовок секции ---
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Интересы',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // --- Теги ---
              // Задание 1: персонализированные интересы
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  Chip(
                    avatar: Icon(Icons.code, size: 18),
                    label: Text('Flutter'),
                  ),
                  Chip(
                    avatar: Icon(Icons.phone_android, size: 18),
                    label: Text('Mobile Dev'),
                  ),
                  Chip(
                    avatar: Icon(Icons.cloud, size: 18),
                    label: Text('Cloud'),
                  ),
                  Chip(
                    avatar: Icon(Icons.sports_esports, size: 18),
                    label: Text('GameDev'),
                  ),
                  Chip(
                    avatar: Icon(Icons.music_note, size: 18),
                    label: Text('Музыка'),
                  ),
                  Chip(
                    avatar: Icon(Icons.computer, size: 18),
                    label: Text('Backend'),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // --- Кнопки ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _likes++;
                      });
                    },
                    icon: const Icon(Icons.favorite),
                    label: Text('Нравится ($_likes)'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Сообщение отправлено!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Написать'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Задание 3: Экран «Галерея» с GridView.count
// ============================================================
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://picsum.photos/seed/a1/300/300',
      'https://picsum.photos/seed/b2/300/300',
      'https://picsum.photos/seed/c3/300/300',
      'https://picsum.photos/seed/d4/300/300',
      'https://picsum.photos/seed/e5/300/300',
      'https://picsum.photos/seed/f6/300/300',
      'https://picsum.photos/seed/g7/300/300',
      'https://picsum.photos/seed/h8/300/300',
      'https://picsum.photos/seed/i9/300/300',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Галерея'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: imageUrls.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ============================================================
// Задание 3: Экран «Контакты» с ListView.builder
// ============================================================
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> contacts = [
      {'name': 'Алексей Петров', 'phone': '+7 (900) 111-22-33', 'email': 'alex@example.com'},
      {'name': 'Мария Сидорова', 'phone': '+7 (900) 222-33-44', 'email': 'maria@example.com'},
      {'name': 'Дмитрий Козлов', 'phone': '+7 (900) 333-44-55', 'email': 'dmitry@example.com'},
      {'name': 'Анна Волкова', 'phone': '+7 (900) 444-55-66', 'email': 'anna@example.com'},
      {'name': 'Сергей Новиков', 'phone': '+7 (900) 555-66-77', 'email': 'sergey@example.com'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Контакты'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  contact['name']![0],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(contact['name']!),
              subtitle: Text(contact['phone']!),
              trailing: IconButton(
                icon: const Icon(Icons.email_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Письмо для ${contact['email']}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// Экран «О приложении»
// ============================================================
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О приложении'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Версия 1.0.0',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Это учебное приложение, созданное '
              'в рамках лабораторной работы '
              'по Flutter.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Использованные виджеты:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...[
              'Scaffold & AppBar',
              'Column & Row',
              'Card & ListTile',
              'CircleAvatar',
              'Chip & Wrap',
              'ElevatedButton',
              'SnackBar',
              'Navigator',
              'BottomNavigationBar',
              'GridView.count',
              'ListView.builder',
            ].map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          size: 18, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(item, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
