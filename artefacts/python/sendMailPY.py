import requests
import json

def main (args):
   if len(args) == 0:
      to_ = 'ernese@sg.ibm.com'
   else:
      to_ = args.get('emailId')

   from_ = 'ernese@sg.ibm.com'
   headers = {
       'Content-Type': 'application/json',
       'Authorization': 'Bearer <SendGrid\'s key>',
   }
   payload = {
       "personalizations": [{"to": [{"email": to_}]}],
       "from": {"email": from_},
       "subject": "Inserted into a Cloudant DB",
       "content": [{"type": "text/plain", "value": "This is from a OpenWhisk Python Action triggered by an insert to a Cloudant DB"}]
   }
   url = 'https://api.sendgrid.com/v3/mail/send'
   response = requests.post(url, headers=headers, data=json.dumps(payload))
   # response.raise_for_status()
   print (response)
   return {'result': 'Email Sent'}
   
