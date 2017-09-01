java_library(
    name = "printy_lib",
    srcs = glob(["src/main/java/**/*.java"]),
    deps = ["@guava//jar"],
)

genrule(
    name = "gen_version",
    stamp = 1,
    cmd = "echo $$(cat bazel-out/stable-status.txt | grep PRINTY | cut -d ' ' -f 2) > $@",
    outs = ["gen_version.txt"],
)

java_binary(
    name = "printy",
    deploy_manifest_lines = [
        "Implementation-Vendor: Gerrit User Conference 2016",
    ],
    main_class = "org.gerritcon.mv2016.Printy",
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
        "GEN_VERSION=$$(cat $$r/$(location :gen_version.txt))",
        "echo \"Implementation-Version: $$GEN_VERSION\n$$(cat META-INF/MANIFEST.MF)\" > META-INF/MANIFEST.MF",
        "zip -qr $$r/$@ ."]),
    outs = ["printy_stamped.jar"],
)
