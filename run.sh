#!/bin/bash

oc new-project ara
oc create -f https://raw.githubusercontent.com/jcpowermac/apb-with-ara/master/openshift-template.yaml
oc new-app --template ara
