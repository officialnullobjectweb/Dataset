import json
import os
from playwright.sync_api import sync_playwright
from datetime import datetime

# --- 1. THE MEGA SOURCE LIST (Simulating "All Over") ---
# We target 3 different sectors to get a "holistic" view of tax data.
TARGETS = [
    # Education Sector (Textbook Data)
    {"url": "https://cleartax.in/s/income-tax-slabs", "category": "tax_slabs", "type": "table"},
    {"url": "https://taxguru.in/income-tax/income-tax-slab-rate-financial-year-2025-26.html", "category": "detailed_rates", "type": "text"},
    
    # Banking Sector (Investment Data)
    {"url": "https://www.hdfcbank.com/personal/resources/learning-centre/save/income-tax-slabs", "category": "bank_view", "type": "table"},
    {"url": "https://www.bankbazaar.com/tax/income-tax-slabs.html", "category": "market_view", "type": "table"},

    # Gov/News Sector (Official Updates)
    {"url": "https://economictimes.indiatimes.com/wealth/tax", "category": "news_updates", "type": "headlines"}
]

def clean_text(text):
    """Removes extra spaces and newlines"""
    if not text: return "N/A"
    return " ".join(text.split())

def structure_as_text(data_entry):
    """Converts a JSON entry into a Beautiful ASCII Text Report"""
    lines = []
    lines.append("=" * 60)
    lines.append(f"SOURCE: {data_entry['source']}")
    lines.append(f"DATE:   {data_entry['scraped_at']}")
    lines.append(f"TOPIC:  {data_entry['category'].upper()}")
    lines.append("=" * 60)
    lines.append("")

    # Format Tables if they exist
    for table in data_entry.get('tables', []):
        lines.append(f"--- TABLE DATA ---")
        # Print Headers
        headers = " | ".join([f"{h:<20}" for h in table.get('headers', [])])
        lines.append(headers)
        lines.append("-" * len(headers))
        
        # Print Rows
        for row in table.get('rows', []):
            # Ensure row has same length as headers to avoid errors
            row_text = " | ".join([f"{cell:<20}" for cell in row[:len(table['headers'])]])
            lines.append(row_text)
        lines.append("\n")

    # Format Summaries
    if data_entry.get('summary'):
        lines.append("--- KEY TAKEAWAYS ---")
        for point in data_entry['summary']:
            lines.append(f"* {point}")
    
    lines.append("\n" + ("#" * 60) + "\n")
    return "\n".join(lines)

def scrape_all():
    collected_data = []
    
    with sync_playwright() as p:
        # Launch with specific args to avoid detection
        browser = p.chromium.launch(headless=True, args=["--no-sandbox"])
        
        for site in TARGETS:
            print(f"Visiting: {site['url']}...")
            try:
                page = browser.new_page()
                # Set a real user agent so we don't look like a bot
                page.set_extra_http_headers({"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"})
                
                page.goto(site['url'], timeout=45000)
                
                # Strategy 1: Extract Tables
                extracted_tables = []
                if site['type'] == 'table':
                    for t in page.locator("table").all()[:3]: # Limit to top 3 tables
                        headers = t.locator("th").all_inner_texts()
                        rows = []
                        for tr in t.locator("tr").all():
                            cells = tr.locator("td").all_inner_texts()
                            if cells: rows.append([clean_text(c) for c in cells])
                        if headers and rows:
                            extracted_tables.append({"headers": headers, "rows": rows})

                # Strategy 2: Extract Text Summaries
                summary = page.locator("p").all_inner_texts()[:5] # Top 5 paragraphs
                summary = [clean_text(s) for s in summary if len(s) > 50]

                record = {
                    "source": site['url'],
                    "category": site['category'],
                    "scraped_at": str(datetime.now().date()),
                    "tables": extracted_tables,
                    "summary": summary
                }
                collected_data.append(record)
                page.close()
                
            except Exception as e:
                print(f"Failed {site['url']}: {e}")
        
        browser.close()
    return collected_data

def save_dual_format(data):
    os.makedirs("data", exist_ok=True)
    timestamp = datetime.now().strftime('%Y%m%d')

    # 1. Save as JSON (Machine Readable)
    json_path = f"data/tax_data_{timestamp}.json"
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    
    # 2. Save as TXT (Human Readable / Structured)
    txt_path = f"data/tax_data_{timestamp}.txt"
    with open(txt_path, "w", encoding="utf-8") as f:
        for entry in data:
            f.write(structure_as_text(entry))

    print(f"Success! Saved {json_path} and {txt_path}")

if __name__ == "__main__":
    data = scrape_all()
    save_dual_format(data)
