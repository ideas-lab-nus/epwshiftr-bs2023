library(targets)
library(tarchetypes)

tar_source("R")

list(
    tar_target(dir_paper, "full-paper"),

    # commit SHA of the original paper
    tar_target(ref_ori, "6c7996eb"),
    # commit SHA of the paper after response to 1st round review
    tar_target(ref_1st, "ee712a3a"),
    # commit SHA of the final paper, NULL for current commit
    tar_target(ref_final, NULL),

    # render full paper
    tar_file(rmd_paper, file.path(dir_paper, "paper.Rmd")),
    tar_file(deps_paper, rmd_deps(rmd_paper)),
    tar_change(pdf_paper, render_rmd(rmd_paper, ref_final), deps_paper, format = "file"),

    # render 1st round response to reviewer comments
    tar_file(rmd_1st_resp, file.path(dir_paper, "reviews", "1st-round-resp.Rmd")),
    tar_file(deps_1st_resp, rmd_deps(rmd_1st_resp)),
    tar_change(pdf_1st_resp, render_rmd(rmd_1st_resp), deps_1st_resp, format = "file"),

    # track revisions using latexdiff
    tar_file(file_latexdiff, latexdiff(ref_ori, ref_1st, rmd_paper, "reviews/1st-round-diff.tex")),
    tar_file(pdf_1st_resp_diff, render_diff(rmd_paper, file_latexdiff, ref_ori, ref_1st)),

    # pack the final tex bundle for submission
    tar_file(zip_paper, pack_tex(pdf_paper[tools::file_ext(pdf_paper) == "tex"], deps_paper))
)
