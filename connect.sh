#!/bin/bash

#Establishes connection with raspberry pi & execute masterscript remotely
sshpass -p 'password' ssh -o StrictHostKeyChecking=no pi@172.23.184.79 "sh ~/bin/masterscript.sh $1 $2 $3 $4 $5"
