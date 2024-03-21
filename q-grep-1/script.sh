#!/bin/bash

 grep -E '^#{1,6} ' -A2 | grep -v '^--$'
