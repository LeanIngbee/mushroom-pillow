import io, json, pandas, boto3, urllib.parse

input_to_target_path_configs = {
    'data/raw/sales_csv/syncros_raw_csvs/3.Licencias y Sincronizaciones Consolidado.csv': 'data/raw/sales_csv/syncros/3.Licencias y Sincronizaciones Consolidado.csv'
}

def lambda_handler(event, context):
    print(f'Started sanitize_csv_file Lambda Function. Event object received {json.dumps(event, indent=2)}')
    
    s3_bucket = event['Records'][0]['s3']['bucket']['name']
    csv_s3_key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    
    print(f'File S3 Key received {csv_s3_key}')
    
    if csv_s3_key in input_to_target_path_configs:
        bytes_buffer = io.BytesIO()

        print(f'Downloading s3://{s3_bucket}/{csv_s3_key}')
        boto3.client('s3').download_fileobj(Bucket=s3_bucket, Key=csv_s3_key, Fileobj=bytes_buffer)
        
        target_path = input_to_target_path_configs[csv_s3_key]
        
        bytes_buffer.seek(0)
        
        df = pandas.read_csv(bytes_buffer, sep=';').replace(r'\n',' ', regex=True)
        df_str = df.to_csv(header=True, index=False, sep=';', line_terminator='\n')
        
        print(f'Saving sanitized CSV into s3://{s3_bucket}/{target_path}')
        boto3.client('s3').put_object(Bucket=s3_bucket, Key=target_path, Body=df_str.encode('utf-8'))
        
    else:
        print(f'No target_path config for input key {csv_s3_key}')
