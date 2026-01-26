df_price = pd.read_csv("bitcoin_data.csv")
df_trends = pd.read_csv("google_trends_bitcoin.csv")
df_x = pd.read_csv("x_posts_bitcoin.csv")
df = df_price.merge(df_trends, on="Date", how="left").merge(df_x, on="Date", how="left")