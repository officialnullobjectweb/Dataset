import requests
import json
import os
from datetime import datetime

# 1. Setup: Define the Target
# SEC EDGAR requires a User-Agent in this specific format: "Name email@domain.com"
HEADERS = {
    "User-Agent": "OpenSourceBot myemail@example.com",
    "Accept-Encoding": "gzip, deflate"
}

def fetch_sec_filings():
    # SEC feed for latest company filings (JSON format)
    url = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcurrent&type=10-K&count=20&output=atom"
    
    try:
        response = requests.get(url, headers=HEADERS, timeout=10)
        if response.status_code == 200:
            # In a real scenario, we would parse the XML/Atom feed here.
            # For this demo, we save the raw feed to prove it works.
            data = response.text
            return data
        else:
            print(f"Error: {response.status_code}")
            return None
    except Exception as e:
        print(f"Failed: {e}")
        return None

def save_data(data):
    # Create 'data' folder if it doesn't exist
    if not os.path.exists("data"):
        os.makedirs("data")
        
    # Generate filename with today's date (e.g., 2024-10-25-filings.xml)
    filename = f"data/{datetime.now().strftime('%Y-%m-%d')}-filings.xml"
    
    with open(filename, "w", encoding="utf-8") as f:
        f.write(data)
    print(f"Saved: {filename}")

if __name__ == "__main__":
    print("Starting Scraping Job...")
    content = fetch_sec_filings()
    if content:
        save_data(content)
