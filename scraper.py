import json
import os
import re
from playwright.sync_api import sync_playwright
from datetime import datetime

# TARGETS: Top Educational Resources for India Tax
# We target specific pages that contain "Tables" (Slabs, Sections, Rates)
URLS = [
    {"url": "https://cleartax.in/s/income-tax-slabs", "category": "tax_slabs"},
    {"url": "https://cleartax.in/s/80c-80-deductions", "category": "deductions_80c"},
    {"url": "https://taxguru.in/income-tax/new-income-tax-act-2025-highlights-pdf-slab-rates-provisions.html", "category": "taxguru_updates"}
]

def scrape_education_data():
    data_collection = []
    
    with sync_playwright() as p:
        # Launch Chrome (Headless)
        browser = p.chromium.launch(headless=True)
        
        for target in URLS:
            print(f"Scraping Educational Source: {target['url']}")
            page = browser.new_page()
            
            try:
                page.goto(target['url'], timeout=60000)
                
                # 1. Extract Page Title (The Topic)
                title = page.title()
                
                # 2. Extract ALL Tables (Structured Data)
                # Educational sites use <table> for Slabs and Rules. We grab them all.
                tables_data = []
                tables = page.locator("table").all()
                
                for i, table in enumerate(tables):
                    # Get headers
                    headers = table.locator("th").all_inner_texts()
                    # Get rows
                    rows = []
                    tr_elements = table.locator("tr").all()
                    for tr in tr_elements:
                        cells = tr.locator("td").all_inner_texts()
                        if cells:
                            rows.append(cells)
                    
                    if rows:
                        tables_data.append({
                            "table_index": i,
                            "headers": headers,
                            "rows": rows
                        })

                # 3. Extract Main Content (Textbook Definitions)
                # We grab the first 500 characters of paragraphs to get definitions
                content_snippets = page.locator("p").all_inner_texts()[:5]

                entry = {
                    "source": "Education_Site",
                    "category": target['category'],
                    "url": target['url'],
                    "scrape_date": str(datetime.now().date()),
                    "topic": title,
                    "structured_tables": tables_data, # <--- The Gold Mine
                    "summary_text": content_snippets
                }
                data_collection.append(entry)
                
            except Exception as e:
                print(f"Error scraping {target['url']}: {e}")
            
            page.close()
            
        browser.close()
        
    return data_collection

def save_database(data):
    # Ensure data folder exists
    os.makedirs("data", exist_ok=True)
    
    # Save as a Single "Master Knowledge" JSON
    filename = f"data/india_tax_knowledge_{datetime.now().strftime('%Y%m%d')}.json"
    
    with open(filename, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    
    print(f"Saved Structured Knowledge to: {filename}")

if __name__ == "__main__":
    knowledge_base = scrape_education_data()
    save_database(knowledge_base)
