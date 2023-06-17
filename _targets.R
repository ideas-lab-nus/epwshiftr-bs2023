library(targets)
library(tarchetypes)

tar_source("R")

list(
    tar_target(dir_paper, "full-paper"),

    # render full paper
    tar_file(rmd_paper, file.path(dir_paper, "paper.Rmd")),
    tar_file(deps_paper, rmd_deps(rmd_paper)),
    tar_change(pdf_paper, render_rmd(rmd_paper), deps_paper, format = "file"),

    # render 1st round response to reviewer comments
    tar_file(rmd_1st_resp, file.path(dir_paper, "reviews", "1st-round-resp.Rmd")),
    tar_file(deps_1st_resp, rmd_deps(rmd_1st_resp)),
    tar_change(pdf_1st_resp, render_rmd(rmd_1st_resp), deps_1st_resp, format = "file"),

    # track revisions using latexdiff
    tar_target(ref_ori, "6c7996eb"),
    tar_target(ref_1st, "52db17a8"),
    tar_file(file_latexdiff, latexdiff(ref_ori, ref_1st, rmd_paper, "reviews/1st-round-diff.tex")),
    tar_file(pdf_1st_resp_diff, render_diff(rmd_paper, file_latexdiff, ref_ori, ref_1st))
)