from .config.middleware import make_app

import logging
log = logging.getLogger(__name__)

app = make_app({}, full_stack=False)
