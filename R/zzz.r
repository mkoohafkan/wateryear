.onAttach = function(libname, pkgname) {
  wyopt = getOption("wateryear.default")
  ryopt = getOption("wateryear.reference")

  msg = NULL
  if (!is.null(wyopt)) {
    msg = append(msg, tryCatch(do.call(set_wateryear, wyopt),
      message = function(m) conditionMessage(m)))
  }
  if (!is.null(ryopt)) {
    msg = append(msg, tryCatch(do.call(set_referenceyear, as.list(ryopt)),
      message = function(m) conditionMessage(m)))
  }
  if (any(!is.null(msg))) {
    packageStartupMessage(paste(msg, collapse = ""))
  }
}
