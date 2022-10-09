import io, json, pandas, boto3, urllib.parse

worksheets_configs = {
    'data/raw/metadata/catalogue_excel_file/Metadata - Completa - VF.xlsx': [
        {
            'name': 'Audio Metadta',
            'target_path': 'data/raw/metadata/audio/Metadata - Completa - VF.csv'
        },
        {
            'name': 'Video Metadta',
            'target_path': 'data/raw/metadata/video/Metadata - Completa - VF.csv'
        },
        {
            'name': 'Referencias',
            'target_path': 'data/raw/metadata/operation_type/Metadata - Completa - VF.csv'
        }
    ],
    'data/raw/metadata/royalties_excel_file/Metadata - Completa - VF (con royalties).xlsx': [
        {
            'name': 'Audio Metadta',
            'target_path': 'data/raw/metadata/royalties_audio/Metadata - Completa - VF.csv'
        },
        {
            'name': 'Video Metadta',
            'target_path': 'data/raw/metadata/royalties_video/Metadata - Completa - VF.csv'
        },
        {
            'name': 'Mails y titulares',
            'target_path': 'data/raw/metadata/royalties_contacts/Metadata - Completa - VF.csv'
        }
    ]
}

def lambda_handler(event, context):
    s3_bucket = event['Records'][0]['s3']['bucket']['name']
    excel_s3_key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    
    print(f'Started parse_metadata_excel_file Lambda Function. Event object received {json.dumps(event, indent=2)}')
    bytes_buffer = io.BytesIO()

    print(f'Downloading s3://{s3_bucket}/{excel_s3_key}')
    boto3.client('s3').download_fileobj(Bucket=s3_bucket, Key=excel_s3_key, Fileobj=bytes_buffer)
    
    for worksheet_config in worksheets_configs.get(excel_s3_key, []):
        print(f'Reading {worksheet_config["name"]} sheet.')
        df = pandas.read_excel(bytes_buffer, engine='openpyxl', sheet_name=worksheet_config['name'])
        df = df.replace(r'\n',' ', regex=True) 
                               
        print(f'Saving sheet into {worksheet_config["target_path"]}')
        df_str = df.to_csv(header=True, index=False, sep=';', line_terminator='\n')
        boto3.client('s3').put_object(Bucket=s3_bucket, Key=worksheet_config['target_path'], Body=df_str.encode('utf-8'))
