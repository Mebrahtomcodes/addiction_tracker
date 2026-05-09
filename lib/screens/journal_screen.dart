import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_drawer.dart';
import '../models/journal_model.dart';
import '../services/storage_service.dart';
import 'add_journal_entry_screen.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final StorageService _storage = StorageService();
  List<JournalModel> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await _storage.loadJournalEntries();
    setState(() {
      _entries = entries..sort((a, b) => b.date.compareTo(a.date));
      _isLoading = false;
    });
  }

  Future<void> _addEntry() async {
    final result = await Navigator.push<JournalModel>(
      context,
      MaterialPageRoute(builder: (context) => const AddJournalEntryScreen()),
    );

    if (result != null) {
      setState(() {
        _entries.insert(0, result);
      });
      await _storage.saveJournalEntries(_entries);
    }
  }

  void _deleteEntry(String id) async {
    setState(() {
      _entries.removeWhere((entry) => entry.id == id);
    });
    await _storage.saveJournalEntries(_entries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JOURNAL"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
          : _entries.isEmpty
              ? _buildEmptyState()
              : _buildEntryList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _addEntry,
        child: const Icon(Icons.add, color: AppTheme.backgroundBlack),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note_rounded,
            size: 80,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            "No reflections yet",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Start tracking your journey by adding your first reflection.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntryList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _entries.length,
      itemBuilder: (context, index) {
        final entry = _entries[index];
        return _buildEntryCard(entry);
      },
    );
  }

  Widget _buildEntryCard(JournalModel entry) {
    final dateStr = "${entry.date.day}/${entry.date.month}/${entry.date.year}";
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (entry.mood != null) ...[
                      Text(entry.mood!, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      dateStr,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => _deleteEntry(entry.id),
                  icon: const Icon(Icons.delete_outline_rounded, size: 20, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              entry.content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            if (entry.tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: entry.tags.map((tag) => Text(
                  tag,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
