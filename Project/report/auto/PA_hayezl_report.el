(TeX-add-style-hook
 "PA_hayezl_report"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("scrartcl" "a4paper" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("xcolor" "usenames" "svgnames") ("mdframed" "framemethod=tikz") ("enumitem" "inline") ("babel" "english")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "scrartcl"
    "scrartcl11"
    "inputenc"
    "fontenc"
    "graphicx"
    "wrapfig"
    "geometry"
    "lmodern"
    "fancyhdr"
    "color"
    "colortbl"
    "booktabs"
    "xcolor"
    "amsmath"
    "amssymb"
    "mathrsfs"
    "amsthm"
    "thmtools"
    "mdframed"
    "pgf"
    "pgfplots"
    "tikz"
    "hyperref"
    "makeidx"
    "enumitem"
    "babel")
   (TeX-add-symbols
    "N"
    "Q"
    "R"
    "Z"
    "C"
    "K")
   (LaTeX-add-labels
    "table:construction-heuristics"
    "table:greedy-local-search"
    "table:simulated-annealing-metropolis"
    "table:simulated-annealing-heatbath"
    "sec:trace-best-solution"
    "fig:solpath-bestinsertion"
    "fig:solpath-GLS"
    "fig:solpath-SA-metropolis"
    "fig:solpath-SA-heatBath"
    "sec:performance-plots"
    "fig:perfPlot-GLS"
    "fig:perfPlot-SA-metropolis"
    "fig:perfPlot-SA-heatBath"
    "sec:pairw-comp-algor"
    "table:pairwise-comparison"))
 :latex)

