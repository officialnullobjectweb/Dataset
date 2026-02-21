import json
import os
from playwright.sync_api import sync_playwright

# Ensure data directory exists
os.makedirs("data", exist_ok=True)

def run():
    with sync_playwright() as p:
        # Launch Headless Chrome
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        
        # Target: IRS or SEC (Example)
        # Note: Real SEC scraping requires headers to identify yourself (User-Agent)
        page.goto("https://www.irs.gov/newsroom") 
        
        # Extract Data (Example: Get latest news titles)
        results = []
        items = page.locator("div.field-content").all()
        
        for item in items[:10]: # Limit to top 10 to avoid timeouts
            text = item.inner_text()
            if text:
                results.append({"title": text.strip()})
        
        # Save Structured Data
        with open("data/latest_tax_news.json", "w") as f:
            json.dump(results, f, indent=2)
            
        browser.close()

if __name__ == "__main__":
    run()
