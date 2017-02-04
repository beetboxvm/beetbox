#!/bin/bash

# Start supervisor
supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
