#!/bin/sh

PATH=/opt/datadog-agent/venv/bin:/opt/datadog-agent/bin:$PATH

exec /opt/datadog-agent/venv/bin/supervisord -c /opt/datadog-agent/agent/supervisor.conf
