#!/usr/bin/env bash

# decrypt enc file to tar.
openssl des-cbc -d -k $MOPCON_DES_KEY -in secrets.tar.enc -out secrets.tar

# extract tar file.
tar xvf ./secrets.tar