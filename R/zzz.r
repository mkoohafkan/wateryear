.onAttach = function(libname, pkgname) {
  wyopt = getOption("wateryear.default")

  if (!is.null(wyopt)) {
    packageStartupMessage(tryCatch(do.call(set_wateryear, wyopt),
      message = function(m) conditionMessage(m)))
  }
}
