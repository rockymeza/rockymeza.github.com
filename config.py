from strange_case_jinja import StrangeCaseEnvironment
from extensions.markdown2_extension import Markdown2Extension, markdown2
from extensions.date_extension import date
from time import time
from datetime import datetime

ENVIRONMENT = StrangeCaseEnvironment(extensions=[Markdown2Extension])
ENVIRONMENT.filters['date'] = date
ENVIRONMENT.filters['markdown2'] = markdown2


CONFIG = {
        'date': datetime.date.today(),
        }
