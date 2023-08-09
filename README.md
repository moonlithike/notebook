This repo helps create a docker image with an emac instance running org-roam and org-roam-ui that volumes in a notes directory on the host.


Steps:

1. Build Dockerfile to create a basic image with archlinux, emacs, and some misc. 

```
$ docker build .
```

2. Run the image and start emacs to run initial spacemacs setup.

Host:
```
$ docker run --network host -v /path/to/your/roam-files:/files -it {image_hash} bash
```

Inside the container:
```
$ emacs
```

3. Add roam and roam-ui support in your `dotspacemacs-configuration-layers` block.

```
(org +roam2
:variables
org-enable-roam-support t
org-enable-roam-ui t)
```

Reload the config
`<space> f e R`

4. Add your roam configuration in `dotspacemacs/user-config`
```
(use-package org-roam
:ensure t
:custom
(org-roam-directory "/files")
:config
(org-roam-db-autosync-mode))
```

5. Check around that everything works:
* you can start emacs without error
* you can run org-roam and access the files in your volumed directory
* you can run roam-ui and access it from your host

6. Next, commit this image so that you can run it in the future:

On the host machine (while the container above continues running):

```
$ docker ps # find the container hash
$ docker commit {container_hash}
$ docker images # find the new image hash
$ docker tag {image_hash) notebook
```

Now you can run a fresh container from the image with:
```
docker run --network host -v /host/path:/container/path -it notebook emacs
```
