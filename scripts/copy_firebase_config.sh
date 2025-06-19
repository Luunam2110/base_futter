#!/bin/bash

ENV=${1:-dev}

dart scripts/gen_firebase_config.dart --env="$ENV"