In ../app/frontend.py:
    There are multiple repeat operations when validating input for integers. These need to be condensed into a function.
    The script currently validates for data type, but not foreign keys. The error is in MySQL, so it cannot be avoided with try:
    Can currently only input into the MAIN table.
