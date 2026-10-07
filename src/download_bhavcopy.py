import pandas as pd
import requests

session = requests.Session()
session.headers["User-Agent"] = "Mozilla/5.0"

base_url = "https://nsearchives.nseindia.com/products/content/sec_bhavdata_full_"

for month in range(4, 10):
    for day in range(1, 32):

        if len(str(day)) == 1:
            date = f"0{day}0{month}2026"
        else:
            date = f"{day}0{month}2026"

        response = session.get(f"{base_url}{date}.csv", timeout=10)

        if response.status_code == 200:
            with open(f"data/raw/bhavcopy/sec_bhavdata_full_{date}.csv", "wb") as file:
                file.write(response.content)

            print(f"Downloaded: {date}")
