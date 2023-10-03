#!/bin/sh

if [ -z "$sphinx_port" ]; then
  sp_port=8000
else
  sp_port=$sphinx_port
fi
echo ${sp_port}"port process kill."
lsof -i :$sp_port | grep -c $sp_port && kill -9 `lsof -i :$sp_port|grep $sp_port|awk '{print $2}'`

echo "start sphinx_autobuild."
python -msphinx_autobuild /workspace/src /workspace/docs --port=$sp_port