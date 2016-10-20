genrule(
    name = "guava_ln",
    srcs = [":guava"],
    cmd = "ROOT=$$PWD && ln -s $$ROOT/$< $@",
    outs = ["guava.zip"],
)    

java_library(
    name = "guava",
    exports = ["@guava//jar"],
)
