#java_library(
#    name = "guava",
#    exports = ["@guava//jar"],
#)

java_library(
    name = "printy_lib",
    srcs = glob(['src/main/java/**/*.java']),
    deps = ['@guava//jar'],
)

genrule(
    name = "gen_version",
    stamp = 1,
    cmd = "echo \"Implementation-Version: $$(cat bazel-out/stable-status.txt | grep PRINTY | cut -d ' ' -f 2)\" > $@",
    outs = ["gen_version.txt"],
)

java_binary(
    name = "printy",
    deploy_manifest_lines = [
        "Implementation-Version: 42", 
        "Implementation-Vendor: Gerrit User Conference 2016",
    ],
    main_class = 'org.gerritcon.mv2016.Printy',
    runtime_deps = [":printy_lib"],
)

genrule(
    name = "printy_stamped",
    srcs = [":printy_deploy.jar"],
    tools = [":gen_version.txt"],
    cmd = " && ".join([
        "r=$$PWD",
        "t=$$(mktemp -d)",
        "cd $$t",
        "unzip -q $$r/$<",
        "cat META-INF/MANIFEST.MF | grep -v Implementation-Version | grep : > META-INF/MANIFEST.MF.new",
        "mv META-INF/MANIFEST.MF.new META-INF/MANIFEST.MF",
        "cat $$r/$(location :gen_version.txt) >> META-INF/MANIFEST.MF",
        "zip -qr $$r/$@ ."]),
    outs = ["printy_stamped.jar"],
)
        
        
        

genrule(
   name = "echo",
   cmd = "echo bar > $@",
   outs = ["out.txt"],
)

#WORDS = ['foo', 'bar', 'baz']

#for w in WORDS:
#    genrule(
#        name = w,
#        cmd = "echo %s > $@" % w,
#        outs = ["%s.txt" % w],
#    )
