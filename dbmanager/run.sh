#!/bin/bash

cd /opt/dbmanager

max=$(ls versions | awk -v max=0 '{if($1>max){want=$2; max=$1}}END{print want} ')
