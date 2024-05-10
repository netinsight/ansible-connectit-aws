#!/bin/bash

while read -r instance host; do
  if [ -z "$host" ]; then
    echo >&2 "instance $instance does not have a public DNS"
    continue
  else
    echo >&2 "$instance: Trying to extract SSH keys from console output"
  fi
  while read -r type fingerprint _internal_host; do
    echo "$host $type $fingerprint"
  done < <(aws ec2 get-console-output --instance-id "$instance" --region eu-north-1 --output json | jq --raw-output .Output | sed -n -e '1,/-----BEGIN SSH HOST KEY KEYS-----/d; /-----END SSH HOST KEY KEYS-----/q; p')
done < <(aws ec2 describe-instances --region eu-north-1 --filters Name=tag:application,Values=connectit Name=instance-state-name,Values=running --output text --query 'Reservations[].Instances[].[InstanceId,PublicDnsName]') | tee known_hosts
