local({
    if (
        # running in vim
        !is.na(Sys.getenv("VIM", unset = NA)) &&
        # get the original lib paths where nvimcom is installed
        !is.na(ori_libs <- Sys.getenv("R_LIBS_USER", unset = NA)) &&
        # test if nvimcom is there
        dir.exists(nvimcom <- file.path(ori_libs, "nvimcom"))
    ) {
            tmp_libs <- file.path(Sys.getenv("TMP", unset = tempdir()), "NVIMR")
            if (!dir.exists(tmp_libs)) dir.create(tmp_libs)
            file.copy(nvimcom, tmp_libs, recursive = TRUE)

            options(renv.settings.external.libraries = tmp_libs)
    }
})

source("renv/activate.R")
