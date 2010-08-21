#!/usr/bin/env sh
cd `dirname $0`

erl -pa ./ebin -eval "application:start(homerl)" 
