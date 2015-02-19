# godeploy
Sample Application That Demonstrates How We Deploy @ Codecademy

## Requirements
 * Ruby
 * Python
 * AWS CLI Tools `pip install awscli`
 * AWS Account and access keys available as ENV Vars `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`
 * An S3 Bucket
 * Replace the `godeploy` bucket with your bucket in the following locations.
   * [contrib/deploy](contrib/deploy#L11)
   * [contrib/fetch](contrib/fetch#L2)
   * [Makefile](Makefile#L21)

## Deployment
### make publish
 * Compiles
 * Builds Tarball
 * Uploads Tarball to s3_bucket/builds

### ./contrib/deploy builds
Displays a list of published builds
```
$ ./contrib/deploy builds
GIT SHA                                   GIT BRANCH                     BUILD DATE
4e442671b948a41821eab6cc1040d1e0c753326e  master                         2015-02-19 03:02:00 -0500
ac851020f4124bc07bbabe70521ad25eb1189ba4  master                         2015-02-19 02:57:29 -0500
```

### ./contrib/deploy tag
Copies published tarball from build directory to tag directory
```
$ ./contrib/deploy tag --sha 4e442671b948a41821eab6cc1040d1e0c753326e --tag staging
Success! Tagged 4e442671b948a41821eab6cc1040d1e0c753326e to staging.
```

### ./contrib/deploy tags
Lists tags and current version
```
$ ./contrib/deploy tags
TAG              GIT SHA                                    PUBLISH DATE
staging          4e442671b948a41821eab6cc1040d1e0c753326e   2015-02-19 03:02:43 -0500
production       ac851020f4124bc07bbabe70521ad25eb1189ba4   2015-02-19 02:50:47 -0500
```

### ./contrib/fetch
Fetches tagged tarball, assumed production, from s3 into deployed directory.
