import json
import boto3
import os

def lambda_handler(event, context):
    # Handle CORS preflight requests
    if event['httpMethod'] == 'OPTIONS':
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': os.environ.get('WEBSITE_URL', '*'),
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST, OPTIONS'
            },
            'body': ''
        }
    
    sns = boto3.client('sns')
    
    try:
        # Parse the form data
        body = json.loads(event['body'])
        name = body.get('name', '')
        email = body.get('email', '')
        subject = body.get('subject', '')
        message = body.get('message', '')
        
        # Create the email message
        email_subject = f"Contact Form: {subject}"
        email_message = f"""
New contact form submission:

Name: {name}
Email: {email}
Subject: {subject}

Message:
{message}
        """
        
        # Send to SNS
        sns.publish(
            TopicArn=os.environ['SNS_TOPIC_ARN'],
            Subject=email_subject,
            Message=email_message
        )
        
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': os.environ.get('WEBSITE_URL', '*'),
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST'
            },
            'body': json.dumps({'message': 'Success'})
        }
        
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': os.environ.get('WEBSITE_URL', '*'),
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST'
            },
            'body': json.dumps({'error': str(e)})
        }