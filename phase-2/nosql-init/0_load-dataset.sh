#!/bin/sh

mongoimport --type csv -d soen-363 -c case_ids --headerline --drop case_ids.csv
mongoimport --type csv -d soen-363 -c collisions --headerline --drop collisions.csv
mongoimport --type csv -d soen-363 -c parties --headerline --drop parties.csv
mongoimport --type csv -d soen-363 -c victims --headerline --drop victims.csv
