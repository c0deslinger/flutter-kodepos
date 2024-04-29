import pandas as pd

# Baca file CSV
df = pd.read_csv('subdistrict.csv', delimiter=',')  # Sesuaikan nama_file.csv dengan nama file Anda

# Loop melalui nilai unik pada kolom dis_id
for dis_id in df['dis_id'].unique():
    # Filter dataframe berdasarkan nilai dis_id
    sub_df = df[df['dis_id'] == dis_id]
    
    # Simpan dataframe ke file CSV
    sub_df.to_csv(f'subdis_{dis_id}.csv', sep=',', index=False)

