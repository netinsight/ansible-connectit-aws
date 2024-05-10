# 1. Install ansible

Ansible and its dependnecies can be installed with the default (`all`) make target:

```bash
make
```

Once it is installed activate the virtual environment

```bash
source .venv/bin/activate
```

# 2. Create config file

Copy the `example.config.yml` file to `config.yml` and replace all values.

```bash
cp example.config.yml config.yml
```

# 3. Provision all EC2 instances

```bash
ansible-playbook main.yaml --diff --limit localhost
```

# 4. Verify public keys

The script `./setup_known_hosts.sh` will extract the public keys from the instance serial console into a file called
`known_hosts`. It does however take a few minutes before the output is available. The output should look similar to the
following (shortened for brevity):

```
$ ./setup_known_hosts.sh
i-05f8a3105d0e6de28: Trying to extract SSH keys from console output
ec2-13-48-190-57.eu-north-1.compute.amazonaws.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKgiDgoYnG0jS/IoIqJqBEDL7SgWTalWmlUAGO3Kmz/TzZMDmtJnqDqXEyjYSWFuzy+0QG6/Qx5/iNPmZikvL1g=
...
i-013c16ce7ad79edda: Trying to extract SSH keys from console output
ec2-13-60-71-49.eu-north-1.compute.amazonaws.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMJwtvOCkS+LKGc0vAU1wFMRmVqycwgWyi2+r2Oha0H68bSP7Dnhb+inTKQI+zI6iQMw8piAPuJjbAADSBzi3+E=
...
i-0a4ca2a65eb60dfcb: Trying to extract SSH keys from console output
ec2-51-20-116-145.eu-north-1.compute.amazonaws.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDWSdqjRY1B9NxQlJyKisTCqIAMyHjPE80lXmGFwW5BF6ecOUFYJMidLIIfSiqWcydvzMmrim7m4z8L8e9q3Xt0=
...
```

# 5. Install Connect iT core

```bash
ansible-playbook main.yaml --diff --limit role_core --inventory inventory/aws_ec2.yml
```

Once the playbook is complete it might take a little bit until the HTTPS certificates are provisioned.

# 6. Install Connect iT video and thumb appliances

```bash
ansible-playbook main.yaml --diff --limit role_thumb,role_video --inventory inventory/aws_ec2.yml
```
