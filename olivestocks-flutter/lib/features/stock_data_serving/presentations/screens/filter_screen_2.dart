import 'package:flutter/material.dart';

class FilterItem {
  final String label;
  final String? iconPath;
  final bool isPro;
  final bool isUltimate;

  FilterItem({
    required this.label,
    this.iconPath,
    this.isPro = false,
    this.isUltimate = false,

  });
}

class FilterScreen2 extends StatefulWidget {
  const FilterScreen2({super.key});

  @override
  State<FilterScreen2> createState() => _FilterScreen2State();
}

class _FilterScreen2State extends State<FilterScreen2> {
  // Track selected states for each category
  final Map<String, Set<String>> _selectedFilters = {
    'Market': {},
    'Smart Score': {},
    'Market Cap': {},
    'Sector': {},
    'Dividend Yield': {},
    'Analyst Consensus': {},
    'Top Analyst Consensus': {},
    'Blogger Consensus': {},
    'Insider Signal': {},
    'Hedge Fund Signal': {},
    'News Sentiment': {},
  };

  // Country flag SVGs (replace with your actual assets)
  final Map<String, String> countryFlags = {
    'US': 'assets/flags/us.png',
    'Canada': 'assets/flags/canada.png',
    'UK': 'assets/flags/uk.png',
    'Israel': 'assets/flags/israel.png',
    'India': 'assets/flags/india.png',
    'Italy': 'assets/flags/italy.png',
  };

  void _toggleFilter(String category, String value) {
    setState(() {
      if (_selectedFilters[category]!.contains(value)) {
        _selectedFilters[category]!.remove(value);
      } else {
        _selectedFilters[category]!.add(value);
      }
    });
  }

  void _selectAllItems(String category, List<FilterItem> items) {
    setState(() {
      // If all items are already selected, clear them
      if (_selectedFilters[category]!.length == items.length) {
        _selectedFilters[category]!.clear();
      }
      // Otherwise, select all items
      else {
        _selectedFilters[category]!.clear();
        for (var item in items) {
          _selectedFilters[category]!.add(item.label);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMarketFilterSection(
              'Market',
              [
                FilterItem(label: 'US', iconPath: countryFlags['US']),
                FilterItem(label: 'Canada', iconPath: countryFlags['Canada']),
                FilterItem(label: 'UK', iconPath: countryFlags['UK']),
                FilterItem(label: 'Israel', iconPath: countryFlags['Israel']),
                FilterItem(label: 'India', iconPath: countryFlags['India']),
                FilterItem(label: 'Italy', iconPath: countryFlags['Italy']),
              ],
            ),
            const SizedBox(height: 16),
            _buildSmartFilterSection(
              'Smart Score',
              [
                FilterItem(label: '10 (Outperform)', isPro: true),
                FilterItem(label: '8-9 (Outperform)'),
                FilterItem(label: '4-7 (Neutral)'),
                FilterItem(label: '2-3 (Underperform)'),
                FilterItem(label: '1 (Underperform)'),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectorFilterSection(
              'Sector',
              [
                FilterItem(label: '> \$10B', isPro: true),
                FilterItem(label: '\$5B - \$10B'),
                FilterItem(label: '\$1B - \$5B'),
                FilterItem(label: '\$500M - \$1B'),
                FilterItem(label: '< \$500M'),
              ],
            ),
            const SizedBox(height: 16),
            _buildMarketCapFilterSection(
              'Market Cap',
              [
                FilterItem(label: '> \$10B', isPro: true),
                FilterItem(label: '\$5B - \$10B'),
                FilterItem(label: '\$1B - \$5B'),
                FilterItem(label: '\$500M - \$1B'),
                FilterItem(label: '< \$500M'),
              ],
            ),
            const SizedBox(height: 16),
            _buildDividendFilterSection(
              'Dividend Yield',
              [
                FilterItem(label: 'Upside > 20%', isPro: true),
                FilterItem(label: 'Upside > 15%'),
                FilterItem(label: 'Upside > 10%'),
                FilterItem(label: 'Upside > 5%'),
                FilterItem(label: 'Any Upside'),
              ],
            ),
            const SizedBox(height: 16),
            _buildAnalystFilterSection(
              'Analyst Consensus',
              [
                FilterItem(label: '< 0.1%'),
                FilterItem(label: '0.1% - 0.5%'),
                FilterItem(label: '0.5% - 1%'),
                FilterItem(label: '1% - 2%'),
                FilterItem(label: '> 2%'),
              ],
            ),
            const SizedBox(height: 16),
            _buildTopAnalystFilterSection(
              'Top Analyst Consensus',
              [
                FilterItem(label: '< 0.1%',isUltimate: true),
                FilterItem(label: '0.1% - 0.5%'),
                FilterItem(label: '0.5% - 1%'),
                FilterItem(label: '1% - 2%'),
                FilterItem(label: '> 2%'),
              ],
            ),
            const SizedBox(height: 16),
          _buildBloggerFilterSection(
              'Blogger Consensus',
              [
                FilterItem(label: 'Equity'),
                FilterItem(label: 'Fixed Income'),
                FilterItem(label: 'Commodities'),
                FilterItem(label: 'Real Estate'),
                FilterItem(label: 'Alternative'),
              ],
            ),
            const SizedBox(height: 16),
           _buildInsiderFilterSection(
              'Insider Signal',
              [
                FilterItem(label: '> 5%'),
                FilterItem(label: '3% - 5%'),
                FilterItem(label: '1% - 3%'),
                FilterItem(label: '0% - 1%'),
                FilterItem(label: 'None'),
              ],
            ),
            _buildHedgeFilterSection(
              'Hedge Fund Signal',
              [
                FilterItem(label: '> 5%'),
                FilterItem(label: '3% - 5%'),
                FilterItem(label: '1% - 3%'),
                FilterItem(label: '0% - 1%'),
                FilterItem(label: 'None'),
              ],
            ),
            const SizedBox(height: 16),
            _buildNewsFilterSection(
              'News Sentiment',
              [
                FilterItem(label: 'Technology'),
                FilterItem(label: 'Healthcare'),
                FilterItem(label: 'Financials'),
                FilterItem(label: 'Consumer'),
                FilterItem(label: 'Energy'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 4.0,
      shadowColor: Colors.black,
      title: Row(
        children: [
          const Text(
            'Filters',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/logos/filter Icon.png'),
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.keyboard_backspace, color: Colors.black),
      ),
    );
  }

  Widget _buildMarketFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildSmartFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
      showProInHeader: true,
    );
  }

  Widget _buildMarketCapFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildSectorFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildDividendFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildAnalystFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildTopAnalystFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildBloggerFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }
  Widget _buildInsiderFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
      showUltimateInHeader: true,
    );
  }
  Widget _buildHedgeFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }
  Widget _buildNewsFilterSection(String category, List<FilterItem> items) {
    return _buildGenericFilterSection(
      category: category,
      items: items,
      showInfoIcon: true,
    );
  }

  Widget _buildGenericFilterSection({
    required String category,
    required List<FilterItem> items,
    bool showInfoIcon = false,
    bool showProInHeader = false,
    bool showUltimateInHeader = false,
  }) {
    final allSelected = _selectedFilters[category]!.length == items.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff595959),
                    ),
                  ),
                  if (showInfoIcon) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.info_outline, size: 15),
                  ],
                  if (showProInHeader) ...[
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/flags/pro.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                  if (showUltimateInHeader) ...[
                    const SizedBox(width: 4),
                    Container(
                      color: Colors.red,
                      height:13,
                      width: 50,
                      child: Image.asset(
                        'assets/flags/ultimate.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            TextButton(
              onPressed: () => _selectAllItems(category, items),
              child: Text(
                allSelected ? 'CLEAR ALL' : 'SELECT ALL',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: items.map((item) {
            final isSelected = _selectedFilters[category]!.contains(item.label);

            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.iconPath != null) ...[
                    Image.asset(
                      item.iconPath!,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.green,
                      fontSize: 11,
                    ),
                  ),
                  if (item.isPro) ...[
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/flags/pro.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                  if (item.isUltimate) ...[
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/flags/ultimate.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
                ],
              ),
              selected: isSelected,
              onSelected: (selected) => _toggleFilter(category, item.label),
              selectedColor: Colors.green[600],
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(
                  color: Colors.green,
                  width: 1.0,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6.0,
              ),
              elevation: 0,
              pressElevation: 0,
            );
          }).toList(),
        ),
      ],
    );
  }
}