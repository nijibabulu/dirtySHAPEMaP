# required packages: ggseqlogo

generate_seqlogos <- function(base, n) {
  pwm_df <- readr::read_tsv(glue::glue("results/{base}/{base}.95seqs.counts"),
                            col_names = c("A", "C", "G", "T")) |>
    tibble::rowid_to_column() |>
    tibble::column_to_rownames("rowid")
  pwm <- t(as.matrix(pwm_df))

  # compute position-wise Shannon's entropy
  pwm_en <- apply(pwm, 2, \(col) -sum(col*log2(col), na.rm = T))

  # compute small sample correction (not really needed)
  e_n <- 1/log(2) * 3 / (2*n)

  # compute the information content of each base at each position
  pwm_ic <- log2(4) - (e_n + rep(pwm_en,each=4))

  # compute the height of each letter as a product of information content and frequency
  pwm_ri <- pwm*pwm_ic

  full_plot <-
    ggseqlogo::ggseqlogo(pwm_ri, method = "custom") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))

  trimmed_plot <-
    ggseqlogo::ggseqlogo(pwm_ri[,19:77], method = "custom") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))

  full_fplot <-
    ggseqlogo::ggseqlogo(pwm, method = "custom") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))

  trimmed_fplot <-
    ggseqlogo::ggseqlogo(pwm[,19:77], method = "custom") +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))


  ggplot2::ggsave(glue::glue("results/{base}/full_seq_logo.png"),
                  full_plot, width = 15, height = 4)
  ggplot2::ggsave(glue::glue("results/{base}/trimmed_seq_logo.png"),
                  trimmed_plot, width = 12, height = 4)

  ggplot2::ggsave(glue::glue("results/{base}/full_seq_logo_freq.png"),
                  full_fplot, width = 15, height = 4)
  ggplot2::ggsave(glue::glue("results/{base}/trimmed_seq_logo_freq.png"),
                  trimmed_fplot, width = 12, height = 4)
}

generate_seqlogos("lib_y7oDUzWh-01", 6538407)
generate_seqlogos("lib_y7oDUzWh-02", 15519050)
