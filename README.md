### Using ARA with ABPs


See [Deploy an OpenShift Origin Cluster with the Ansible Service Broker](https://github.com/openshift/ansible-service-broker#deploy-an-openshift-origin-cluster-with-the-ansible-service-broker) for running OpenShift and the Service Broker


#### Starting ARA and PostgreSQL

This is a very basic defaulted install of PostgreSQL.  It is assumed that it will be used and thrown away after
debugging is complete.

```
oc login -u developer -p developer --insecure-skip-tls-verify https://172.31.51.52.nip.io:8443
oc new-project ara
oc create -f openshift-template.yaml
oc new-app --template ara
```

If you don't have a `Dockerfile-canary` create one and append.

```
cat append-canary-dockerfile > Dockerfile-canary
apb prepare -f Dockerfile-canary ; apb build --tag mariadb-apb -f Dockerfile-canary ; apb push -f Dockerfile-canary
```

