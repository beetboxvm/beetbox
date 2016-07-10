# Building a base box

beetbox builds are 100% automated, every commit to the master branch will trigger a new build of [`beet/dev`](https://atlas.hashicorp.com/beet).

Therefore, `beet/dev` is the latest build and is used as the release candiate when creating new versions.

# Creating a new version

When a [new release](https://help.github.com/articles/creating-releases/) is made a tag is generated in the repo, this will trigger another CI run based on the tag.
If the CI run completes successfully and notices a tag has been created it will trigger a new packer build of [`beet/box`](https://atlas.hashicorp.com/beet) on Atlas.
