### Reproducer for bazel issue 1966, regression introduced in 0.3.2 release

To reproduce [the issue](https://github.com/bazelbuild/bazel/issues/1966)

```
  $ bazel build :guava_ln --verbose_failures --subcommands
INFO: Found 1 target...
>>>>> # //:guava_ln [action 'Executing genrule //:guava_ln']
(cd /home/davido/.cache/bazel/_bazel_davido/1c05526fe8c8cba2b825c0ac3eea91e4/execroot/bazel_test && \
  exec env - \
    PATH=/u01/app/oracle/product/11.2.0/xe/bin:/home/davido/pgm/pt:/opt/apache-maven-3.0.5/bin:/u01/app/oracle/product/11.2.0/xe/bin:/home/davido/pgm/pt:/opt/apache-maven-3.0.5/bin:/home/davido/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games:/opt/kde3/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/lib/qt3/bin:/home/davido/pgm/go/bin:/bin:/home/davido/pgm/go/bin:/home/davido/pgm/gocode/bin \
  /bin/bash -c 'source external/bazel_tools/tools/genrule/genrule-setup.sh; ROOT=$PWD && ln -s $ROOT/bazel-out/local-fastbuild/bin/libguava.jar bazel-out/local-fastbuild/genfiles/guava.zip')
ERROR: /home/davido/projects/bazel_test/BUILD:1:1: declared output 'guava.zip' is a dangling symbolic link.
ERROR: /home/davido/projects/bazel_test/BUILD:1:1: not all outputs were created.
Target //:guava_ln failed to build
INFO: Elapsed time: 0.161s, Critical Path: 0.06s

$ ls -all bazel-out/local-fastbuild/genfiles/guava.zip
lrwxrwxrwx 1 davido users 188 Oct 20 21:31 bazel-out/local-fastbuild/genfiles/guava.zip -> /home/davido/.cache/bazel/_bazel_davido/1c05526fe8c8cba2b825c0ac3eea91e4/bazel-sandbox/f28a81d2-85db-4e7d-84e0-e4b8d91397d5-0/execroot/bazel_test/bazel-out/local-fastbuild/bin/libguava.jar
```

**Note**, that all is fine on 0.3.1 release:

```
$ bazel version
Build label: 0.3.1

$ bazel build :guava_ln --verbose_failures --subcommands 
INFO: Found 1 target...
>>>>> # //:guava_ln [action 'Executing genrule //:guava_ln']
(cd /home/davido/.cache/bazel/_bazel_davido/1c05526fe8c8cba2b825c0ac3eea91e4/execroot/bazel_test && \
  exec env - \
    PATH=/u01/app/oracle/product/11.2.0/xe/bin:/home/davido/pgm/pt:/opt/apache-maven-3.0.5/bin:/u01/app/oracle/product/11.2.0/xe/bin:/home/davido/pgm/pt:/opt/apache-maven-3.0.5/bin:/home/davido/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games:/opt/kde3/bin:/usr/lib/mit/bin:/usr/lib/mit/sbin:/usr/lib/qt3/bin:/home/davido/pgm/go/bin:/bin:/home/davido/pgm/go/bin:/home/davido/pgm/gocode/bin \
  /bin/bash -c 'source external/bazel_tools/tools/genrule/genrule-setup.sh; ROOT=$PWD && ln -s $ROOT/bazel-out/local-fastbuild/bin/libguava.jar bazel-out/local-fastbuild/genfiles/guava.zip')
Target //:guava_ln up-to-date:
  bazel-genfiles/guava.zip
INFO: Elapsed time: 3.644s, Critical Path: 0.07s

davido@linux-ucwl:~/projects/bazel_test (master %=)$ ls -all bazel-out/local-fastbuild/genfiles/guava.zip
lrwxrwxrwx 1 davido users 135 Oct 20 21:28 bazel-out/local-fastbuild/genfiles/guava.zip -> /home/davido/.cache/bazel/_bazel_davido/1c05526fe8c8cba2b825c0ac3eea91e4/execroot/bazel_test/bazel-out/local-fastbuild/bin/libguava.jar
```
