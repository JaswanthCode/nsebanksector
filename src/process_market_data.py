import pandas as pd

symbols = pd.read_csv("config/bank_stocks.csv")["symbol"].tolist()
all_data = []

for month in range(4,10):
    for day in range(1,31):
        if len(str(day)) == 1:
            date=f"0{day}0{month}2026"
        else:
            date=f"{day}0{month}2026"
            
        try:
            data = pd.read_csv(f"data/raw/bhavcopy/sec_bhavdata_full_{date}.csv")
        except FileNotFoundError:
            continue

        data.columns = data.columns.str.strip()
        data["SYMBOL"] = data["SYMBOL"].astype(str).str.strip()
        data["SERIES"] = data["SERIES"].astype(str).str.strip()

        data = data[(data["SERIES"] == "EQ") & (data["SYMBOL"].isin(symbols))]
        all_data.append(data)

market_data = pd.concat(all_data, ignore_index=True)
market_data.to_csv("data/processed/market_data.csv", index=False)

print(f"Market data created: {len(market_data)} rows")
