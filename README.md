### Using [ARA](https://github.com/openstack/ara) with ABPs


Take a look at: [Deploy an OpenShift Origin Cluster with the Ansible Service Broker](https://github.com/openshift/ansible-service-broker#deploy-an-openshift-origin-cluster-with-the-ansible-service-broker) for spinning up OpenShift and the Service Broker for development.


#### Starting ARA and PostgreSQL

This is a very basic insecure install of PostgreSQL.  It is assumed that it will be used and thrown away after
debugging or development is complete.

```
# Login into OpenShift
oc login -u developer -p developer --insecure-skip-tls-verify https://172.31.51.52.nip.io:8443

# Create a project ara
oc new-project ara

# Add the ara template to the ara project
oc create -f https://raw.githubusercontent.com/jcpowermac/apb-with-ara/master/openshift-template.yaml

# Deploy the template - there is no configuration required.
oc new-app --template ara
```

#### Using ARA with APBs

To use PostgreSQL between projects a `nodePort` is created on `32345`.
The environmental variable `IPADDR` needs to be modified before use.


If you don't have a `Dockerfile-canary` create one and append.  There is an example of the
[Dockerfile-canary](example/Dockerfile-canary) the example directory.

```
apb init apb_name
cp Dockerfile{,-canary}

# This needs to be done before appending the additional configurations
# or parts of the file will be overwritte incorrectly.
apb prepare -f Dockerfile-canary

cat example/append-canary-dockerfile >> Dockerfile-canary
apb prepare -f Dockerfile-canary ; \
apb build --tag mariadb-apb -f Dockerfile-canary ; \
apb push -f Dockerfile-canary
```
