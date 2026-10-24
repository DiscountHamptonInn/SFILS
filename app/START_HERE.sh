#!/bin/bash

python3 -m venv venv
source venv/bin/activate
pip3 install mysql-connector-python
python3 frontend.py