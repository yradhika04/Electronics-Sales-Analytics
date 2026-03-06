# One-time script to convert original customer source CSV file encoding from Windows-1252 to UTF-8
# This was done before uploading the file to Google Sheets (as an Airbyte source)
# because the original customer source file had special characters (ä, ö, ü, etc.) that weren't handled properly

# source_data directory is not tracked in git as it contains raw data files
# So to run this script, place original CSV files in a local source_data directory

import chardet
import os
import pandas as pd


rootdir = './source_data'

for subdir, dirs, files in os.walk(rootdir):
    for file in files:
        file_path = os.path.join(subdir, file)

        with open(file_path, 'rb') as f:
            encoding_data = f.read()
            result = chardet.detect(encoding_data)

            if result['encoding'] == 'Windows-1252':
                df = pd.read_csv(file_path, encoding='windows-1252')
                new_file_name = os.path.splitext(file)[0] + '_fixed_encoding.csv'
                new_file_path = os.path.join(subdir, new_file_name)
                df.to_csv(new_file_path, encoding='utf-8-sig', index=False)