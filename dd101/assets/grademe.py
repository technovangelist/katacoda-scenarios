import requests
import pprint
import os
pp = pprint.PrettyPrinter()
resp = requests.post(os.environ['LTIURL'])


pp.pprint(resp.json())