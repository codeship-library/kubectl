# codeship/kubectl container

`kubectl` binary container, with guidance for configuring credentials (including secrets) to issue commands to your cluster from a Codeship Pro step.

## Distill your k8s configurations to single file

```shell
kubectl config view --flatten > kubeconfigdata # add --minify flag to reduce info to current context
```

## Copy contents to env var file using our codeship/env-var-helper container

```shell
docker run --rm -it -v $(pwd):/files codeship/env-var-helper cp kubeconfigdata:/root/.kube/config k8s-env
```

Check out the [codeship/env-var-helper README](https://github.com/codeship-library/docker-utilities/tree/master/env-var-helper) for more information.

## Encrypt the file, remove files and/or add to `.gitignore`

jet encrypt k8s-env k8s-env.encrypted
rm kubeconfigdata k8s-env

## Configure the service and steps into the build with the following as guidance

```shell
# codeship-services.yml

kubectl:
  build:
    image: codeship/kubectl
    dockerfile: Dockerfile
  encrypted_env_file: k8s-env.encrypted
```

```shell
# codeship-steps.yml

- name: check response to kubectl config
  service: kubectl
  command: kubectl config view
```
