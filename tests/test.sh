#!/bin/bash

set -x

export ara_location=$(python -c "import os,ara; print(os.path.dirname(ara.__file__))")
export ANSIBLE_CALLBACK_PLUGINS=$ara_location/plugins/callbacks
export ANSIBLE_ACTION_PLUGINS=$ara_location/plugins/actions
export ANSIBLE_LIBRARY=$ara_location/plugins/modules

export ARA_HOST=ara-ara.ait-ose.e2e.bos.redhat.com
export ARA_PORT=80



ansible-playbook site.yml
