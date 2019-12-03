---
title: Differences about Docker in k8s
date: 2019-12-03 15:50:36
tags:
- k8s
- docker
---


## Difference between Docker ENTRYPOINT and Kubernetes container spec COMMAND

Kubernetes provides us with multiple options on how to use these commands:

When you override the default Entrypoint and Cmd in Kubernetes .yaml file, these rules apply:

-   If you do not supply command or args for a Container, the defaults defined in the Docker image are used.
-   If you supply a command but no args for a Container, only the supplied command is used. The default EntryPoint and the default Cmd defined in the Docker image are ignored.
-   If you supply only args for a Container, the default Entrypoint defined in the Docker image is run with the args that you supplied.
-   If you supply a command and args, the default Entrypoint and the default Cmd defined in the Docker image are ignored. Your command is run with your args.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE1MTczNTI0OTFdfQ==
-->